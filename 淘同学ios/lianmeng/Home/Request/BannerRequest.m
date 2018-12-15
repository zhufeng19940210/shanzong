//
//  BannerRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "BannerRequest.h"

@implementation BannerRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/home/banner";
    self.METHOD = @"GET";
}
@end
