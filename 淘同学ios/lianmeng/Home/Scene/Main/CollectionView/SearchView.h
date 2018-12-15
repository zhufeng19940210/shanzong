//  SearchView.h
//  lianmeng
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved
#import <UIKit/UIKit.h>

typedef void (^SearchBlock)(void);
typedef void (^MessageBlock)(void);
typedef void (^ScanBlock)(void);
@protocol SearchViewAnimation
@required
-(void)animationWithPercent:(CGFloat)percent;
@end
@interface SearchView : UIView<SearchViewAnimation>
@property (nonatomic,copy)SearchBlock  searchblock;
@property (nonatomic,copy)MessageBlock messageblock;
@property (nonatomic,copy)ScanBlock   scanblock;
@end
