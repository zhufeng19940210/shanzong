//
//  CategoryListSceneModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/18.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneModel.h"
#import "GoodsListModel.h"
#import "CategoryListRequest.h"

@interface CategoryListSceneModel : SceneModel
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)CategoryListRequest *request;
@property(nonatomic,retain)GoodsListModel *dataModel;
@end
