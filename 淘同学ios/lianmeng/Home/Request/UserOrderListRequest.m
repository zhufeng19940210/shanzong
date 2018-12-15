//
//  UserOrderListRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UserOrderListRequest.h"
#import "UserCenter.h"

@implementation UserOrderListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/userOrderList";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
    self.METHOD = @"POST";
}
@end
