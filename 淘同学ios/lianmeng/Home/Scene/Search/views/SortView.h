//
//  SortView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/17.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SortViewDelegate
-(void)changeSort:(NSUInteger)sort;
@end
@interface SortView : UIView
@property(nonatomic,weak)id<SortViewDelegate> delegate;
@end

