//
//  CardCodeRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/8/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "CardCodeRequest.h"
#import "UserCenter.h"

@implementation CardCodeRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/userCenter";
    self.METHOD = @"GET";
    self.userId = @([UserCenter sharedInstance].loginModel.userId);
}

-(NSString *)pathInfo{
    return @"/{userId}/{cardCode}";
}
@end
