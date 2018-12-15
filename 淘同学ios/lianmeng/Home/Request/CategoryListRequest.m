//
//  CategoryListRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/18.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "CategoryListRequest.h"
#import "UserCenter.h"

@implementation CategoryListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/goods/categoryItemList";
    self.sort = @0;
    self.isCoupon = @0;
    self.userLevel = [NSNumber numberWithInteger:[UserCenter sharedInstance].loginModel.userLevel];
    self.METHOD = @"GET";
}
@end
