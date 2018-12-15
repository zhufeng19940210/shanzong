//
//  UserCashRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface UserCashRequest : Request
@property(nonatomic,retain)NSNumber *type;
@property(nonatomic,retain)NSNumber *userId;
@end

