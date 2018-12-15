//
//  CardCodeRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/8/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface CardCodeRequest : Request
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,copy)NSString *cardCode;
@end
