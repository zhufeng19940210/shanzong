//
//  ProfitLargeLabelView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfitLargeLabelView : UIImageView
-(void)setValue:(NSString *)value;
-(instancetype)initWithTitle:(NSString *)title withBgImage:(UIImage *)image;
@end
