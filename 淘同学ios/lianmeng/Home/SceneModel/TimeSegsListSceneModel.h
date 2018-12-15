//
//  TimeSegsListSceneModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneModel.h"
#import "FindTimeSegsRequest.h"
#import "GoodsListModel.h"
#import "TimeSegModel.h"

@interface TimeSegsListSceneModel : SceneModel
@property(nonatomic,retain)FindTimeSegsRequest *timeSegsRequest;
@property(nonatomic,retain)TimeSegListModel *timeSegList;

@property(nonatomic,retain)TimeSegsListRequest *request;
@property(nonatomic,retain)GoodsListModel *dataModel;
@property(nonatomic,retain)NSMutableArray *dataArray;
@end
