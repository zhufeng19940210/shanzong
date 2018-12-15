//
//  ShareBottomView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/27.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShareDelegate
-(void)shareWechat;
-(void)shareTimeLine;
-(void)copyText;
@end
@interface ShareBottomView : UIView
@property(nonatomic,weak)id<ShareDelegate> delegate;
@end

