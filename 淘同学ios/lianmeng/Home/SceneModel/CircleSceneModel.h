//  CircleSceneModel.h
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "SceneModel.h"
#import "MomentListRequest.h"
#import "CircleListModel.h"
@interface CircleSceneModel : SceneModel
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)MomentListRequest *request;
@property (nonatomic,strong)CircleListModel *dataModel;
@end
