//
//  ProfitHeaderView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProfitHeaderViewDelegate
-(void)selectIndex:(NSUInteger)index;
@end

@interface ProfitHeaderView : UIView
-(void)reloadData:(NSString *)str;
@property(nonatomic,weak)id<ProfitHeaderViewDelegate> delegate;
@end
