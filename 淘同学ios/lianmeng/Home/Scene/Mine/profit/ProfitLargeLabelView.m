//
//  ProfitLargeLabelView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ProfitLargeLabelView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface ProfitLargeLabelView()
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *moneyLabel;
@end

@implementation ProfitLargeLabelView

-(instancetype)initWithTitle:(NSString *)title withBgImage:(UIImage *)image{
    self = [super init];
    if (self) {
        self.image = image;
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = title;
        _titleLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        [self addSubview:_titleLabel];
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.text = @"0";
        _moneyLabel.font = [UIFont fontWithName:MediumFont size:18.0f];
        [self addSubview:_moneyLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(15.0f);
        }];
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10.0f);
        }];
        
    }
    return self;
}

-(void)setValue:(NSString *)value{
    _moneyLabel.text = value;
}
@end

