//
//  ImageShowCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ImageShowCell.h"
#import <EasyIOS/EasyIOS.h>

@interface ImageShowCell()
@property(nonatomic,retain)UIImageView *checkImageView;
@property(nonatomic,retain)UIImageView *imageView;
@end
@implementation ImageShowCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageView];
        _imageView.image = [UIImage imageNamed:@""];
        
        _checkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 13.0f, 2.0f,10.5f, 10.5f)];
        [self addSubview:_checkImageView];
        _checkImageView.image = [UIImage imageNamed:@"shareCheck0"];
    }
    return self;
}

-(void)setImageURL:(NSString *)url{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url]];
}

-(void)selectImage{
    _checkImageView.image = [UIImage imageNamed:@"shareCheck1"];
}

-(void)setSelected:(BOOL)selected{
    if (selected) {
        _checkImageView.image = [UIImage imageNamed:@"shareCheck1"];
    }else{
        _checkImageView.image = [UIImage imageNamed:@"shareCheck0"];
    }
}
@end
