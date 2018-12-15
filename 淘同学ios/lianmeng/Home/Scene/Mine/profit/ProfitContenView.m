//
//  ProfitContenView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ProfitContenView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "ProfitLargeLabelView.h"
#import "ProfitBarView.h"
#import "ProfitLargeLabelView.h"
#import "ProfitBarView.h"

@interface ProfitContenView()
@property(nonatomic,retain)UILabel *moneyLabel;

@property(nonatomic,retain)UILabel *titleTip1;

@property(nonatomic,retain)ProfitLargeLabelView *labelView1;
@property(nonatomic,retain)ProfitLargeLabelView *labelView2;
@property(nonatomic,retain)ProfitBarView *barView1;
@property(nonatomic,retain)ProfitBarView *barView2;


@property(nonatomic,retain)UILabel *titleTip2;
@property(nonatomic,retain)ProfitLargeLabelView *labelView3;
@property(nonatomic,retain)ProfitLargeLabelView *labelView4;
@property(nonatomic,retain)ProfitBarView *barView3;
@property(nonatomic,retain)ProfitBarView *barView4;

@end
@implementation ProfitContenView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithString:@"#EEEEEE"];
        UIView *moneyBg = [[UIView alloc] init];
        moneyBg.backgroundColor = [UIColor whiteColor];
        [self addSubview:moneyBg];
        
        [moneyBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@51.0f);
        }];
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont fontWithName:RegularFont size:15.0f];
        _moneyLabel.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];
        _moneyLabel.text = @"收益：0元";
        [moneyBg addSubview:_moneyLabel];
        
        
        UIView *bg = [[UIView alloc]init];
        bg.backgroundColor = [UIColor whiteColor];
        [self addSubview:bg];
        
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(self);
           make.top.equalTo(moneyBg.mas_bottom).offset(10.0f);
           make.bottom.equalTo(self);
        }];
        
        UIView *blackTip1 = [[UIView alloc]init];
        blackTip1.backgroundColor = [UIColor blackColor];
        [bg addSubview:blackTip1];
        [blackTip1 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.equalTo(@3.0f);
            make.left.equalTo(bg).offset(17.0f);
            make.top.equalTo(bg).offset(15.0f);
            make.height.equalTo(@22.0f);
        }];
        
        UILabel *titleTip1 = [[UILabel alloc]init];
        _titleTip1 = titleTip1;
        titleTip1.text = @"我的订单收益";
        titleTip1.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];
        titleTip1.font = [UIFont fontWithName:BoldFont size:15.0f];
        [bg addSubview:titleTip1];

        [titleTip1 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(blackTip1.mas_right).offset(15.0f);
            make.centerY.equalTo(blackTip1);
        }];
        
        _labelView1 = [[ProfitLargeLabelView alloc]initWithTitle:@"淘宝预估收入" withBgImage:[UIImage imageNamed:@"taobaoyugu"]];
        [bg addSubview:_labelView1];
        
        _labelView2 = [[ProfitLargeLabelView alloc]initWithTitle:@"京东预估收入" withBgImage:[UIImage imageNamed:@"jingdongyugu"]];
        [bg addSubview:_labelView2];
        
        _barView1 = [[ProfitBarView alloc]initWithTitle:@"淘宝订单数" withBgImage:[UIImage imageNamed:@"taobaodingdanshu"]];
        [bg addSubview:_barView1];
        _barView2 = [[ProfitBarView alloc]initWithTitle:@"京东订单数" withBgImage:[UIImage imageNamed:@"jingdongdingdanshu"]];
        [bg addSubview:_barView2];
        
        
        UIView *blackTip2 = [[UIView alloc]init];
        blackTip2.backgroundColor = [UIColor blackColor];
        [bg addSubview:blackTip2];
        [blackTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@3.0f);
            make.left.equalTo(bg).offset(17.0f);
            make.top.equalTo(self.barView2.mas_bottom).offset(15.0f);
            make.height.equalTo(@22.0f);
        }];
        
        UILabel *titleTip2 = [[UILabel alloc]init];
        _titleTip2 = titleTip2;
        titleTip2.text = @"团队订单收益";
        titleTip2.textColor = [UIColor colorWithString:@"rgb(51,51,51)"];
        titleTip2.font = [UIFont fontWithName:BoldFont size:15.0f];
        [bg addSubview:titleTip2];

        [titleTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blackTip2.mas_right).offset(15.0f);
            make.centerY.equalTo(blackTip2);
        }];

        
        
        _labelView3 = [[ProfitLargeLabelView alloc]initWithTitle:@"淘宝预估收入" withBgImage:[UIImage imageNamed:@"taobaoyugu"]];
        [bg addSubview:_labelView3];
        
        _labelView4 = [[ProfitLargeLabelView alloc]initWithTitle:@"京东预估收入" withBgImage:[UIImage imageNamed:@"jingdongyugu"]];
        [bg addSubview:_labelView4];
        
        _barView3 = [[ProfitBarView alloc]initWithTitle:@"淘宝订单数" withBgImage:[UIImage imageNamed:@"taobaodingdanshu"]];
        [bg addSubview:_barView3];
        _barView4 = [[ProfitBarView alloc]initWithTitle:@"京东订单数" withBgImage:[UIImage imageNamed:@"jingdongdingdanshu"]];
        [bg addSubview:_barView4];
        
    
        
        [self loadAutoLayout];
        
        
    }
    return self;
}

-(void)loadAutoLayout{

    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.moneyLabel.superview);
        make.left.equalTo(self.moneyLabel.superview).offset(15.0f);
    }];
    [_labelView1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.labelView1.superview).offset(17.0f);
        make.top.equalTo(self.titleTip1.mas_bottom).offset(17.0f);
        make.height.equalTo(@74.0f);
    }];
    [_labelView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelView1.mas_right).offset(25.0f);
        make.top.equalTo(self.labelView1);
        make.height.equalTo(@74.0f);
        make.right.equalTo(self.labelView2.superview).offset(-17.0f);
    }];
    [_barView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelView1);
        make.right.equalTo(self.labelView2);
        make.height.equalTo(@45.0f);
        make.top.equalTo(self.labelView1.mas_bottom).offset(15.0f);;
    }];
    
    [_barView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelView1);
        make.right.equalTo(self.labelView2);
        make.top.equalTo(self.barView1.mas_bottom);
        make.height.equalTo(@45.0f);
    }];
    
    
    [_labelView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelView3.superview).offset(17.0f);
        make.top.equalTo(self.titleTip2.mas_bottom).offset(17.0f);
        make.height.equalTo(@74.0f);
    }];
    [_labelView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelView3.mas_right).offset(25.0f);
        make.top.equalTo(self.labelView3);
        make.height.equalTo(@74.0f);
        make.right.equalTo(self.labelView4.superview).offset(-17.0f);
    }];
    [_barView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelView3);
        make.right.equalTo(self.labelView4);
        make.height.equalTo(@45.0f);
        make.top.equalTo(self.labelView3.mas_bottom).offset(15.0f);;
    }];
    
    [_barView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelView3);
        make.right.equalTo(self.labelView4);
        make.top.equalTo(self.barView3.mas_bottom);
        
        make.bottom.equalTo(self.barView4.superview).offset(-20.0f);
        make.height.equalTo(@45.0f);
    }];
}

-(void)reloadData:(ProfitModel *)model{
    _moneyLabel.text = [NSString stringWithFormat:@"收益：%.2f元",model.tborderCashSum.floatValue + model.jdorderCashSum.floatValue
                        + model.teamTBOrderCashSum.floatValue + model.teamJDOrderCashSum.floatValue];
    
    [_labelView1 setValue:model.tborderCashSum];
    [_labelView2 setValue:model.jdorderCashSum];
    [_barView1 setValue:model.tborderNum];
    [_barView2 setValue:model.jdorderNum];
    
    [_labelView3 setValue:model.teamTBOrderCashSum];
    [_labelView4 setValue:model.teamJDOrderCashSum];
    [_barView3 setValue:model.teamTBOrderNum];
    [_barView4 setValue:model.teamJDOrderNum];
}
@end
