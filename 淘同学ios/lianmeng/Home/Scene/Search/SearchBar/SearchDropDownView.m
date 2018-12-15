//
//  SearchDropDownView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/13.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SearchDropDownView.h"
#import <Masonry/Masonry.h>

@interface SearchDropDownView()
@end
@implementation SearchDropDownView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _button1 = [[UIButton alloc]init];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button1 setTitle:@"淘宝" forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont fontWithName:MediumFont size:14.0f];
        [self addSubview:_button1];
        
        _button2 = [[UIButton alloc]init];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button2 setTitle:@"京东" forState:UIControlStateNormal];
        _button2.titleLabel.font = [UIFont fontWithName:MediumFont size:14.0f];
        [self addSubview:_button2];
        
        [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@30.0f);
        }];
        
        [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@30.0f);
            make.top.equalTo(self.button1.mas_bottom);
        }];
    }
    return self;
}

@end
