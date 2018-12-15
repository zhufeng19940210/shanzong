//
//  MineHeaderView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/20.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MineHeaderView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "UserCenter.h"
#import "TakeProfitScene.h"
#import "HuiyuanScene.h"

@interface MineHeaderView()
@property(nonatomic,retain)UIImageView *avatar;
@property(nonatomic,retain)UILabel *nickname;
@property(nonatomic,retain)UILabel *savedMoney;
@property(nonatomic,retain)UIView *saveMoneyBg;
@property(nonatomic,retain)UILabel *restMoney;
@property(nonatomic,retain)UILabel *inviteCode;
@property(nonatomic,retain)UIImageView *bgView;
@property(nonatomic,retain)UIView *cardView;
@property(nonatomic,retain)UIButton *memberTypeBtn;
@property(nonatomic,retain)UIButton *updateBtn;
@property(nonatomic,retain)UIButton *inviteCopyBtn;
@property(nonatomic,retain)UIButton *inifiteMoneyBtn;

@property(nonatomic,retain)UILabel *totalMoneyTipsLabel;
@property(nonatomic,retain)UILabel *totalMoneyLabel;
@property(nonatomic,retain)UIButton *tixianBtn;

@property(nonatomic,retain)UIView *v1;
@property(nonatomic,retain)UIView *v2;
@property(nonatomic,retain)UIView *v3;

@property(nonatomic,retain)UILabel *monthMoneyTipsLabel;
@property(nonatomic,retain)UILabel *monthMoneyLabel;

@property(nonatomic,retain)UILabel *todayMoneyTipsLabel;
@property(nonatomic,retain)UILabel *todayMoneyLabel;

@property(nonatomic,retain)UILabel *fansTipsLabel;
@property(nonatomic,retain)UILabel *fansLabel;
@property(nonatomic,retain)LoginModel *model;
@end
@implementation MineHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"wodebeijing"];
        [self addSubview:_bgView];
        
        _cardView = [[UIView alloc]init];
        _cardView.backgroundColor = [UIColor whiteColor];
        _cardView.layer.cornerRadius = 8.0f;
        [self addSubview:_cardView];
        
        
        _v1 = [[UIView alloc]init];
        _v1.layer.borderWidth = 0.5f;
        _v1.layer.borderColor = [UIColor colorWithString:@"#eeeeee"].CGColor;
        [_cardView addSubview:_v1];
        
        _v2 = [[UIView alloc]init];
        _v2.layer.borderWidth = 0.5f;
        _v2.layer.borderColor = [UIColor colorWithString:@"#eeeeee"].CGColor;
        [_cardView addSubview:_v2];
        
        _v3 = [[UIView alloc]init];
        _v3.layer.borderWidth = 0.5f;
        _v3.layer.borderColor = [UIColor colorWithString:@"#eeeeee"].CGColor;
        [_cardView addSubview:_v3];
        
        
        _avatar = [[UIImageView alloc]init];
        _avatar.backgroundColor = [UIColor redColor];
        _avatar.layer.cornerRadius = 35.0f;
        _avatar.clipsToBounds = YES;
        [self addSubview:_avatar];
        
        _nickname = [[UILabel alloc]init];
        _nickname.text = @"昵称";
        _nickname.textColor = [UIColor whiteColor];
        _nickname.font = [UIFont fontWithName:MediumFont size:15.0f];
        [self addSubview:_nickname];
        
        _memberTypeBtn = [[UIButton alloc]init];
        _memberTypeBtn.titleLabel.font = [UIFont fontWithName:MediumFont size:12.0f];
        [_memberTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _memberTypeBtn.layer.borderWidth = 1.0f;
        _memberTypeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _memberTypeBtn.layer.cornerRadius = 4.0f;
        _memberTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        [self addSubview:_memberTypeBtn];
        
        _updateBtn = [[UIButton alloc]init];
        _updateBtn.titleLabel.font = [UIFont fontWithName:MediumFont size:14.0f];
        [_updateBtn setTitle:@"升级" forState:UIControlStateNormal];
        [_updateBtn setTitleColor:[UIColor colorWithString:@"#f32f19"] forState:UIControlStateNormal];
        _updateBtn.backgroundColor = [UIColor whiteColor];
        _updateBtn.layer.cornerRadius = 4.0f;
        _updateBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);
        [_updateBtn addTarget:self action:@selector(doUpdate) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_updateBtn];
        
        _inviteCopyBtn = [[UIButton alloc]init];
        _inviteCopyBtn.titleLabel.font = [UIFont fontWithName:MediumFont size:14.0f];
        [_inviteCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
        [_inviteCopyBtn setTitleColor:[UIColor colorWithString:@"#f32f19"] forState:UIControlStateNormal];
        _inviteCopyBtn.backgroundColor = [UIColor whiteColor];
        _inviteCopyBtn.layer.cornerRadius = 4.0f;
        _inviteCopyBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);
        [_inviteCopyBtn addTarget:self action:@selector(copyCode) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_inviteCopyBtn];
        
      
        
        _inviteCode = [[UILabel alloc]init];
        _inviteCode.text = @"邀请码：XXXXXXX";
        _inviteCode.textColor = [UIColor whiteColor];
        _inviteCode.font = [UIFont fontWithName:RegularFont size:13.0f];
        [self addSubview:_inviteCode];
        
        
        _saveMoneyBg = [[UIView alloc]init];
        _saveMoneyBg.backgroundColor = [UIColor colorWithString:@"#72b8ff"];
        _saveMoneyBg.layer.cornerRadius = 3.0f;
        [self addSubview:_saveMoneyBg];
        
        _savedMoney = [[UILabel alloc]init];
        _savedMoney.textColor = [UIColor whiteColor];
        _savedMoney.font = [UIFont fontWithName:RegularFont size:12.0f];
        _savedMoney.text = @"已为您节省0元";
        [self addSubview:_savedMoney];
        
        _restMoney = [[UILabel alloc]init];
        _restMoney.text = @"剩余额度：0元";
        _restMoney.textColor = [UIColor whiteColor];
        _restMoney.font = [UIFont fontWithName:RegularFont size:13.0f];
        [self addSubview:_restMoney];
        
        _inifiteMoneyBtn = [[UIButton alloc]init];
        _inifiteMoneyBtn.titleLabel.font = [UIFont fontWithName:MediumFont size:14.0f];
        [_inifiteMoneyBtn setTitle:@"开启无限额度" forState:UIControlStateNormal];
        [_inifiteMoneyBtn setTitleColor:[UIColor colorWithString:@"#f32f19"] forState:UIControlStateNormal];
        _inifiteMoneyBtn.backgroundColor = [UIColor whiteColor];
        _inifiteMoneyBtn.layer.cornerRadius = 8.0f;
        _inifiteMoneyBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);
         [_inifiteMoneyBtn addTarget:self action:@selector(doUpdate) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_inifiteMoneyBtn];
        
        
        _totalMoneyTipsLabel = [[UILabel alloc]init];
        _totalMoneyTipsLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        _totalMoneyTipsLabel.text  = @"可提现金额";
        _totalMoneyTipsLabel.textColor = [UIColor colorWithString:@"#888888"];
        [self addSubview:_totalMoneyTipsLabel];
        
        _totalMoneyLabel = [[UILabel alloc]init];
        _totalMoneyLabel.font = [UIFont fontWithName:RegularFont size:17.0f];
        _totalMoneyLabel.text  = @"￥0";
        _totalMoneyLabel.textColor = [UIColor colorWithString:@"#D0000E"];
        [self addSubview:_totalMoneyLabel];
        
        _tixianBtn = [[UIButton alloc]init];
        [_tixianBtn setImage:[UIImage imageNamed:@"tixian"] forState:UIControlStateNormal];
        [_tixianBtn addTarget:self action:@selector(takeProfit:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_tixianBtn];
        
        
        _monthMoneyTipsLabel = [[UILabel alloc]init];
        _monthMoneyTipsLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        _monthMoneyTipsLabel.text  = @"本月预估";
        _monthMoneyTipsLabel.textColor = [UIColor colorWithString:@"#888888"];
        [_v1 addSubview:_monthMoneyTipsLabel];
        
        _monthMoneyLabel = [[UILabel alloc]init];
        _monthMoneyLabel.font = [UIFont fontWithName:RegularFont size:17.0f];
        _monthMoneyLabel.text  = @"￥0";
        _monthMoneyLabel.textColor = [UIColor colorWithString:@"#D0000E"];
        [_v1 addSubview:_monthMoneyLabel];
        
        
        _todayMoneyTipsLabel = [[UILabel alloc]init];
        _todayMoneyTipsLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        _todayMoneyTipsLabel.text  = @"今日收益";
        _todayMoneyTipsLabel.textColor = [UIColor colorWithString:@"#888888"];
        [_v2 addSubview:_todayMoneyTipsLabel];
        
        _todayMoneyLabel = [[UILabel alloc]init];
        _todayMoneyLabel.font = [UIFont fontWithName:RegularFont size:17.0f];
        _todayMoneyLabel.text  = @"￥0";
        _todayMoneyLabel.textColor = [UIColor colorWithString:@"#D0000E"];
        [_v2 addSubview:_todayMoneyLabel];
        
        
        _fansTipsLabel = [[UILabel alloc]init];
        _fansTipsLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        _fansTipsLabel.text  = @"我的粉丝";
        _fansTipsLabel.textColor = [UIColor colorWithString:@"#888888"];
        [_v3 addSubview:_fansTipsLabel];
        
        _fansLabel = [[UILabel alloc]init];
        _fansLabel.font = [UIFont fontWithName:RegularFont size:17.0f];
        _fansLabel.text  = @"0";
        _fansLabel.textColor = [UIColor colorWithString:@"#D0000E"];
        [_v3 addSubview:_fansLabel];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(151.0f+kStatusBarAndNavigationBarHeight));
    }];
    
    [_cardView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self).offset(20.0f);
       make.bottom.right.equalTo(self).offset(-20.0f);
        make.height.equalTo(@121.0f);
    }];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
       make.width.height.equalTo(@70.0f);
        make.left.equalTo(self).offset(19.0f);
        make.bottom.equalTo(self.cardView.mas_top).offset(-33.0f);
    }];
    
    [_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.avatar.mas_right).offset(15.0f);
        make.top.equalTo(self.avatar).offset(20.0f);
    }];
    
    [_memberTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickname.mas_right).offset(7.5f);
        make.centerY.equalTo(self.nickname);
        make.height.equalTo(@16.0f);
        make.width.equalTo(@70.f);
    }];
    
    [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.memberTypeBtn.mas_right).offset(7.5f);
        make.centerY.equalTo(self.nickname);
        make.height.equalTo(@16.0f);
        make.width.equalTo(@50.f);
    }];
    
    [_inviteCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickname);
        make.top.equalTo(self.nickname.mas_bottom).offset(3.0f);
    }];
    
    [_inviteCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.updateBtn);
        make.centerY.equalTo(self.inviteCode);
        make.height.equalTo(@16.0f);
        make.width.equalTo(@50.f);
    }];
    
    
    [_saveMoneyBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickname);
        make.top.equalTo(self.inviteCode.mas_bottom).offset(3.0f);
        make.height.equalTo(@18.0f);
    }];
    
    [_savedMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.saveMoneyBg).offset(3.0f);
         make.right.equalTo(self.saveMoneyBg).offset(-3.0f);
        make.centerY.equalTo(self.saveMoneyBg);
    }];
    
    
    [_restMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickname);
        make.top.equalTo(self.saveMoneyBg.mas_bottom).offset(3.0f);
    }];
    
    
    [_inifiteMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.restMoney.mas_right).offset(7.5f);
        make.centerY.equalTo(self.restMoney);
        make.height.equalTo(@16.0f);
        make.width.equalTo(@100.f);
    }];
    
    [@[_v1,_v2,_v3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardView).offset(45.0f);
        make.bottom.equalTo(self.cardView);
    }];
    [@[_v1,_v2,_v3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [_totalMoneyTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.cardView).offset(13.0f);
        make.top.equalTo(self.cardView).offset(20.0f);
    }];
    
    [_totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalMoneyTipsLabel.mas_right).offset(20.0f);
        make.centerY.equalTo(self.totalMoneyTipsLabel);
    }];
    
    
    [_tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.cardView).offset(-15.0f);
        make.centerY.equalTo(self.totalMoneyTipsLabel);
    }];
    
    
    [_monthMoneyTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.v1);
       make.bottom.equalTo(self.v1).offset(-15.0f);
    }];
    
    [_monthMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v1);
        make.bottom.equalTo(self.monthMoneyTipsLabel).offset(-25.0f);
    }];
    
    
    [_todayMoneyTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v2);
        make.bottom.equalTo(self.v2).offset(-15.0f);
    }];
    
    [_todayMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v2);
        make.bottom.equalTo(self.todayMoneyTipsLabel).offset(-25.0f);
    }];
    
    
    [_fansTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v3);
        make.bottom.equalTo(self.v3).offset(-15.0f);
    }];
    
    [_fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v3);
        make.bottom.equalTo(self.fansTipsLabel).offset(-25.0f);
    }];
}

-(void)doUpdate{
    HuiyuanScene *scene = [[HuiyuanScene alloc]init];
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}

-(void)copyCode{
    if (_model.inviteCode) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _model.inviteCode;
        [DialogUtil showMessage:@"邀请码已复制！"];
    }
}

-(void)takeProfit:(UIButton *)btn{
    TakeProfitScene *scene = [[TakeProfitScene alloc]init];
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}

-(void)setData:(LoginModel *)model{
    _model = model;
    _nickname.text = model.nickName;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.headimgUrl]];
    if (model.inviteCode) {
        _inviteCode.text = [NSString stringWithFormat:@"邀请码：%@",model.inviteCode];
    }
    
    _totalMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",model.balance.floatValue];
    
    if (model.userLevel == 0) {
        _updateBtn.hidden = _inifiteMoneyBtn.hidden = model.orderNum.integerValue <3;
        _restMoney.hidden = NO;
        if (model.shopLimti) {
            _restMoney.text = [NSString stringWithFormat:@"剩余额度：%@元",model.shopLimti];
        }
        
    }else{
        _updateBtn.hidden = model.userLevel == 4 ||model.userLevel == 3 ;
        _inifiteMoneyBtn.hidden = YES;
        _restMoney.hidden = YES;
    }
    
    if (model.userLevel == 0) {
        [_memberTypeBtn setTitle:@"用户" forState:UIControlStateNormal];
    }else if(model.userLevel == 1){
        [_memberTypeBtn setTitle:@"会员" forState:UIControlStateNormal];
    }else if(model.userLevel == 2){
        [_memberTypeBtn setTitle:@"高级会员" forState:UIControlStateNormal];
    }else if(model.userLevel == 3){
        [_memberTypeBtn setTitle:@"导购达人" forState:UIControlStateNormal];
    }else if(model.userLevel == 4){
        [_memberTypeBtn setTitle:@"执行董事" forState:UIControlStateNormal];
    }
    _savedMoney.text = [NSString stringWithFormat:@"已为您节省%@元",model.couponSum];
    
    if (model.monthCash) {
        _monthMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",model.monthCash.floatValue];
    }
    if (model.todayCash) {
        _todayMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",model.todayCash.floatValue];
    }
    if (model.fansNum) {
        _fansLabel.text = [NSString stringWithFormat:@"%@",model.fansNum];
    }
    
}
@end
