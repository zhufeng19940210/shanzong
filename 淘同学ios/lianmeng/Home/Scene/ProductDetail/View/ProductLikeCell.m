//  ProductLikeCell.m
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
#import "ProductLikeCell.h"
@implementation ProductLikeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon_img.layer.cornerRadius = 25.0f;
    self.icon_img.layer.masksToBounds = YES;
}
@end
