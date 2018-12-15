//
//  TimeSegModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface TimeSegModel : JSONModel
@property(nonatomic,retain)NSNumber *buyDate;
@property(nonatomic,copy)NSString *buyTimeSeg;
@property(nonatomic,retain)NSNumber *rushBuyStatus;
@property(nonatomic,retain)NSNumber *selected;
@end

@protocol TimeSegModel
@end

@interface TimeSegListModel : JSONModel
@property(nonatomic,strong)NSArray<TimeSegModel> *list;
@end

