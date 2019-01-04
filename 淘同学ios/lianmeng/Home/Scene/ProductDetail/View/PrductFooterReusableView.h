//
//  PrductFooterReusableView.h
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.

#import <UIKit/UIKit.h>
typedef void(^actionBlock)(void);
@interface PrductFooterReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *price_lab;
@property (weak, nonatomic) IBOutlet UILabel *count_lab;
@property (weak, nonatomic) IBOutlet UIButton *youhunqiuan_btn;
@property (weak, nonatomic) IBOutlet UILabel *total_price_lab;
@property (nonatomic,copy)actionBlock actionblock;
@end
