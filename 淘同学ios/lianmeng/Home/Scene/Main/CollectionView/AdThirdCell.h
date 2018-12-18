//  AdThirdCell.h
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
@interface AdThirdCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SDCycleScrollView *adCrollView;
@property (nonatomic,strong)NSMutableArray *urlArray;
@end
