//
//  ShareItemInfoRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ShareItemInfoRequest.h"
#import "UserCenter.h"

@implementation ShareItemInfoRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/wechat/itemInfo";
    self.METHOD = @"POST";
    self.userLevel = @([UserCenter sharedInstance].loginModel.userLevel);
}
@end
