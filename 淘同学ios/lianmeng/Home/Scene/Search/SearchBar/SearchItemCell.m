//
//  SearchItemCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/13.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SearchItemCell.h"

@interface SearchItemCell()
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *titleLabel;
@end

@implementation SearchItemCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageView];
        _imageView.image =[UIImage imageNamed:@"lishik"];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 0, frame.size.width - 10.0f, frame.size.height)];
        [self addSubview:_titleLabel];
        _titleLabel.font = [UIFont fontWithName:MediumFont size:14.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}
@end
