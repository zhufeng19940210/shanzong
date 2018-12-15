//
//  FavCell.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/19.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsListModel.h"

@protocol FavDelegate
-(void)selectItem:(GoodsModel *)model;
-(void)unselectItem:(GoodsModel *)model;
@end
@interface FavCell : UITableViewCell
@property(nonatomic,weak)id<FavDelegate> delegate;
-(void)setModel:(GoodsModel *)model;
-(void)setItemSelected:(BOOL)selected;
@end
