//
//  OrderCell.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserOrderListModel.h"
@interface OrderCell : UITableViewCell
-(void)reloadData:(UserOrderModel *)model;
@end
