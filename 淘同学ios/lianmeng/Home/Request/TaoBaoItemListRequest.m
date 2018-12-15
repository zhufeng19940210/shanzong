//
//  TaoBaoItemListRequest.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/17.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TaoBaoItemListRequest.h"
#import "UserCenter.h"

@implementation TaoBaoItemListRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/mobile/taobao/itemlist";
    self.userLevel = [NSNumber numberWithInteger:[UserCenter sharedInstance].loginModel.userLevel];
    self.METHOD = @"GET";
}
@end
