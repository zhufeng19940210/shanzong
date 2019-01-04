//  ProductContentCell.m
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.

#import "ProductContentCell.h"

@implementation ProductContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.yuji_btn.layer.cornerRadius = 10.0f;
    self.yuji_btn.layer.masksToBounds = YES;
    self.yuji_btn.layer.borderColor = [UIColor redColor].CGColor;
    self.yuji_btn.layer.borderWidth = 1.0f;
    self.shengji_btn.layer.cornerRadius = 10.0f;
    self.shengji_btn.layer.masksToBounds = YES;
    self.shengji_btn.layer.borderColor = [UIColor redColor].CGColor;
    self.shengji_btn.layer.borderWidth = 1.0f;
}
@end
