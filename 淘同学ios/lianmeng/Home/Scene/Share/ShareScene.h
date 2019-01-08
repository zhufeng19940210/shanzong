//
//  ShareScene.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Scene.h"
#import "GoodsListModel.h"
#import "MomentListModel.h"
#import "CircleListModel.h"
@interface ShareScene : Scene
@property(nonatomic,assign)BOOL isCircle;
@property(nonatomic,retain)CircleModel *circlemodel;
@property(nonatomic,retain)GoodsModel *model;
@property(nonatomic,retain)NSArray *mUrlArray;
-(void)genShareData:(NSString *)itemId platformId:(NSUInteger)platformId;
@end
