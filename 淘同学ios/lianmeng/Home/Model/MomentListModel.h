//
//  MomentListModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface MomentModel : JSONModel
@property(nonatomic,retain)NSNumber* id;
@property(nonatomic,assign)NSUInteger createTime;
@property(nonatomic,copy)NSString *goodsDesc;
@property(nonatomic,assign)NSUInteger goodsType;
@property(nonatomic,copy)NSString *logo;
@property(nonatomic,retain)NSArray<Optional> *flMoney;
@property(nonatomic,retain)NSArray *itemId;
@property(nonatomic,retain)NSArray *pictures;
@property(nonatomic,assign)NSUInteger platformId;
@property(nonatomic,retain)NSNumber<Optional>*shareCount;
@property(nonatomic,copy)NSString *title;
@end


@protocol MomentModel
@end

@interface MomentListModel : JSONModel
@property(nonatomic,assign)NSUInteger currentPage;
@property(nonatomic,assign)NSUInteger total;
@property(nonatomic,assign)NSUInteger totalPage;
@property(nonatomic,strong)NSArray<MomentModel> *list;
@end
