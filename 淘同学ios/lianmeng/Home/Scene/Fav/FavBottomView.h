//
//  FavBottomView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/20.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FavSelectAllDelegate
-(void)selectAll:(BOOL)selected;
-(void)share;
@end

@interface FavBottomView : UIView
@property(nonatomic,weak)id<FavSelectAllDelegate> delegate;
@end


