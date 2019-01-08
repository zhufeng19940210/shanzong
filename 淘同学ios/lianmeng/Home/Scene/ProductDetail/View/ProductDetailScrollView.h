//  ProductDetailScrollView.h
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
#import <UIKit/UIKit.h>
#import "GoodsListModel.h"
@interface ProductDetailScrollView : UICollectionView
-(void)reloadDetailWithDic:(NSDictionary *)dict withModel:(GoodsModel *)model;
@end
