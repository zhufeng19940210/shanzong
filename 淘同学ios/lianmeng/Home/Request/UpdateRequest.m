//
//  UpdateRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UpdateRequest.h"
#import "UserCenter.h"

@implementation UpdateRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/upgradeText";
    self.METHOD = @"POST";
    self.userLevel = @([UserCenter sharedInstance].loginModel.userLevel);
}
@end
