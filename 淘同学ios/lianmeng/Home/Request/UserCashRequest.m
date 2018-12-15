//
//  UserCashRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UserCashRequest.h"
#import "UserCenter.h"

@implementation UserCashRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/countUserCash";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
    self.METHOD = @"POST";
}
@end
