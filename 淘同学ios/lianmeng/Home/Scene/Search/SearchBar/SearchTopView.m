//  SearchTopView.m
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "SearchTopView.h"
#import <Masonry/Masonry.h>
@interface SearchTopView()
@property(nonatomic,strong)UIImageView *bgView;
@end
@implementation SearchTopView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [[UIImageView alloc]init];
        [self addSubview:_bgView];
        _bgView.backgroundColor = self.bgColor;
        _leftButton = [[UIButton alloc]init];
        [self addSubview:_leftButton];
        [_leftButton setImage:[UIImage imageNamed:@"search-back"] forState:UIControlStateNormal];
        _titlelab = [[UILabel alloc]init];
        _titlelab.textColor = [UIColor whiteColor];
        _titlelab.font = [UIFont systemFontOfSize:18];
        _titlelab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titlelab];
        [self loadAutoLayout];
    }
    return self;
}
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    _bgView.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
//    _titlelab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
//
//}
-(void)loadAutoLayout
{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0.0f);
        make.left.equalTo(self).offset(0.0f);
        make.right.equalTo(self).offset(0.0f);
        make.bottom.equalTo(self).offset(0.0f);
    }];
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-3.0f);
        make.left.equalTo(self).offset(15.0f);
        make.width.equalTo(@30.0f);
        make.height.equalTo(@30.0f);
    }];
    
    [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftButton.mas_centerY);
        make.left.equalTo(self).offset(0.0f);
        make.right.equalTo(self).offset(0.0f);
    }];
}
@end
