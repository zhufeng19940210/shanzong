//
//  UserCenterRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UserCenterRequest.h"
#import "UserCenter.h"
@implementation UserCenterRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/userCenter";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
    self.METHOD = @"POST";
}
@end
