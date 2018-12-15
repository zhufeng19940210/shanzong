//
//  RegisterRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest
-(void)loadRequest{
    [super loadRequest];
    self.headimgUrl = @"";
    self.unionid = @"";
    self.PATH = @"/mobile/user/register";
    self.METHOD = @"POST";
}
@end
