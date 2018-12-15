//
//  DetailScene.h
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Scene.h"
#import "GoodsListModel.h"

@interface DetailScene : Scene
@property(nonatomic,assign)NSUInteger platformId;
@property(nonatomic,copy)NSString *itemId;
@property(nonatomic,retain)GoodsModel *model;
@end
