//
//  YouhuiQuanView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/17.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "YouhuiQuanView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface YouhuiQuanView()
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *yhqLabel;
@property(nonatomic,retain)UIButton *switchIcon;
@end

@implementation YouhuiQuanView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"search-youhuiquan"];
        [self addSubview:_iconImageView];
        
        _yhqLabel = [[UILabel alloc]init];
        _yhqLabel.text = @"只搜索优惠券商品";
        _yhqLabel.textColor = [UIColor colorWithString:@"#323232"];
        _yhqLabel.font = [UIFont fontWithName:RegularFont size:12.0f];
        [self addSubview:_yhqLabel];
        
        _switchIcon = [[UIButton alloc]init];
        [_switchIcon setImage:[UIImage imageNamed:@"search-yhq0"] forState:UIControlStateNormal];
        [_switchIcon setImage:[UIImage imageNamed:@"search-yhq1"] forState:UIControlStateSelected];
        [_switchIcon addTarget:self action:@selector(switchSearch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_switchIcon];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15.0f);
    }];
    
    [_yhqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
       make.left.equalTo(self.iconImageView.mas_right).offset(10.0f);
    }];
    
    [_switchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15.0f);
    }];
}

-(void)switchSearch{
    _switchIcon.selected = !_switchIcon.selected;
    if (self.delegate) {
        [self.delegate switchYHQ:_switchIcon.selected?1:0];
    }
}
@end

