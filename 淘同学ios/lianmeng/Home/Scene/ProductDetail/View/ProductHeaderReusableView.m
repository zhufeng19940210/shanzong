//  ProductHeaderReusableView.m
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
#import "ProductHeaderReusableView.h"

@implementation ProductHeaderReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setImgArray:(NSMutableArray *)imgArray
{
    _imgArray = imgArray;
    self.adscrollview.imageURLStringsGroup = imgArray;
}
@end
