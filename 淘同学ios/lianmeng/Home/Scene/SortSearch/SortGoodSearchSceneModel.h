//  SortGoodSearchSceneModel.h
//  lianmeng
//  Created by zhufeng on 2018/12/27.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "SceneModel.h"
#import "SortGoodSearchRequest.h"
#import "GoodsListModel.h"
@interface SortGoodSearchSceneModel : SceneModel
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)SortGoodSearchRequest *request;
@property (nonatomic,retain)GoodsListModel *dataModel;
@end
