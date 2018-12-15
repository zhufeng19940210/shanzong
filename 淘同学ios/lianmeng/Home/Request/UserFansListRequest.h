//
//  UserFansList.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/28.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface UserFansListRequest : Request
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,retain)NSNumber *type;
@end
