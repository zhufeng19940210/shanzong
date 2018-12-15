//
//  ShareItemInfoRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface ShareItemInfoRequest : Request
@property(nonatomic,retain)NSString *itemId;
@property(nonatomic,retain)NSNumber *platformId;
@property(nonatomic,retain)NSNumber *userLevel;
@end
