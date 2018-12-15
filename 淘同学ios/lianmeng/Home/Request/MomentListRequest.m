//
//  MomentListRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MomentListRequest.h"
#import "UserCenter.h"

@implementation MomentListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/wechat/list";
    self.METHOD = @"GET";
    self.userLevel = @([UserCenter sharedInstance].loginModel.userLevel);
}
@end
