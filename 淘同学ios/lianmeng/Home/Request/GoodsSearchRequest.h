//
//  GoodsSearchRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/18.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "Request.h"

@interface GoodsSearchRequest : Request
@property(nonatomic,retain)NSNumber *page;
@property(nonatomic,retain)NSNumber *isCoupon;
@property(nonatomic,retain)NSNumber *sort;
@property(nonatomic,retain)NSString *keyword;
@property(nonatomic,retain)NSNumber *platformId;
@property(nonatomic,retain)NSNumber *userLevel;
@end
