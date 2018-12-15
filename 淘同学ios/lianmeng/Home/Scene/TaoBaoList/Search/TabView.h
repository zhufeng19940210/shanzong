//
//  TabView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/14.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TabViewDelegate
-(void)tabBarDidChange:(NSUInteger)index;
-(void)moveBlackViewToIndex:(NSUInteger)index;
@end

@interface TabView : UIView
@property(nonatomic,assign)NSUInteger selected;
@property(nonatomic,retain)UIButton *xialaButton;
@property(nonatomic,weak)id<TabViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame platformId:(NSUInteger)platformId;
@end
