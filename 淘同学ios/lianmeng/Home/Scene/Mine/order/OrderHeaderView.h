//
//  OrderHeaderView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OrderHeaderViewDelegate
-(void)touchSortByIndex:(NSUInteger)index;
-(void)selectPlatformByIndex:(NSUInteger)index;
-(void)moveBlackViewToIndex:(NSUInteger)index;
@end

@interface OrderHeaderView : UIView
@property(nonatomic,weak)id<OrderHeaderViewDelegate> delegate;
@end
