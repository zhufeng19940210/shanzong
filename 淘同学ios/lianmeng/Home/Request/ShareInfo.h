//
//  ShareInfo.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface ShareInfo : Request
@property(nonatomic,retain)NSNumber *itemId;
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,retain)NSString *activityid;

@end
