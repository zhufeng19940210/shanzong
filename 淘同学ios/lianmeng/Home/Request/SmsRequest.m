//  SmsRequest.m
//  lianmeng
//  Created by zhuchao on 2018/6/4.
//  Copyright © 2018年 zhuchao. All rights reserved.

#import "SmsRequest.h"

#import "UserCenter.h"

@implementation CashSmsRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/snsmessageCash";
    self.METHOD = @"POST";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}
@end

@implementation SmsRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/user/snsmessage";
    self.METHOD = @"POST";
}
@end
