//
//  OrderScrollView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SceneScrollView.h"
#import "OrderHeaderView.h"

@interface OrderScrollView : SceneScrollView
@property(nonatomic,weak)id<OrderHeaderViewDelegate> tabDelegate;
-(instancetype)initWithFrame:(CGRect)frame subViewCount:(NSUInteger)count;

@property(nonatomic,assign)NSUInteger platformId;
@property(nonatomic,assign)NSUInteger index;
@end
