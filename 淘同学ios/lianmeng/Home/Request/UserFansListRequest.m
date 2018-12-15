//
//  UserFansList.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/28.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UserFansListRequest.h"
#import "UserCenter.h"

@implementation UserFansListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/userFansList";
    self.METHOD = @"POST";
    self.type = @0;
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}
@end
