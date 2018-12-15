//
//  RankListRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "RankListRequest.h"

@implementation RankListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/RankList";
    self.METHOD = @"POST";
}
@end
