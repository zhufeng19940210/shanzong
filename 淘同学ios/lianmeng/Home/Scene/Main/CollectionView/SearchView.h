//
//  SearchView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewAnimation
@required
-(void)animationWithPercent:(CGFloat)percent;
@end

@interface SearchView : UIView<SearchViewAnimation>

@end
