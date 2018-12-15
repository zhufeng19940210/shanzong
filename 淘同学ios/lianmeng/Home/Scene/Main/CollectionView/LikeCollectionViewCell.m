//
//  LikeCollectionViewCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "LikeCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
@interface LikeCollectionViewCell()
@property(nonatomic,retain)UIImageView *imageView;
@end
@implementation LikeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(self);
        }];
    }
    return self;
}
-(void)setImage:(UIImage *)image{
    [_imageView setImage:image];
}

-(void)setImageURL:(NSString *)url{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url]];
}
@end
