//
//  NavLeftView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "NavLeftView.h"
#import <Masonry/Masonry.h>

@interface NavLeftView()
@property(nonatomic,retain)UIView *titleLabel;
@property(nonatomic,retain)UIImageView *leftViewArrow;

@end

@implementation NavLeftView

-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        
        UIImageView *leftViewArrow = [[UIImageView alloc]init];
        _leftViewArrow = leftViewArrow;
        [leftViewArrow setImage:[UIImage imageNamed:@"leftViewArrow"]];
        [self addSubview:leftViewArrow];
        [leftViewArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5.0f);
            make.centerY.equalTo(self);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        _titleLabel = titleLabel;
        titleLabel.text = title;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftViewArrow.mas_right).offset(10.0f);
            make.centerY.equalTo(self);
            make.height.equalTo(@40.0f);
        }];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100.0f);
            make.height.equalTo(@40.0f);
        }];
        
    }
    return self;
}

@end
