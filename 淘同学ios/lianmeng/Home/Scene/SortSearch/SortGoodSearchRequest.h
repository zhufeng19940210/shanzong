//  SortGoodSearchRequest.h
//  lianmeng
//  Created by zhufeng on 2018/12/27.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "Request.h"

@interface SortGoodSearchRequest : Request
@property(nonatomic,retain)NSNumber *page;
@property(nonatomic,retain)NSNumber *sort;
@property(nonatomic,retain)NSNumber *cid;
@property(nonatomic,retain)NSString *keyword;
@property(nonatomic,retain)NSNumber *userLevel;
@end
