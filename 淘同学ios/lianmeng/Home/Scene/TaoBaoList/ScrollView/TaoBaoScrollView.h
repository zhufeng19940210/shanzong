//
//  TaoBaoScrollView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/14.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TaoBaoTableView.h"
#import "TabView.h"

@interface TaoBaoScrollView : UIScrollView
@property(nonatomic,weak)id<TabViewDelegate> tabDelegate;
-(instancetype)initWithFrame:(CGRect)frame subViewCount:(NSUInteger)count
                  platformId:(NSUInteger)platformId
                    delegate:(id<TaoBaoViewScrolling>)scrollingDelegate;
@end
