//  MomentListSceneModel.h
//  lianmeng
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.

#import "SceneModel.h"
#import "MomentListRequest.h"
#import "MomentListModel.h"

@interface MomentListSceneModel : SceneModel
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)MomentListRequest *request;
@property(nonatomic,retain)MomentListModel *dataModel;
@end
