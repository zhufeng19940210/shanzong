//
//  PosterRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/8/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "PosterRequest.h"
#import "UserCenter.h"

@implementation PosterRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter/poster";
    self.METHOD = @"GET";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}
@end
