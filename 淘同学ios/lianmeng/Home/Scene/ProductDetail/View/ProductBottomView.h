//  ProductBottomView.h
//  lianmeng
//  Created by zhufeng on 2019/1/6.
//  Copyright © 2019 zhuchao. All rights reserved.
#import <UIKit/UIKit.h>
@protocol ProductBottomViewDelegate <NSObject>
-(void)ProductBottomWithTag:(int)productTag;
@end
@interface ProductBottomView : UIView
+ (instancetype)filterView;
@property (weak, nonatomic) IBOutlet UILabel *middle_price_lab;
@property (weak, nonatomic) IBOutlet UILabel *last_price_lab;
@property (weak, nonatomic) IBOutlet UIImageView *love_imag;
@property (weak, nonatomic) IBOutlet UILabel *love_title_lab;
@property (nonatomic,weak)id <ProductBottomViewDelegate> delegate;
@end
