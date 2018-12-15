//
//  SystemNoticeListModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface SystemNoticeModel : JSONModel
//@property(nonatomic,retain)NSNumber *id;
@property(nonatomic,retain)NSNumber *createTime;
@property(nonatomic,copy)NSString *logo;
@property(nonatomic,copy)NSString *noticeDesc;
@property(nonatomic,copy)NSString *title;
@end

@protocol SystemNoticeModel
@end

@interface SystemNoticeListModel : JSONModel
@property(nonatomic,assign)NSUInteger currentPage;
@property(nonatomic,assign)NSUInteger total;
@property(nonatomic,assign)NSUInteger totalPage;
@property(nonatomic,strong)NSArray<SystemNoticeModel,Optional> *list;
@end
