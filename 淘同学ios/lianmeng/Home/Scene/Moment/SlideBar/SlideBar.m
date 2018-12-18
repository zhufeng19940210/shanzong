//
//  SlideBar.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/3.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SlideBar.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>

@interface SlideBar()
@property(nonatomic,retain)UIButton *button1;
@property(nonatomic,retain)UIButton *button2;
@property(nonatomic,retain)UIButton *button3;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,assign)NSUInteger selectedIdx;
@property(nonatomic,retain)MASConstraint *constraint;
@end


@implementation SlideBar

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIColor *red = [UIColor colorWithRed:242.0f/255.0f green:74.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
        UIColor *black = [UIColor colorWithRed:2.0f/255.0f green:2.0f/255.0f blue:2.0f/255.0f alpha:1.0f];
        
        _button1 = [[UIButton alloc]init];
        _button1.tag = 0;
        [_button1 addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        _button1.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_button1 setTitle:@"同学精选" forState:UIControlStateNormal];
        [_button1 setTitleColor:red forState:UIControlStateNormal];
        [_button1 setTitleColor:red forState:UIControlStateHighlighted];
        [self addSubview:_button1];
        
        
        _button2 = [[UIButton alloc]init];
        _button2.tag = 1;
        [_button2 addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        _button2.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_button2 setTitle:@"发圈素材" forState:UIControlStateNormal];
        [_button2 setTitleColor:black forState:UIControlStateNormal];
        [_button2 setTitleColor:red forState:UIControlStateHighlighted];
        [self addSubview:_button2];
        
        _button3 = [[UIButton alloc]init];
        _button3.tag = 2;
        [_button3 addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        _button3.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_button3 setTitle:@"消息通知" forState:UIControlStateNormal];
        [_button3 setTitleColor:black forState:UIControlStateNormal];\
        [_button3 setTitleColor:red forState:UIControlStateHighlighted];
        [self addSubview:_button3];
        
        
        NSArray *list = @[_button1,_button2,_button3];
        
        [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.0f leadSpacing:0 tailSpacing:0];
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-2.0f);
        }];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = red;
        [self addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.button1.mas_width);
            make.height.equalTo(@2.0f);
            make.bottom.equalTo(self);
            self.constraint = make.left.equalTo(self);
        }];
        
    }
    return self;
}

-(void)touchButton:(UIButton *)sender{
    [self setHeightLight:sender.tag];
    if (self.delegate) {
      [self.delegate switchIndex:sender.tag];
    }
}


- (void)updateConstraints {
    [self.constraint uninstall];
    if(_selectedIdx == 0){
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.constraint = make.left.equalTo(self);
        }];
    }else if(_selectedIdx == 1){
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.constraint = make.left.equalTo(self.button1.mas_right);
        }];
    }else if(_selectedIdx == 2){
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.constraint = make.left.equalTo(self.button2.mas_right);
        }];
    }
    [super updateConstraints];
}


-(void)setHeightLight:(NSUInteger) idx{
    _selectedIdx = idx;
    
    UIColor *red = [UIColor colorWithRed:242.0f/255.0f green:74.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
    UIColor *black = [UIColor colorWithRed:2.0f/255.0f green:2.0f/255.0f blue:2.0f/255.0f alpha:1.0f];
    
    if (idx == 0) {
        [_button1 setTitleColor:red forState:UIControlStateNormal];
        [_button2 setTitleColor:black forState:UIControlStateNormal];
        [_button3 setTitleColor:black forState:UIControlStateNormal];
    
    }else if (idx == 1) {
        [_button1 setTitleColor:black forState:UIControlStateNormal];
        [_button2 setTitleColor:red forState:UIControlStateNormal];
        [_button3 setTitleColor:black forState:UIControlStateNormal];

    }else if (idx == 2) {
        [_button1 setTitleColor:black forState:UIControlStateNormal];
        [_button2 setTitleColor:black forState:UIControlStateNormal];
        [_button3 setTitleColor:red forState:UIControlStateNormal];
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];

}

@end
