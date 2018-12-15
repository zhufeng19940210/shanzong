//
//  FansSearchView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/27.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FansSearchView.h"
#import <Masonry/Masonry.h>

@interface FansSearchView()
@property(nonatomic,retain)UIImageView *searchImageView;
@property(nonatomic,retain)UIView *bgView;
@end


@implementation FansSearchView

-(instancetype)init{
    self = [super init];
    if (self) {
        _bgView  = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 5.0f;
        _bgView.layer.borderColor = [UIColor grayColor].CGColor;
        _bgView.layer.borderWidth = 1.0f;
        [self addSubview:_bgView];
        
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"请输入昵称或手机号";
        [_bgView addSubview:_textField];
        
        _searchImageView = [[UIImageView alloc]init];
        _searchImageView.image = [UIImage imageNamed:@"search"];
        [self addSubview:_searchImageView];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self).offset(15.0f);
        make.right.equalTo(self).offset(-15.0f);
        make.top.equalTo(self).offset(10.0f);
        make.bottom.equalTo(self).offset(-10.0f);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10.0f);
        make.top.equalTo(self.bgView).offset(5.0f);
        make.bottom.equalTo(self.bgView).offset(-5.0f);
    }];
    
    [_searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_right).offset(10.0f);
        make.right.equalTo(self.bgView).offset(-10.0f);
        make.centerY.equalTo(self.textField);
        make.width.equalTo(@15.0f);
    }];
}



@end

