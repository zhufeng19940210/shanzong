//
//  PlatBannerRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "PlatBannerRequest.h"

@implementation TaoBaoPlatBannerRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/taobao/taoBaoPlatBanner";
    self.METHOD = @"GET";
}

@end
@implementation JDPlatBannerRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/jd/JDPlatBanner";
    self.METHOD = @"GET";
}
@end
