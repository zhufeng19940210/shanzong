//  ProdcutRequest.m
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
#import "ProdcutRequest.h"
#import "UserCenter.h"
@implementation ProdcutRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/taobao/iteminfo";
    self.METHOD = @"GET";
    self.userLevel = @([UserCenter sharedInstance].loginModel.userLevel);
}
@end
