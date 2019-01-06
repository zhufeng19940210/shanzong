//  ProductBottomView.m
//  lianmeng
//  Created by zhufeng on 2019/1/6.
//  Copyright © 2019 zhuchao. All rights reserved.

#import "ProductBottomView.h"

@implementation ProductBottomView

+ (instancetype)filterView
{
    ProductBottomView *aView = [[[NSBundle mainBundle] loadNibNamed:@"ProductBottomView" owner:self options:nil] lastObject];
    return aView;
}
/**
 收藏按钮
 @param sender 收藏按钮
 */
- (IBAction)actionLoveBtn:(UIButton *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(ProductBottomWithTag:)]) {
            [self.delegate ProductBottomWithTag:(int)sender.tag];
        }
    }
}
/**
 分享赚
 @param sender 分享赚
 */
- (IBAction)actionMiddleBtn:(UIButton *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(ProductBottomWithTag:)]) {
            [self.delegate ProductBottomWithTag:(int)sender.tag];
        }
    }
}
/**
 自己买
 @param sender 自己买
 */
- (IBAction)actionThirdBtn:(UIButton *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(ProductBottomWithTag:)]) {
            [self.delegate ProductBottomWithTag:(int)sender.tag];
        }
    }
}
@end
