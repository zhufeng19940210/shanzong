//
//  MainSceneModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneModel.h"
#import "LikeItemListRequest.h"
#import "GoodsListModel.h"
#import "BannerRequest.h"
#import "BannerListModel.h"

@interface MainSceneModel : SceneModel
@property(nonatomic,retain)LikeItemListRequest *likeRequest;
@property(nonatomic,retain)GoodsListModel *dataModel;
@property(nonatomic,retain)NSMutableArray *likeArray;

@property(nonatomic,retain)BannerRequest *bannerRequest;
@property(nonatomic,retain)BannerListModel *bannerModel;

@end
