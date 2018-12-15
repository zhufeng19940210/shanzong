//
//  MineCellView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/21.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MineCellView.h"

#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface MineCellView()
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *titleLabel;
@end
@implementation MineCellView

-(instancetype)initWithImage:(UIImage *)image title:(NSString *)title{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc]init];
        _imageView.image  = image;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        _titleLabel.text  = title;
        _titleLabel.textColor = [UIColor colorWithString:@"#888888"];
        [self addSubview:_titleLabel];
        
        UIImageView *rightIcon = [[UIImageView alloc]init];
        rightIcon.image = [UIImage imageNamed:@"zuola"];
        [self addSubview:rightIcon];
        [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-20.0f);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.equalTo(@0.5f);
            make.right.bottom.equalTo(self);
            make.left.equalTo(self).offset(50.0f);
        }];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(20.0f);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self);
           make.left.equalTo(self.imageView.mas_right).offset(25.0f);
        }];
    }
    return self;
}


@end
