//
//  RegisterRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface RegisterRequest : Request
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *invitecode;
@property(nonatomic,copy)NSString *smsCode;
@property(nonatomic,copy)NSString *headimgUrl;
@property(nonatomic,copy)NSString *unionid;
@property(nonatomic,copy)NSString *nickName;

@end
