//
//  GoodsSearchSceneModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/18.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneModel.h"
#import "GoodsSearchRequest.h"
#import "GoodsListModel.h"

@interface GoodsSearchSceneModel : SceneModel
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)GoodsSearchRequest *request;
@property(nonatomic,retain)GoodsListModel *dataModel;
@end
