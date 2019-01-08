//  JDShareInfo.m
//  lianmeng
//  Created by zhufeng on 2019/1/8.
//  Copyright © 2019 zhuchao. All rights reserved.
#import "JDShareInfo.h"
#import "UserCenter.h"
@implementation JDShareInfo
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/jd/ios/shareInfo";
    self.METHOD = @"GET";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
    self.activityid = @"";
}
@end
