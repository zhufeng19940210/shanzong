//  ConetentScrollCell.h
//  lianmeng
//  Created by zhufeng on 2018/12/14.
//  Copyright © 2018 zhuchao. All rights reserved.
#import <UIKit/UIKit.h>
#import "GoodsListModel.h"
typedef void(^ProductTypeBlock)(GoodsModel *typeModel);
@interface ConetentScrollCell : UICollectionViewCell
@property (nonatomic,strong)NSArray *productTypeArray;
@property (nonatomic,copy)ProductTypeBlock producttypeblock;
@end
