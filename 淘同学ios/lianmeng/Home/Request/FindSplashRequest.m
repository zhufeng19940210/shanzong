//
//  FindSplashRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/8/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FindSplashRequest.h"

@implementation FindSplashRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/home/findSplash";
    self.METHOD = @"GET";
}
@end
