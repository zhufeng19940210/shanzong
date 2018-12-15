//
//  LoginRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "LoginRequest.h"


@implementation WechatLoginRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/user/wxlogin";
    self.METHOD = @"POST";
}
@end

@implementation LoginRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/user/login";
    self.METHOD = @"POST";
}
@end
