//
//  ProfitBarView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ProfitBarView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>

@interface ProfitBarView()
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *moneyLabel;
@property(nonatomic,retain)UIImageView *barBgImageView;
@property(nonatomic,retain)UIImageView *barImageView;
@end

@implementation ProfitBarView

-(void)setValue:(NSString *)value{
    _moneyLabel.text = value;
}
-(instancetype)initWithTitle:(NSString *)title withBgImage:(UIImage *)image{
    self = [super init];
    if (self) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];
        _titleLabel.text = title;
        _titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [self addSubview:_titleLabel];
        
        
        _barBgImageView = [[UIImageView alloc]init];
        _barBgImageView.image = [UIImage imageNamed:@"huisedikuang"];
        [self addSubview:_barBgImageView];
        
        _barImageView = [[UIImageView alloc]init];
        _barImageView.image = image;
        [self addSubview:_barImageView];
        
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.text = @"0";
        _moneyLabel.font = [UIFont fontWithName:MediumFont size:18.0f];
        [self addSubview:_moneyLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self);
        }];
        
        [_barBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLabel.mas_right).offset(40.0f);
            make.width.equalTo(@220.0f);
        }];

        [_barImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.barBgImageView);
            make.width.equalTo(@100.0f);
        }];
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.barBgImageView).offset(10.0f);
            make.centerY.equalTo(self.barBgImageView);
        }];
        
    }
    return self;
}

@end
