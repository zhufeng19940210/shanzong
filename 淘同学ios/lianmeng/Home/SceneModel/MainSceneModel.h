//  MainSceneModel.h
//  lianmeng
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "SceneModel.h"
#import "LikeItemListRequest.h"
#import "GoodsListModel.h"
#import "BannerRequest.h"
#import "BannerListModel.h"
@interface MainSceneModel : SceneModel
@property(nonatomic,retain)LikeItemListRequest *likeRequest;
//@property(nonatomic,retain)GoodsListModel *model;
@property(nonatomic,retain)NSDictionary *dataModel;
@property(nonatomic,retain)NSMutableArray *likeArray;
@property(nonatomic,retain)NSMutableArray *studentArray;
@property(nonatomic,retain)NSMutableArray *ninetonineArray;
@property(nonatomic,retain)NSMutableArray *recommandArray;

@property(nonatomic,retain)BannerRequest *bannerRequest;
//@property(nonatomic,retain)BannerListModel *bannerModel;
@property(nonatomic,retain)NSMutableArray *banaerModel;
@property(nonatomic,retain)NSMutableArray *firstArray;
@property(nonatomic,retain)NSMutableArray *secdonArray;
@property(nonatomic,retain)NSMutableArray *thirdArray;
@end
