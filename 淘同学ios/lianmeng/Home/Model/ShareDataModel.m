//
//  ShareDataself.m
//  lianmeng
//
//  Created by zhuchao on 2018/8/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ShareDataModel.h"
#import <UIKit/UIKit.h>

#import <CoreText/CoreText.h>
#import <CoreImage/CoreImage.h>
#import <EasyIOS/EasyIOS.h>


@implementation ShareDataItemModel


-(UIImage *)genImage{
    
    NSLog(@"过来了吗");
    NSString *title = self.itmeInfo.itemTitle;
    NSString *pic = self.itmeInfo.itemPic;
    NSString *price = [NSString stringWithFormat:@"￥%.2f",self.itmeInfo.itemPrice.floatValue - self.itmeInfo.couponPrice.floatValue];
    
    NSString *platform = self.itmeInfo.platformId == 1?(self.itmeInfo.shopType.integerValue == 0?@"淘宝":@"天猫"):@"京东";
    NSString *originPrice = [NSString stringWithFormat:@"%@价:￥%.2f",platform,self.itmeInfo.itemPrice.floatValue];
    
    NSString *personCount = [NSString stringWithFormat:@"%ld人已领",(long)(self.itmeInfo.couponNum.integerValue - self.itmeInfo.couponSurplusl.integerValue)];
    NSString *yhq = [NSString stringWithFormat:@"%@",self.itmeInfo.couponPrice];
    NSString *qrCode = self.shareUrl;
    UIGraphicsBeginImageContext(CGSizeMake(750,1334));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, 1334);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0,0,750,1334),[UIImage imageNamed:@"shareImageBg"].CGImage);
    
    NSMutableAttributedString* attStringTemp = [[NSMutableAttributedString alloc]initWithString:title];
    [attStringTemp addAttribute:(NSString*)(kCTForegroundColorAttributeName)
                          value:(id)[[UIColor whiteColor]CGColor]
                          range:NSMakeRange(0,[title length])];
    [attStringTemp addAttribute:NSFontAttributeName
                          value:[UIFont boldSystemFontOfSize:26.0f]
                          range:NSMakeRange(0 ,[title length])];
    CTFrameDraw(CTFramesetterCreateFrame(CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStringTemp),
                                         CFRangeMake(0, attStringTemp.length), CGPathCreateWithRect(CGRectMake(84, 1334 - 87 - 65,582,65), nil), NULL), context);
    
    UIImage *image = [UIImage imageWithUrl:pic];
    CGContextDrawImage(context, CGRectMake(81,1334 - 588 - 180,588,588),image.CGImage);
    
    NSMutableAttributedString* priceAttStringTemp = [[NSMutableAttributedString alloc]initWithString:price];
    [priceAttStringTemp addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:24.0f] range:NSMakeRange(0, 1)];
    [priceAttStringTemp addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:55.0] range:NSMakeRange(1, price.length - 1)];
    [priceAttStringTemp addAttribute:(NSString*)(kCTForegroundColorAttributeName)
                               value:(id)[[UIColor colorWithString:@"#D6071C"]CGColor]
                               range:NSMakeRange(0,[price length])];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
    CGRect rect = [priceAttStringTemp boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,70)
                                                   options:options
                                                   context:nil];
    CTFrameDraw(CTFramesetterCreateFrame(CTFramesetterCreateWithAttributedString((CFAttributedStringRef)priceAttStringTemp),
                                         CFRangeMake(0, priceAttStringTemp.length),
                                         CGPathCreateWithRect(CGRectMake(84, 1334 - 818 - 70,rect.size.width,70), nil), NULL), context);
    
    
    NSMutableAttributedString* tbPriceStringTemp = [[NSMutableAttributedString alloc]initWithString:originPrice];
    [tbPriceStringTemp addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:24.0f] range:NSMakeRange(0, [originPrice length])];
    //    [tbPriceStringTemp addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, originPrice.length)];
    [tbPriceStringTemp addAttribute:(NSString*)(kCTForegroundColorAttributeName)
                              value:(id)[[UIColor colorWithString:@"#A4A5A5"]CGColor]
                              range:NSMakeRange(0,[originPrice length])];
    
    
    CTFrameDraw(CTFramesetterCreateFrame(CTFramesetterCreateWithAttributedString((CFAttributedStringRef)tbPriceStringTemp),
                                         CFRangeMake(0, tbPriceStringTemp.length),
                                         CGPathCreateWithRect(CGRectMake(rect.size.width + 100, 1334 - 818 - 70,250,40), nil), NULL), context);
    
    NSMutableAttributedString* countStringTemp = [[NSMutableAttributedString alloc]initWithString:personCount];
    [countStringTemp addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:24.0f] range:NSMakeRange(0, [personCount length])];
    [countStringTemp addAttribute:(NSString*)(kCTForegroundColorAttributeName)
                            value:(id)[[UIColor colorWithString:@"#828383"]CGColor]
                            range:NSMakeRange(0,[personCount length])];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentRight;//对齐方式
    [countStringTemp addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [countStringTemp length])];
    CTFrameDraw(CTFramesetterCreateFrame(CTFramesetterCreateWithAttributedString((CFAttributedStringRef)countStringTemp),
                                         CFRangeMake(0, countStringTemp.length),
                                         CGPathCreateWithRect(CGRectMake(750 - 84 - 150, 1334 - 818 - 70,150,40), nil), NULL), context);
    
    NSMutableAttributedString* yhqStringTemp = [[NSMutableAttributedString alloc]initWithString:yhq];
    [yhqStringTemp addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:30.0f] range:NSMakeRange(0, [yhq length])];
    [yhqStringTemp addAttribute:(NSString*)(kCTForegroundColorAttributeName)
                          value:(id)[[UIColor whiteColor]CGColor]
                          range:NSMakeRange(0,[yhq length])];
    NSMutableParagraphStyle * paragraphStyle2 = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle2.alignment = NSTextAlignmentRight;//对齐方式
    [yhqStringTemp addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [yhq length])];
    CTFrameDraw(CTFramesetterCreateFrame(CTFramesetterCreateWithAttributedString((CFAttributedStringRef)yhqStringTemp),
                                         CFRangeMake(0, yhqStringTemp.length),
                                         CGPathCreateWithRect(CGRectMake(100, 1334 - 1008,80,40), nil), NULL), context);
    
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:[qrCode dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    UIImage *qrImage = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:157.0f];
    CGContextDrawImage(context, CGRectMake(514.0f,1334 - 1114,157.0f,157.0f), qrImage.CGImage);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
@implementation ShareDataModel

@end
