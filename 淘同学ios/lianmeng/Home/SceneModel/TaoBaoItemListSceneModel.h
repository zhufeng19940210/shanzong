//
//  TaoBaoItemListSceneModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/17.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneModel.h"
#import "TaoBaoItemListRequest.h"
#import "GoodsListModel.h"

@interface TaoBaoItemListSceneModel : SceneModel
@property(nonatomic,assign)NSUInteger platformId;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)TaoBaoItemListRequest *request;
@property(nonatomic,retain)GoodsListModel *dataModel;
@end
