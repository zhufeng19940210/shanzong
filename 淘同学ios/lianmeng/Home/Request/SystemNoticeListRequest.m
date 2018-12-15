//
//  SystemNoticeListRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SystemNoticeListRequest.h"
#import "UserCenter.h"

@implementation SystemNoticeListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/notice/systemNoticeList";
    self.METHOD = @"POST";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}
@end
