//
//  SearchContentView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/12.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchContentViewDelegate
-(void)kewordDidTouched:(NSString *)keyword;
@end
@interface SearchContentView : UIView
@property(nonatomic,weak)id<SearchContentViewDelegate> delegate;
-(void)addKeyWord:(NSString *)keyword;
@end
