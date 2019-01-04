//  ProductHeaderReusableView.h
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
@interface ProductHeaderReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet SDCycleScrollView *adscrollview;
@property (nonatomic,strong)NSMutableArray *imgArray;
@end
