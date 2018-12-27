//  SortSearchView.h
//  lianmeng
//  Created by zhufeng on 2018/12/27.
//  Copyright © 2018 zhuchao. All rights reserved.

#import <UIKit/UIKit.h>
@protocol SortSearchViewDelegate
-(void)changeSortType:(NSUInteger)sort;
@end
@interface SortSearchView : UIView
@property (nonatomic,weak) id <SortSearchViewDelegate> delegate;
@end
