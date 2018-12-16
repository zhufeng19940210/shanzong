//
//  TaoBaoTableView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/16.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoBaoItemListSceneModel.h"

@protocol TaoBaoViewScrolling
@required
-(void)viewIsScrolling:(UIScrollView *)scrollView;
@end

@interface TaoBaoTableView : UITableView
@property(nonatomic,retain)TaoBaoItemListSceneModel *sceneModel;
@property(nonatomic,weak)id<TaoBaoViewScrolling> scrollingDelegate;
-(void)startRAC:(NSUInteger)index withMain:(BOOL)isMain;
@end
