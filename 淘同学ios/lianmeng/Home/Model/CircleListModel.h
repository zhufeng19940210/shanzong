//
//  CircleListModel.h
//  lianmeng
//
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface CircleModel: JSONModel
@property (nonatomic,retain)NSNumber* id;
@property (nonatomic,copy)NSString *logo;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign)NSUInteger platformId;
@property (nonatomic,copy)NSString *qrUrl;
@property (nonatomic,copy)NSString *goodsDesc;
@property (nonatomic,retain)NSArray *pictures;
@property (nonatomic,assign)NSUInteger goodsType;
@property (nonatomic,assign)NSUInteger createTime;
@property(nonatomic,retain)NSNumber<Optional>*shareCount;

@end
@protocol CircleModel
@end

@interface CircleListModel : JSONModel
@property(nonatomic,assign)NSUInteger currentPage;
@property(nonatomic,assign)NSUInteger total;
@property(nonatomic,assign)NSUInteger totalPage;
@property(nonatomic,strong)NSArray<CircleModel> *list;
@end
