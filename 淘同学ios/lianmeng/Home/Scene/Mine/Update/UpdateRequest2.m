//  UpdateRequest.m
//  lianmeng
//  Created by zhufeng on 2019/1/6.
//  Copyright © 2019 zhuchao. All rights reserved.

#import "UpdateRequest2.h"

@implementation UpdateRequest2
-(void)loadRequest
{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/getVersion";
    self.METHOD = @"POST";
}
@end
