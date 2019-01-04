//  PrductFooterReusableView.m
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.

#import "PrductFooterReusableView.h"

@implementation PrductFooterReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/**
 领取优惠券
 @param sender 领取优惠券
 */
- (IBAction)actionyouhuiquianBtn:(UIButton *)sender
{
    if (self.actionblock) {
        self.actionblock();
    }
}
@end
