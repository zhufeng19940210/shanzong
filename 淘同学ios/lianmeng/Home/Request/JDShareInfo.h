//
//  JDShareInfo.h
//  lianmeng
//
//  Created by zhufeng on 2019/1/8.
//  Copyright © 2019 zhuchao. All rights reserved.
//

#import "Request.h"

@interface JDShareInfo : Request
@property(nonatomic,retain)NSNumber *itemId;
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,retain)NSString *activityid;
@end
