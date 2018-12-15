//
//  ShareInfo.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ShareInfo.h"
#import "UserCenter.h"
@implementation ShareInfo
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/taobao/shareInfo";
    self.METHOD = @"GET";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
    self.activityid = @"";
}
@end
