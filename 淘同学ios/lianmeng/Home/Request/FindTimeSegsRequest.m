//
//  FindTimeSegsRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FindTimeSegsRequest.h"
#import "UserCenter.h"

@implementation FindTimeSegsRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/taobao/findTimeSegs";
    self.METHOD = @"GET";
}
@end

@implementation TimeSegsListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/taobao/timeSegsList";
    self.METHOD = @"GET";
    self.page = @1;
    self.userLevel = @([UserCenter sharedInstance].loginModel.userLevel);
}
@end
