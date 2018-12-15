//
//  UserOrderListSceneModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/26.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneModel.h"
#import "UserOrderListRequest.h"
#import "UserOrderListModel.h"
@interface UserOrderListSceneModel : SceneModel
@property(nonatomic,retain)UserOrderListRequest *request;
@property(nonatomic,retain)UserOrderListModel *dataModel;
@property(nonatomic,retain)NSMutableArray *dataArray;

@end
