//
//  LikeItemListRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface LikeItemListRequest : Request
@property(nonatomic,retain)NSNumber *page;
@property(nonatomic,retain)NSNumber *userLevel;
@end
