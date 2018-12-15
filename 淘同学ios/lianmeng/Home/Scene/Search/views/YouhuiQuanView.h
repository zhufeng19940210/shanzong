//
//  YouhuiQuanView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/17.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YouhuiQuanViewDelegate
-(void)switchYHQ:(NSUInteger)isCoupon;
@end
@interface YouhuiQuanView : UIView
@property(nonatomic,weak)id<YouhuiQuanViewDelegate> delegate;
@end
