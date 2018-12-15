//
//  UserOrderListModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"
@interface UserOrderModel : JSONModel
@property(nonatomic,retain)NSNumber *cash;
@property(nonatomic,copy)NSString *createTime;
//@property(nonatomic,copy)NSString *earningTime;
@property(nonatomic,copy)NSString *itemId;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,retain)NSNumber *payPrice;
@property(nonatomic,retain)NSNumber *payStatus;
@property(nonatomic,retain)NSString<Optional> *pictUrl;

@property(nonatomic,retain)NSNumber *platformId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,retain)NSNumber *userId;
@end

@protocol UserOrderModel
@end

@interface UserOrderListModel : JSONModel
@property(nonatomic,assign)NSUInteger currentPage;
@property(nonatomic,assign)NSUInteger total;
@property(nonatomic,assign)NSUInteger totalPage;
@property(nonatomic,strong)NSArray<UserOrderModel,Optional> *list;
@end
