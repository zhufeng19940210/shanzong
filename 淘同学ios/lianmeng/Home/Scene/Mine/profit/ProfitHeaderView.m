//
//  ProfitHeaderView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ProfitHeaderView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
@interface ProfitHeaderView()
@property(nonatomic,retain)UILabel *tipsLabel;
@property(nonatomic,retain)UILabel *totalMoney;
@property(nonatomic,retain)UIButton *todayBtn;
@property(nonatomic,retain)UIButton *yesterdayBtn;
@property(nonatomic,retain)UIButton *monthBtn;
@property(nonatomic,retain)UIButton *lastMonthBtn;
@property(nonatomic,retain)UIView *whiteLine;
@property(nonatomic,retain)MASConstraint *constraint;
@end
@implementation ProfitHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithString:@"#f33019"].CGColor, (__bridge id)[UIColor colorWithString:@"#f47018"].CGColor];
        gradientLayer.locations = @[@0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.layer addSublayer:gradientLayer];
        
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.text = @"我通过淘同学赚了";
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        [self addSubview:_tipsLabel];
        
        _totalMoney = [[UILabel alloc]init];
        _totalMoney.textColor = [UIColor whiteColor];
        _totalMoney.font = [UIFont fontWithName:MediumFont size:30.0f];
        
        NSString *text = @"0.00元";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:15.0f] range:NSMakeRange(text.length - 1, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:30.0f] range:NSMakeRange(0, text.length - 1)];
        _totalMoney.attributedText = str;
        
        [self addSubview:_totalMoney];
        
        _todayBtn = [[UIButton alloc]init];
        _todayBtn.tag = 1;
        _todayBtn.titleLabel.textColor = [UIColor whiteColor];
        _todayBtn.titleLabel.font = [UIFont fontWithName:BoldFont size:15.0f];
        [_todayBtn setTitle:@"今日" forState:UIControlStateNormal];
        [self addSubview:_todayBtn];
        
        
        _yesterdayBtn = [[UIButton alloc]init];
         _yesterdayBtn.tag = 2;
        _yesterdayBtn.titleLabel.textColor = [UIColor whiteColor];
        _yesterdayBtn.titleLabel.font = [UIFont fontWithName:BoldFont size:15.0f];
        [_yesterdayBtn setTitle:@"昨日" forState:UIControlStateNormal];
        [self addSubview:_yesterdayBtn];
        
        _monthBtn = [[UIButton alloc]init];
        _monthBtn.tag = 3;
        _monthBtn.titleLabel.textColor = [UIColor whiteColor];
        _monthBtn.titleLabel.font = [UIFont fontWithName:BoldFont size:15.0f];
        [_monthBtn setTitle:@"本月" forState:UIControlStateNormal];
        [self addSubview:_monthBtn];
        
        _lastMonthBtn = [[UIButton alloc]init];
        _lastMonthBtn.tag = 4;
        _lastMonthBtn.titleLabel.textColor = [UIColor whiteColor];
        _lastMonthBtn.titleLabel.font = [UIFont fontWithName:BoldFont size:15.0f];
        [_lastMonthBtn setTitle:@"上月" forState:UIControlStateNormal];
        [self addSubview:_lastMonthBtn];
        
        _whiteLine = [[UIView alloc]init];
        _whiteLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteLine];
        
        [_todayBtn addTarget:self action:@selector(touchButton:)
            forControlEvents:UIControlEventTouchUpInside];
        [_yesterdayBtn addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [_monthBtn addTarget:self action:@selector(touchButton:)
            forControlEvents:UIControlEventTouchUpInside];
        [_lastMonthBtn addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(kStatusBarAndNavigationBarHeight + 25.0f));
    }];
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(10.0f);
    }];
    
    NSArray *list = @[_todayBtn,_yesterdayBtn,_monthBtn,_lastMonthBtn];
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(self);
    }];
    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60.0f leadSpacing:15.0f tailSpacing:15.0f];
    
    [_whiteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@2.0f);
        make.width.equalTo(@17.5f);
        make.bottom.equalTo(self);
        self.constraint = make.centerX.equalTo(self.todayBtn);
    }];
}

-(void)touchButton:(UIButton *)btn{
    [self.constraint uninstall];
    [_whiteLine mas_updateConstraints:^(MASConstraintMaker *make) {
        self.constraint = make.centerX.equalTo(btn);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
       [self layoutIfNeeded];
    }];
    if (self.delegate) {
        [self.delegate selectIndex:btn.tag];
    }
}

-(void)reloadData:(NSString *)str{
    _totalMoney.text = [NSString stringWithFormat:@"%@元",str];
}

@end
