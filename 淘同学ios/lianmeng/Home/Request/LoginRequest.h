//
//  LoginRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"
@interface WechatLoginRequest : Request
@property(nonatomic,copy)NSString *unionid;
@end

@interface LoginRequest : Request
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *password;
@end
