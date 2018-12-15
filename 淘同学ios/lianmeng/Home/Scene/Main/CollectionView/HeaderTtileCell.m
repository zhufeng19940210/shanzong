//  HeaderTtileCell.m
//  lianmeng
//  Created by zhufeng on 2018/12/14.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "HeaderTtileCell.h"
@implementation HeaderTtileCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
/**
 查看更多
 @param sender 查看更多
 */
- (IBAction)actionMoreBtn:(UIButton *)sender
{
    if (self.moreblock) {
        self.moreblock();
    }
}
@end
