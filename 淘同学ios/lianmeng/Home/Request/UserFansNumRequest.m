//
//  UserFansNumRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UserFansNumRequest.h"
#import "UserCenter.h"
@implementation UserFansNumRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/UserFansNum";
    self.METHOD = @"POST";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}
@end
