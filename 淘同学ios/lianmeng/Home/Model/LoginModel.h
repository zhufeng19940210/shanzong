//
//  LoginModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LoginModel : JSONModel
@property(nonatomic,retain)NSNumber* balance;
@property(nonatomic,copy)NSString<Optional> *headimgUrl;
@property(nonatomic,copy)NSString<Optional> *inviteCode;
@property(nonatomic,retain)NSNumber<Optional> * shopLimti;
@property(nonatomic,assign)NSUInteger userId;
@property(nonatomic,assign)NSUInteger userLevel;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString<Optional> *nickName;
@property(nonatomic,retain)NSNumber<Optional> *couponNum;
@property(nonatomic,retain)NSNumber<Optional> *couponSum;

@property(nonatomic,retain)NSNumber<Optional> *fansNum;
@property(nonatomic,retain)NSNumber<Optional> *monthCash;
@property(nonatomic,retain)NSNumber<Optional> *todayCash;
@property(nonatomic,retain)NSNumber<Optional> *orderNum;
@property(nonatomic,copy)NSString<Optional> *aliAccount;
@property(nonatomic,copy)NSString<Optional> *realName;
@end
