//
//  UserFansListSceneModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/28.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneModel.h"
#import "UserFansListRequest.h"
#import "FansListModel.h"


@interface UserFansListSceneModel : SceneModel
@property(nonatomic,retain)UserFansListRequest *request;
@property(nonatomic,retain)FansListModel *dataModel;
@property(nonatomic,retain)NSArray *dataArray;
@end

