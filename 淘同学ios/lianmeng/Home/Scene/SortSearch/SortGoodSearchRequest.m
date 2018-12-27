//  SortGoodSearchRequest.m
//  lianmeng
//  Created by zhufeng on 2018/12/27.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "SortGoodSearchRequest.h"
#import "UserCenter.h"
@implementation SortGoodSearchRequest
-(void)loadRequest
{
    [super loadRequest];
    self.PATH = @"/mobile/goods/getKeywordItems";
    self.sort = @0;
    self.userLevel = [NSNumber numberWithInteger:[UserCenter sharedInstance].loginModel.userLevel];
    self.METHOD = @"GET";
}
@end
