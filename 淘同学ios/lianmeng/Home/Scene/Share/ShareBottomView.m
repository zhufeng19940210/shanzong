//
//  ShareBottomView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/27.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ShareBottomView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface ShareBottomView()
@property(nonatomic,retain)UIButton *shareBtn1;
@property(nonatomic,retain)UIButton *shareBtn2;
@property(nonatomic,retain)UIButton *shareBtn3;

@property(nonatomic,retain)UILabel *shareLabel1;
@property(nonatomic,retain)UILabel *shareLabel2;
@property(nonatomic,retain)UILabel *shareLabel3;

@end

@implementation ShareBottomView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.top.equalTo(self);
            make.height.equalTo(@1.0f);
        }];
        _shareBtn1 = [[UIButton alloc]init];
        [_shareBtn1 setImage:[UIImage imageNamed:@"share-text"] forState:UIControlStateNormal];
        [self addSubview:_shareBtn1];
        
        _shareLabel1 = [[UILabel alloc]init];
        _shareLabel1.text = @"复制文案";
        _shareLabel1.font = [UIFont fontWithName:MediumFont size:10.5f];
        _shareLabel1.textColor = [UIColor colorWithString:@"rgb(3,3,3)"];
        [self addSubview:_shareLabel1];
        
        _shareBtn2 = [[UIButton alloc]init];
        [_shareBtn2 setImage:[UIImage imageNamed:@"share-wechat"] forState:UIControlStateNormal];
        [self addSubview:_shareBtn2];
        
        _shareLabel2 = [[UILabel alloc]init];
        _shareLabel2.text = @"微信";
        _shareLabel2.font = [UIFont fontWithName:MediumFont size:10.5f];
        _shareLabel2.textColor = [UIColor colorWithString:@"rgb(3,3,3)"];
        [self addSubview:_shareLabel2];
        
        _shareBtn3 = [[UIButton alloc]init];
        [_shareBtn3 setImage:[UIImage imageNamed:@"share-timeline-1"] forState:UIControlStateNormal];
        [self addSubview:_shareBtn3];
        
        _shareLabel3 = [[UILabel alloc]init];
        _shareLabel3.text = @"朋友圈";
        _shareLabel3.font = [UIFont fontWithName:MediumFont size:10.5f];
        _shareLabel3.textColor = [UIColor colorWithString:@"rgb(3,3,3)"];
        [self addSubview:_shareLabel3];
        
        [_shareBtn1 addTarget:self action:@selector(doshare:) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn2 addTarget:self action:@selector(doshare:) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn3 addTarget:self action:@selector(doshare:) forControlEvents:UIControlEventTouchUpInside];
        
        _shareBtn1.tag = 1;
        _shareBtn2.tag = 2;
        _shareBtn3.tag = 3;
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    
    [@[_shareBtn1,_shareBtn2,_shareBtn3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@42.5f);
        make.top.equalTo(self).offset(15.0f);
    }];
    
    [@[_shareBtn1,_shareBtn2,_shareBtn3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:42.5f leadSpacing:40.0f tailSpacing:40.0f];
    
    [_shareLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.shareBtn1);
        make.top.equalTo(self.shareBtn1.mas_bottom).offset(6.5f);
    }];
    [_shareLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareBtn2);
        make.top.equalTo(self.shareBtn2.mas_bottom).offset(6.5f);
    }];
    [_shareLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareBtn3);
        make.top.equalTo(self.shareBtn3.mas_bottom).offset(6.5f);
    }];
}

-(void)doshare:(UIButton *)btn{
    if(_delegate) {
        if (btn.tag == 1) {
            [_delegate copyText];
        }else if(btn.tag == 2){
            [_delegate shareWechat];
        }else if(btn.tag == 3){
            [_delegate shareTimeLine];
        }
    }

}



@end
