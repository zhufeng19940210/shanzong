//
//  AddCashInfoRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface AddCashInfoRequest : Request
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,retain)NSString *phone;
@property(nonatomic,retain)NSString *smsCode;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *aliPayCount;
@end
