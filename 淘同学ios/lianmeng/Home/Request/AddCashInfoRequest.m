//
//  AddCashInfoRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "AddCashInfoRequest.h"
#import "UserCenter.h"

@implementation AddCashInfoRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/addCashInfo";
    self.METHOD = @"POST";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}
@end
