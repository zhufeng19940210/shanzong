//
//  UserFansNumModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface UserFansNumModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *headimgUrl;
@property(nonatomic,copy)NSString<Optional> *inviteCode;
@property(nonatomic,copy)NSString<Optional> *phone;
@property(nonatomic,copy)NSString<Optional> *username;

@property(nonatomic,strong)NSNumber *belongNum;
@property(nonatomic,strong)NSNumber *fansNumSum;
@property(nonatomic,strong)NSNumber *secondhandNum;
@property(nonatomic,strong)NSNumber *todayNum;
@property(nonatomic,strong)NSNumber *yestodayNum;
@property(nonatomic,strong)NSNumber *yestodayupgradeNum;
@end
