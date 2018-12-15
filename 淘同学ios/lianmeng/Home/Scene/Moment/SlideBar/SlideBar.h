//
//  SlideBar.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/3.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SlideBarDelegate
@required
-(void)switchIndex:(NSUInteger)idx;
@end

@interface SlideBar : UIView
@property(nonatomic,weak) id<SlideBarDelegate> delegate;
-(void)setHeightLight:(NSUInteger) idx;
@end
