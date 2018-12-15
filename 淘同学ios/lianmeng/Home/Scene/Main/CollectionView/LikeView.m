//
//  LikeView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "LikeView.h"
#import <Masonry/Masonry.h>
@implementation LikeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc]init];
        [image setImage:[UIImage imageNamed:@"cainixihuan"]];
        [self addSubview:image];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
           make.center.equalTo(self);
        }];
    }
    return self;
}

@end
