//
//  FansCell.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/27.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansListModel.h"
@interface FansCell : UITableViewCell
-(void)reloadData:(FansModel *)model;
@end
