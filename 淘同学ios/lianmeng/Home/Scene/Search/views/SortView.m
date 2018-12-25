//
//  SortView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/17.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SortView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface SortView()
@property(nonatomic,retain)UIButton *btn1;
@property(nonatomic,retain)UIButton *btn2;
@property(nonatomic,retain)UIButton *btn3;
@property(nonatomic,retain)UIButton *btn4;
@property(nonatomic,retain)UIView *blackView;
@property(nonatomic,assign)NSUInteger xiaoliang;
@property(nonatomic,assign)NSUInteger jiage;
@property(nonatomic,retain)UIImageView *priceArrow;
@property(nonatomic,retain)MASConstraint *constraint;
@end
@implementation SortView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5f;
        _btn1 = [[UIButton alloc]init];
        [_btn1 setTitle:@"综合" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor colorWithString:@"#000000"] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        [self addSubview:_btn1];
        
        _btn2 = [[UIButton alloc]init];
        [_btn2 setTitle:@"佣金" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [self addSubview:_btn2];
        
        _btn3 = [[UIButton alloc]init];
        [_btn3 setTitle:@"销量" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [self addSubview:_btn3];
        
        _btn4 = [[UIButton alloc]init];
        [_btn4 setTitle:@"价格" forState:UIControlStateNormal];
        [_btn4 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn4.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [self addSubview:_btn4];
        
        _priceArrow = [[UIImageView alloc]init];
        [_priceArrow setImage:[UIImage imageNamed:@"price-up"]];
        [_btn4 addSubview:_priceArrow];
        
        _blackView = [[UIView alloc]init];
        _blackView.backgroundColor = [UIColor blackColor];
        [self addSubview:_blackView];
        
        [_btn1 addTarget:self action:@selector(sortTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_btn2 addTarget:self action:@selector(sortTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_btn3 addTarget:self action:@selector(sortTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_btn4 addTarget:self action:@selector(sortTouch:) forControlEvents:UIControlEventTouchUpInside];
        //_xiaoliang = 3;
        _jiage = 4;
        [self loadAutoLayout];
    }
    return self;
}

-(void)sortTouch:(UIButton* )btn{
    if ([btn isEqual:_btn1]) {
        [_btn1 setTitleColor:[UIColor colorWithString:@"#000000"] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        [_btn2 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_btn3 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_btn4 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn4.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        if (self.delegate) {
            [self.delegate changeSort:0];
        }
    }else if([btn isEqual:_btn2]){
        [_btn2 setTitleColor:[UIColor colorWithString:@"#000000"] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        [_btn1 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_btn3 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_btn4 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn4.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        if (self.delegate) {
            [self.delegate changeSort:1];
        }
    }else if([btn isEqual:_btn3]){
        [_btn3 setTitleColor:[UIColor colorWithString:@"#000000"] forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        [_btn2 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_btn1 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_btn4 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn4.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        //_xiaoliang = 3;
        if (self.delegate) {
            [self.delegate changeSort:2];
        }
    }else if([btn isEqual:_btn4]){
        [_btn4 setTitleColor:[UIColor colorWithString:@"#000000"] forState:UIControlStateNormal];
        _btn4.titleLabel.font = [UIFont fontWithName:MediumFont size:13.0f];
        [_btn2 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_btn3 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_btn1 setTitleColor:[UIColor colorWithString:@"#363636"] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        _jiage = _jiage==4?5:4;
        if (self.delegate) {
            [self.delegate changeSort:_jiage];
            
        }
        [_priceArrow setImage:[UIImage imageNamed:_jiage == 4?@"price-up":@"price-down"]];
    }
    
    [self.constraint uninstall];
    [_blackView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.constraint = make.centerX.equalTo(btn);
    }];
}

-(void)loadAutoLayout{
    NSArray *list = @[_btn1,_btn2,_btn3,_btn4];
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.0
                           leadSpacing:0.0 tailSpacing:0.0];
    
    [_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(@2.0f);
        make.width.equalTo(@15.0f);
        self.constraint = make.centerX.equalTo(self.btn1);
    }];
    [_priceArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btn4);
        make.centerX.equalTo(self.btn4).offset(18.0f);
    }];
}

@end
