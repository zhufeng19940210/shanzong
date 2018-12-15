//
//  TabView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/14.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TabView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface TabView()
@property(nonatomic,retain)UIButton *button0;
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIView *bottomBlackView;
@property(nonatomic,retain)UIView *bottomBlackView2;
@property(nonatomic,retain)NSArray *list;
@end

@implementation TabView

-(instancetype)initWithFrame:(CGRect)frame platformId:(NSUInteger)platformId{
    self = [super initWithFrame:frame];
    if (self) {
        self.selected = 0;
        
        if (platformId == 1) {
            self.list = @[@"女装",@"男装",@"美妆",@"配饰",@"鞋品",@"箱包",@"儿童",@"母婴",@"居家",@"美食",@"数码",@"家电",@"其他",@"车品",@"文体"];
        }else{
            self.list = @[@"女装",@"男装",@"母婴",@"美妆",@"食品",@"居家",@"箱包",@"运动",@"车品",@"数码"];
        }
        
        
        _button0 = [[UIButton alloc]init];
        [_button0 setTitle:@"优选" forState:UIControlStateNormal];
        [_button0 setTitleColor:[UIColor colorWithString:@"#181818"] forState:UIControlStateNormal];
        _button0.titleLabel.font = [UIFont fontWithName:BoldFont size:18.0f];
        _button0.tag = 0;
        [_button0 addTarget:self action:@selector(touchScrollBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button0];
        
        _bottomBlackView = [[UIView alloc]init];
        _bottomBlackView.backgroundColor = [UIColor blackColor];
        [self addSubview:_bottomBlackView];
    
        
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        
        for (NSString *str in self.list) {
            NSUInteger index = [self.list indexOfObject:str];
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(index*66.0f, (frame.size.height - 18.0f) /2, 66.0f, 18.0f)];
            btn.tag = index+1;
            [btn setTitle:str forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithString:@"#181818"] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:RegularFont size:18.0f];
            [btn addTarget:self action:@selector(touchScrollBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:btn];
        }
        
        _bottomBlackView2 = [[UIView alloc]initWithFrame:CGRectMake(-66.0f, frame.size.height - 2.0f, 30.0f, 2.0f)];
        _bottomBlackView2.backgroundColor = [UIColor blackColor];
        [_scrollView addSubview:_bottomBlackView2];
        
        _scrollView.contentSize = CGSizeMake(self.list.count * 66.0f+30.0f, frame.size.height);
        
        
        _xialaButton = [[UIButton alloc]init];
        [_xialaButton setImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
        [self addSubview:_xialaButton];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    
    [_button0 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@66.0f);
    }];
    
    [_bottomBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.button0);
        make.bottom.equalTo(self);
        make.width.equalTo(@30.0f);
        make.height.equalTo(@2.0f);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.bottom.equalTo(self);
        make.left.equalTo(self.button0.mas_right);
    }];
    
    [_xialaButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.scrollView.mas_right);
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.width.equalTo(@50.0f);
    }];
    
}


-(void)tabBarDidChange:(NSUInteger)index{
    if (self.delegate) {
        [self.delegate tabBarDidChange:index];
    }
}

-(void)touchScrollBtn:(UIButton *)btn{
    [self moveBlackViewToIndex:btn.tag];
    [self tabBarDidChange:btn.tag];
}

-(void)moveBlackViewToIndex:(NSUInteger)index{
    self.selected = index;
    if (index == 0) {
        CGRect frame = self.bottomBlackView2.frame;
        CGRect to = CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height);
         [self.scrollView scrollRectToVisible:to animated:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomBlackView2.frame = CGRectMake(-66.0f, frame.origin.y, frame.size.width, frame.size.height);
        } completion:^(BOOL finished) {
            self.bottomBlackView.hidden = NO;
        }];
    }else{
        _bottomBlackView.hidden = YES;
        CGRect frame = self.bottomBlackView2.frame;
        CGRect to = CGRectMake((index - 1)*66.0f, frame.origin.y, frame.size.width+100.0f, frame.size.height);
        [self.scrollView scrollRectToVisible:to animated:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomBlackView2.frame = CGRectMake((index - 1)*66.0f+18.0f, frame.origin.y, frame.size.width, frame.size.height);
        }];
    }
}
@end
