//
//  OrderNoticeListReuest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "OrderNoticeListReuest.h"
#import "UserCenter.h"

@implementation OrderNoticeListReuest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/notice/orderNoticeList";
    self.METHOD = @"POST";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}
@end
