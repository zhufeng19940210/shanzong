//  GoodsListModel.h
//  lianmeng
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "JSONModel.h"

@interface GoodsModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *activityid;
@property(nonatomic,strong)NSNumber<Optional> *allowBuyTime;
@property(nonatomic,copy)NSString<Optional> *couponEndTime;
@property(nonatomic,strong)NSNumber<Optional> *couponNum;  //已抢数量
@property(nonatomic,strong)NSNumber<Optional> *couponStartTime;
@property(nonatomic,strong)NSNumber<Optional> *couponSurplusl; //商品总数
@property(nonatomic,strong)NSNumber<Optional> *couponPrice;
//@property(nonatomic,retain)NSNumber *endTime;
@property(nonatomic,copy)NSString *itemDesc;
@property(nonatomic,copy)NSNumber *itemId;
@property(nonatomic,copy)NSString *itemPic;
@property(nonatomic,strong)NSNumber *itemPrice;
@property(nonatomic,strong)NSNumber<Optional> *itemSale;

@property(nonatomic,copy)NSString *itemShorTtitle;
@property(nonatomic,copy)NSString *itemTitle;
@property(nonatomic,strong)NSNumber<Optional> *moretkMoney;
@property(nonatomic,assign)NSUInteger platformId;
@property(nonatomic,strong)NSNumber<Optional>* shopType;

@property(nonatomic,strong)NSNumber<Optional> *tkMoney;
@property(nonatomic,copy)NSString<Optional> *videoUrl;

@end

@protocol GoodsModel
@end

@interface GoodsListModel : JSONModel
@property(nonatomic,assign)NSUInteger currentPage;
@property(nonatomic,assign)NSUInteger total;
@property(nonatomic,assign)NSUInteger totalPage;
@property(nonatomic,strong)NSArray<GoodsModel> *list;
@end

