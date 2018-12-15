//
//  UpdatecountRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface UpdatecountRequest : Request
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,retain)NSNumber *wechatInfoId;
@end
