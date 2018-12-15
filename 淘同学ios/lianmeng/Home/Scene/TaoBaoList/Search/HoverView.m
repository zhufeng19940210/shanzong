//
//  HoverView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/16.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "HoverView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
@interface HoverView()
@end
@implementation HoverView

-(instancetype)initWithFrame:(CGRect)frame platformId:(NSUInteger)platformId{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *blackView = [[UIView alloc]init];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.7f;
        [self addSubview:blackView];
        
        [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(self);
        }];

        
        UIView *whiteView = [[UIView alloc]init];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor blackColor];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@0.5f);
            make.top.equalTo(self).offset(20.0f);
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.text = @"选择分类";
        tipLabel.font = [UIFont fontWithName:RegularFont size:16.0f];
        tipLabel.textColor = [UIColor colorWithRed:0.694 green:0.694 blue:0.694 alpha:1.0f];
        tipLabel.backgroundColor = [UIColor whiteColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.center.equalTo(line);
            make.width.equalTo(@100.0f);
            make.height.equalTo(@16.0f);
        }];
        
        NSArray *list = @[];
        
        if (platformId == 1) {
            list = @[@"今日优选",@"女装",@"男装",@"美妆",@"配饰",@"鞋品",@"箱包",@"儿童",@"母婴",@"居家",@"美食",@"数码",@"家电",@"其他",@"车品",@"文体"];
        }else{
            list = @[@"今日优选",@"女装",@"男装",@"母婴玩具",@"美妆个护",@"食品保健",@"居家生活",@"箱品箱包",@"运动户外",@"车品文体",@"数码家电"];
        }
        
        NSUInteger numPerRow = 4;
        CGFloat width = 80.0f;
        CGFloat height = 40.0f;
        CGFloat padding = (frame.size.width -width*numPerRow)/(numPerRow + 1);
        
        for (NSString *title in list) {
            NSUInteger index = [list indexOfObject:title];
            CGFloat x = padding + (index%numPerRow)*(padding + width);
            CGFloat y = 50.0f+(index/numPerRow)*(padding + height);
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
            btn.tag = index;
            btn.titleLabel.font = [UIFont fontWithName:RegularFont size:17.0f];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithString:@"#F4F4F4"];
            [btn addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        CGFloat bgheight = 50.0f + (padding + 40.0f)*5;
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(bgheight));
        }];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
    }
    return self;
}

-(void)touchButton:(UIButton *)button{
    if (self.tabDelegate) {
        [self.tabDelegate moveBlackViewToIndex:button.tag];
         [self.tabDelegate tabBarDidChange:button.tag];
    }
    [self hiddenSelf];
}


-(void)hiddenSelf{
    self.hidden = YES;
}
-(void)showSelectedItem:(NSUInteger)index{
    NSArray *buttons = [self.subviews filter:^BOOL(UIView* view) {
        return [view isKindOfClass:[UIButton class]];
    }];
    for (UIButton *btn in buttons) {
        if (btn.tag == index) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor blackColor];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithString:@"#F4F4F4"];
        }
        
    }
}
@end
