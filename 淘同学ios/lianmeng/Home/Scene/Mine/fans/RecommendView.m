//
//  RecommendView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/24.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "RecommendView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface RecommendView()
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIImageView *avatar;
@property(nonatomic,retain)UILabel *nicknameLabel;
@property(nonatomic,retain)UILabel *inviteCodeLabel;
@property(nonatomic,retain)UILabel *phoneLabel;
@end
@implementation RecommendView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"tuijian-tb"];
        [self addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:BoldFont size:16.0f];
        _titleLabel.textColor = [UIColor colorWithString:@"rgb(248,216,88)"];
        _titleLabel.text = @"您的推荐人";
        [self addSubview:_titleLabel];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithString:@"#EEEEEE"];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(self);
            make.top.equalTo(self).offset(35.0f);
            make.height.equalTo(@1.0f);
        }];
        
        _avatar = [[UIImageView alloc]init];
        _avatar.clipsToBounds = YES;
        _avatar.layer.cornerRadius = 19.0f;
        _avatar.backgroundColor = [UIColor grayColor];
        [self addSubview:_avatar];
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.font = [UIFont fontWithName:BoldFont size:16.0f];
        _nicknameLabel.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
         _nicknameLabel.text = @"邀请人";
        [self addSubview:_nicknameLabel];
        
        _inviteCodeLabel = [[UILabel alloc]init];
        _inviteCodeLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        _inviteCodeLabel.textColor = [UIColor colorWithString:@"rgb(136,136,136)"];
        _inviteCodeLabel.text = @"(邀请码:000000)";
        [self addSubview:_inviteCodeLabel];
        
        
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        _phoneLabel.textColor = [UIColor colorWithString:@"rgb(136,136,136)"];
        _phoneLabel.text = @"13000000000";
        [self addSubview:_phoneLabel];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self).offset(12.0f);
        make.top.equalTo(self).offset(10.0f);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(16.0f);
    }];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self).offset(15.0f);
        make.bottom.equalTo(self).offset(-11.0f);
        make.width.height.equalTo(@38.0f);
    }];
    
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.avatar.mas_right).offset(15.0f);
        make.top.equalTo(self.avatar);
    }];
    
    [_inviteCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.nicknameLabel.mas_right).offset(10.0f);
        make.bottom.equalTo(self.nicknameLabel);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.nicknameLabel);
        make.top.equalTo(self.nicknameLabel.mas_bottom).offset(5.0f);
    }];
}

-(void)reloadData:(UserFansNumModel *)model{
    _nicknameLabel.text = model.username;
    _inviteCodeLabel.text = [NSString stringWithFormat:@"(邀请码:%@)",model.inviteCode];
    _phoneLabel.text = model.phone;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.headimgUrl]];
}
@end
