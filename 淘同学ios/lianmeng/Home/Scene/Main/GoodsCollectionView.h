//  GoodsCollectionView.h
//  lianmeng
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import <UIKit/UIKit.h>
#import "SearchView.h"
@interface GoodsCollectionView : UICollectionView
@property(nonatomic,weak)id<SearchViewAnimation> animationDelegate;
-(void)reloadBannerData:(NSArray *)bannerList;
-(void)reloadGoodsData:(NSArray *)array;
@end
