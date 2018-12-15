//
//  HoverView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/16.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabView.h"

@interface HoverView : UIView
@property(nonatomic,weak)id<TabViewDelegate> tabDelegate;
-(void)showSelectedItem:(NSUInteger)index;
-(instancetype)initWithFrame:(CGRect)frame platformId:(NSUInteger)platformId;
@end
