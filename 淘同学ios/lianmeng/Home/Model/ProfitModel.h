//
//  ProfitModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface ProfitModel : JSONModel
@property(nonatomic,copy)NSString *tborderCashSum;
@property(nonatomic,copy)NSString *jdorderCashSum;
@property(nonatomic,copy)NSString *tborderNum;
@property(nonatomic,copy)NSString *jdorderNum;
@property(nonatomic,copy)NSString *teamTBOrderCashSum;
@property(nonatomic,copy)NSString *teamJDOrderCashSum;
@property(nonatomic,copy)NSString *teamTBOrderNum;
@property(nonatomic,copy)NSString *teamJDOrderNum;
@property(nonatomic,copy)NSString *userSumCash;
@end
