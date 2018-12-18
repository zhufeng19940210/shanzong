//  CollectionViewCell.m
//  Linkage
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(3, 10, self.frame.size.width - 30, self.frame.size.width - 30)];
        self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageV];

        self.name = [[UILabel alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(self.imageV.frame) + 5, self.frame.size.width-30, 30)];
        self.name.font = [UIFont systemFontOfSize:12];
        self.name.numberOfLines = 0 ;
        self.name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.name];
    }
    return self;
}

@end
