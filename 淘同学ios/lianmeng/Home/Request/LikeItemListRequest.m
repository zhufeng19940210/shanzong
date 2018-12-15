//
//  LikeItemListRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "LikeItemListRequest.h"
#import "UserCenter.h"

@implementation LikeItemListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/home/itemlist";
    self.userLevel = [NSNumber numberWithInteger:[UserCenter sharedInstance].loginModel.userLevel];
    self.METHOD = @"GET";
}
@end
