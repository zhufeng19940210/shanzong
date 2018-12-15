//
//  UserOrderListRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface UserOrderListRequest : Request
@property(nonatomic,retain)NSNumber *page;
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,retain)NSNumber *platformId;
@property(nonatomic,retain)NSString *orderId;
@property(nonatomic,retain)NSNumber *payStatus;
@end
