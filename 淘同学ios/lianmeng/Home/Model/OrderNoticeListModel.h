//
//  OrderNoticeListModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface OrderNoticeModel : JSONModel
@property(nonatomic,retain)NSNumber *noticeId;
@property(nonatomic,retain)NSNumber *createTime;
@property(nonatomic,copy)NSString *logo;
@property(nonatomic,copy)NSString *noticeDesc;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,retain)NSNumber *userId;
@end

@protocol OrderNoticeModel
@end

@interface OrderNoticeListModel : JSONModel
@property(nonatomic,assign)NSUInteger currentPage;
@property(nonatomic,assign)NSUInteger total;
@property(nonatomic,assign)NSUInteger totalPage;
@property(nonatomic,strong)NSArray<OrderNoticeModel,Optional> *list;
@end
