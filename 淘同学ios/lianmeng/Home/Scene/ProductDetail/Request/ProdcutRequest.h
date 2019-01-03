//  ProdcutRequest.h
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.

#import "Request.h"
@interface ProdcutRequest : Request
@property(nonatomic,retain)NSString *itemId;
@property(nonatomic,retain)NSNumber *userLevel;
@end
