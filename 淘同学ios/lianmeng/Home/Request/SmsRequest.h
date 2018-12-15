//
//  SmsRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"


@interface CashSmsRequest : Request
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,copy)NSString *phone;
@end

@interface SmsRequest : Request
@property(nonatomic,copy)NSString *phone;
@end
