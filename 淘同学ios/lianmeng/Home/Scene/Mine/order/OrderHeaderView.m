//
//  OrderHeaderView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "OrderHeaderView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
@interface OrderHeaderView()
@property(nonatomic,retain)UIButton *btn1;
@property(nonatomic,retain)UIButton *btn2;
@property(nonatomic,retain)UIView *textFieldBgView;
@property(nonatomic,retain)UITextField *textField;

@property(nonatomic,retain)UIButton *sortBtn1;
@property(nonatomic,retain)UIButton *sortBtn2;
@property(nonatomic,retain)UIButton *sortBtn3;
@property(nonatomic,retain)UIButton *sortBtn4;
@property(nonatomic,retain)UIButton *sortBtn5;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,retain)MASConstraint *centerXConstraint;
@end
@implementation OrderHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        _btn1 = [[UIButton alloc]init];
        _btn1.backgroundColor = [UIColor whiteColor];
        [_btn1 setTitle:@"淘宝" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor colorWithString:@"rgb(235,93,133)"] forState:UIControlStateSelected];
        [_btn1 setTitleColor:[UIColor colorWithString:@"rgb(136,136,136)"] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont fontWithName:BoldFont size:18.0f];
        [_btn1 addTarget:self action:@selector(selectPlatform:) forControlEvents:UIControlEventTouchUpInside];
        _btn1.tag = 1;
        [self addSubview:_btn1];
        
        _btn1.selected = YES;
        
        _btn2 = [[UIButton alloc]init];
        _btn2.backgroundColor = [UIColor whiteColor];
        [_btn2 setTitle:@"京东" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor colorWithString:@"rgb(235,93,133)"] forState:UIControlStateSelected];
        [_btn2 setTitleColor:[UIColor colorWithString:@"rgb(136,136,136)"] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont fontWithName:BoldFont size:18.0f];
        [_btn2 addTarget:self action:@selector(selectPlatform:) forControlEvents:UIControlEventTouchUpInside];
        _btn2.tag = 2;
        [self addSubview:_btn2];
        
        _textFieldBgView = [[UIView alloc]init];
        _textFieldBgView.backgroundColor = [UIColor whiteColor];
        _textFieldBgView.layer.cornerRadius = 5.0f;
        [self addSubview:_textFieldBgView];
        
        UIImageView *sousuo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sousuo"]];
        [self.textFieldBgView addSubview:sousuo];
        [sousuo mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.textFieldBgView);
            make.left.equalTo(self.textFieldBgView).offset(10.0f);
        }];
        
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont fontWithName:RegularFont size:13.0f];
        _textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索订单编号"
                                                                               attributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"rgb(136,136,136)"]}];
        [self.textFieldBgView addSubview:_textField];
        
        
        _sortBtn1 = [[UIButton alloc]init];
        _sortBtn1.backgroundColor = [UIColor whiteColor];
        [_sortBtn1 setTitle:@"全部" forState:UIControlStateNormal];
        _sortBtn1.titleLabel.font = [UIFont fontWithName:BoldFont size:15.0f];
        [_sortBtn1 setTitleColor:[UIColor colorWithString:@"rgb(102,102,102)"] forState:UIControlStateNormal];
        [self addSubview:_sortBtn1];
        
        _sortBtn2 = [[UIButton alloc]init];
        _sortBtn2.backgroundColor = [UIColor whiteColor];
        [_sortBtn2 setTitle:@"已付款" forState:UIControlStateNormal];
        _sortBtn2.titleLabel.font = [UIFont fontWithName:RegularFont size:15.0f];
        [_sortBtn2 setTitleColor:[UIColor colorWithString:@"rgb(102,102,102)"] forState:UIControlStateNormal];
        [self addSubview:_sortBtn2];
        
        _sortBtn3 = [[UIButton alloc]init];
        _sortBtn3.backgroundColor = [UIColor whiteColor];
        [_sortBtn3 setTitle:@"已收货" forState:UIControlStateNormal];
        _sortBtn3.titleLabel.font = [UIFont fontWithName:RegularFont size:15.0f];
        [_sortBtn3 setTitleColor:[UIColor colorWithString:@"rgb(102,102,102)"] forState:UIControlStateNormal];
        [self addSubview:_sortBtn3];
        
        
        _sortBtn4 = [[UIButton alloc]init];
        _sortBtn4.backgroundColor = [UIColor whiteColor];
        [_sortBtn4 setTitle:@"已结算" forState:UIControlStateNormal];
        _sortBtn4.titleLabel.font = [UIFont fontWithName:RegularFont size:15.0f];
        [_sortBtn4 setTitleColor:[UIColor colorWithString:@"rgb(102,102,102)"] forState:UIControlStateNormal];
        [self addSubview:_sortBtn4];
        
        _sortBtn5 = [[UIButton alloc]init];
        _sortBtn5.backgroundColor = [UIColor whiteColor];
        [_sortBtn5 setTitle:@"已失效" forState:UIControlStateNormal];
        _sortBtn5.titleLabel.font = [UIFont fontWithName:RegularFont size:15.0f];
        [_sortBtn5 setTitleColor:[UIColor colorWithString:@"rgb(102,102,102)"] forState:UIControlStateNormal];
        [self addSubview:_sortBtn5];
        
        _sortBtn1.tag = 0;
        _sortBtn2.tag = 1;
        _sortBtn3.tag = 2;
        _sortBtn4.tag = 3;
        _sortBtn5.tag = 4;
        
        [_sortBtn1 addTarget:self action:@selector(touchSortBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_sortBtn2 addTarget:self action:@selector(touchSortBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_sortBtn3 addTarget:self action:@selector(touchSortBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_sortBtn4 addTarget:self action:@selector(touchSortBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_sortBtn5 addTarget:self action:@selector(touchSortBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_lineView];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(@(ScreenW/2-0.5));
        make.height.equalTo(@50.0f);
    }];
    
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.btn1.mas_right).offset(1.0f);
        make.width.equalTo(@(ScreenW/2-0.5));
        make.height.equalTo(@50.0f);
    }];
    
    [_textFieldBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self).offset(-20.0f);
        make.top.equalTo(self.btn1.mas_bottom).offset(20.0f);
        make.height.equalTo(@40.0f);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textFieldBgView);
        make.left.equalTo(self.textFieldBgView).offset(38.0f);
        make.right.equalTo(self.textFieldBgView).offset(-20.0f);
        make.height.equalTo(@18.0f);
    }];
    
    NSArray *list = @[_sortBtn1,_sortBtn2,_sortBtn3,_sortBtn4,_sortBtn5];
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.equalTo(@40.0f);
        make.bottom.equalTo(self);
    }];
    
    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.equalTo(@2.0f);
        make.bottom.equalTo(self);
        make.width.equalTo(@17.0f);
        self.centerXConstraint = make.centerX.equalTo(self.sortBtn1);
    }];
}


-(void)selectPlatform:(UIButton *)btn{
    if ([btn isEqual:_btn1]) {
        _btn2.selected = NO;
        _btn1.selected = YES;
    }else {
        _btn1.selected = NO;
        _btn2.selected = YES;
    }
    if (self.delegate) {
        [self.delegate selectPlatformByIndex:btn.tag];
    }
}

-(void)moveBlackViewToIndex:(NSUInteger)index{
    if (index == 0) {
        [self moveToBtn:_sortBtn1];
    }else if (index == 1) {
        [self moveToBtn:_sortBtn2];
    }else if (index == 2) {
        [self moveToBtn:_sortBtn3];
    }else if (index == 3) {
        [self moveToBtn:_sortBtn4];
    }else if (index == 4) {
        [self moveToBtn:_sortBtn5];
    }
}

-(void)moveToBtn:(UIButton *)btn{
    [self.centerXConstraint uninstall];
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.centerXConstraint = make.centerX.equalTo(btn);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    NSArray *list = @[_sortBtn1,_sortBtn2,_sortBtn3,_sortBtn4,_sortBtn5];
    
    for (UIButton *item in list) {
        if ([btn isEqual:item]) {
            item.titleLabel.font =  [UIFont fontWithName:MediumFont size:15.0f];
        }else{
            item.titleLabel.font =  [UIFont fontWithName:RegularFont size:15.0f];
        }
    }
}

-(void)touchSortBtn:(UIButton *)btn{
    [self moveToBtn:btn];
    
    if (self.delegate) {
        [self.delegate touchSortByIndex:btn.tag];
    }
}



@end
