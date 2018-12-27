//  SortSearchView.m
//  lianmeng
//  Created by zhufeng on 2018/12/27.
//  Copyright © 2018 zhuchao. All rights reserved

#import "SortSearchView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface SortSearchView()
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

@implementation SortSearchView
-(instancetype)init
{
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
        _jiage = 1;
        [self loadAutoLayout];
    }
    return self;
}
/*
 新接口 mobile/goods/getKeywordItems 传参和原本的有变化 sort： 0.综合（最新），1.券后价(低到高)，2.券后价（高到低），3.券面额，4.销量，5.佣金比例，6.券面额（低到高），7.月销量（低到高），8.佣金比例（低到高），9.全天销量（高到低），10全天销量（低到高），11.近2小时销量（高到低），12.近2小时销量（低到高），13.优惠券领取量（高到低），14.好单库指数（高到低）
 */

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
            [self.delegate changeSortType:0];
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
            [self.delegate changeSortType:5];
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
        if (self.delegate) {
            [self.delegate changeSortType:4];
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
        _jiage = _jiage==1?2:1;
        [_priceArrow setImage:[UIImage imageNamed:_jiage == 1?@"price-up":@"price-down"]];
        if (self.delegate) {
            [self.delegate changeSortType:_jiage];
        }
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
