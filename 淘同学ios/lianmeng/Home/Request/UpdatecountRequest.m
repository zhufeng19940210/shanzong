//
//  UpdatecountRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UpdatecountRequest.h"
#import "UserCenter.h"

@implementation UpdatecountRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/wechat/updatecount";
    self.METHOD = @"POST";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}
@end
