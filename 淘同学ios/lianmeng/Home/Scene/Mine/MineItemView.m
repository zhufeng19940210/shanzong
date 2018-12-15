//
//  MineItemView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/21.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MineItemView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface MineItemView()
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *titleLabel;

@end
@implementation MineItemView

-(instancetype)initWithImage:(UIImage *)image title:(NSString *)title{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        _titleLabel.text  = title;
        _titleLabel.textColor = [UIColor colorWithString:@"#888888"];
        [self addSubview:_titleLabel];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-20.0f);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(20.0f);
        }];

    }
    return self;
}


@end
