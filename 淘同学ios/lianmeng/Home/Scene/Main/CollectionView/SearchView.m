//
//  SearchView.m
//  lianmeng
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved
#import "SearchView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "SearchScene.h"
#import "FavScene.h"

@interface SearchView()
@property(nonatomic,retain)UIView *bgView;
@property(nonatomic,retain)UIImageView *iconImage;
@property(nonatomic,retain)UILabel *placeHolderLabel;
@property(nonatomic,retain)UIButton *favButton;
@property(nonatomic,strong)UIButton *scanButton;
@end

@implementation SearchView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        //扫描button
        _scanButton =[[UIButton alloc]init];
        [_scanButton setImage:[UIImage imageNamed:@"fav2"] forState:UIControlStateNormal];
        [self addSubview:_scanButton];
        ///消息button
        _favButton = [[UIButton alloc]init];
        [_favButton setImage:[UIImage imageNamed:@"fav2"] forState:UIControlStateNormal];
        [self addSubview:_favButton];
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 14.0f;
        _bgView.layer.borderColor = [UIColor colorWithString:@"#888888"].CGColor;
        [self addSubview:_bgView];
        
        
        _iconImage = [[UIImageView alloc]init];
        [_iconImage setImage:[UIImage imageNamed:@"sousuo"]];
        [_bgView addSubview:_iconImage];
        
        
        _placeHolderLabel = [[UILabel alloc]init];
        _placeHolderLabel.text = @"粘贴宝贝标题，先领券，再购物";
        _placeHolderLabel.textColor = [UIColor colorWithString:@"#888888"];
        _placeHolderLabel.font = [UIFont systemFontOfSize:12.0f];
        [_bgView addSubview:_placeHolderLabel];
        
        [self loadAutoLayout];
        
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSearch)]];
        [_favButton addTarget:self action:@selector(showFav) forControlEvents:UIControlEventTouchUpInside];
        [_scanButton addTarget:self action:@selector(actionScan) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)loadAutoLayout{
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(10.0f);
    }];
    
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(self.iconImage.mas_right).offset(10.0f);
        make.right.equalTo(self.bgView).offset(-10.0f).priorityLow();
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@28.0f);
        make.bottom.equalTo(self).offset(-10.0f);
        make.left.equalTo(self).offset(20.0f);
        make.right.equalTo(self.favButton.mas_left).offset(-20.0f);
    }];
    
    
    [_favButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.equalTo(self).offset(-20.0f);
    }];
}

-(void)animationWithPercent:(CGFloat)percent{
    self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:percent];
    if (percent >=0.5) {
        _bgView.layer.borderWidth = 0.5f;
        [_favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
    }else{
        _bgView.layer.borderWidth = 0.0f;
        [_favButton setImage:[UIImage imageNamed:@"fav2"] forState:UIControlStateNormal];
    }
    
    [[[URLNavigation navigation] currentViewController] setNeedsStatusBarAppearanceUpdate];
    
}

-(void)showFav{
    FavScene *scene = [[FavScene alloc]init];
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}
-(void)showSearch{
    SearchScene *scene = [[SearchScene alloc]init];
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}

-(void)actionScan
{
    NSLog(@"");
    
}

@end
