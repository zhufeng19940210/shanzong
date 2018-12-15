//
//  TimeSelectView.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSegModel.h"

@protocol TimeSelectDelegate
-(void)didSelectItemAtIndex:(NSUInteger)idx;
@end

@interface TimeSelectItem : UIView
-(void)setTime:(NSString *)time setStatus:(NSNumber *)status;
@end
@interface TimeSelectView : UIView

@property(nonatomic,weak)id<TimeSelectDelegate> delegate;
-(void)loadData:(NSArray *)list;
@end
