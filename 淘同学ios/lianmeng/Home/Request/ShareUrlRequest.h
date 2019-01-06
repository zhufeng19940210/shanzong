//
//  ShareUrlRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/8/2.
//  Copyright © 2018年 zhuchao. All rights reserved.

#import "Request.h"
#import "GoodsListModel.h"
@interface ShareUrlRequest : Request
@property(nonatomic,retain)NSNumber *wechatInfoId;
@property(nonatomic,retain)NSNumber *userId;
+(void)getShareInfo:(NSArray *)dataList  callBack:(void (^)(NSArray* imageList))callBack;
@end


@interface TBShareUrlRequest : Request
@property(nonatomic,retain)NSString *clickUrl;
@property(nonatomic,retain)NSNumber *itemId;
@end
