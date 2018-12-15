//
//  OrderTableView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneTableView.h"
#import "UserOrderListSceneModel.h"

@interface OrderTableView : SceneTableView
@property(nonatomic,retain)UserOrderListSceneModel *sceneModel;
-(void)startRAC:(NSUInteger)index platformId:(NSUInteger)platformId;
@end
