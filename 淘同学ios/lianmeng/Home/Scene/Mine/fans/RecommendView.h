//
//  RecommendView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/24.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserFansNumModel.h"

@interface RecommendView : UIView
-(void)reloadData:(UserFansNumModel *)model;
@end
