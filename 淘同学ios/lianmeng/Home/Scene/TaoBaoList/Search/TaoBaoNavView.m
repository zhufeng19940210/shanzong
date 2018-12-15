//
//  TaoBaoNavView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/13.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TaoBaoNavView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "SearchScene.h"
#import "FavScene.h"

@interface TaoBaoNavView()
@property(nonatomic,retain)UILabel *leftTitle;

@property(nonatomic,retain)UIView *bgView;
@property(nonatomic,retain)UIImageView *iconImage;
@property(nonatomic,retain)UILabel *placeHolderLabel;
@property(nonatomic,retain)UIButton *favButton;

@end
@implementation TaoBaoNavView

-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _blackBack = [[UIButton alloc]init];
        [_blackBack setImage:[UIImage imageNamed:@"blackBack"] forState:UIControlStateNormal];
        [self addSubview:_blackBack];
        
        _leftTitle = [[UILabel alloc]init];
        _leftTitle.text = title;
        _leftTitle.textColor = [UIColor blackColor];
        _leftTitle.font = [UIFont fontWithName:BoldFont size:18.0f];
        [self addSubview:_leftTitle];
        
        _favButton = [[UIButton alloc]init];
        [_favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [self addSubview:_favButton];
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 3.0f;
        _bgView.layer.borderWidth = 0.5f;
        _bgView.layer.borderColor = [UIColor colorWithString:@"#888888"].CGColor;
        [self addSubview:_bgView];
        
        
        _iconImage = [[UIImageView alloc]init];
        [_iconImage setImage:[UIImage imageNamed:@"sousuo"]];
        [_bgView addSubview:_iconImage];
        
        
        _placeHolderLabel = [[UILabel alloc]init];
        _placeHolderLabel.text = @"搜索关键词或粘贴标题";
        _placeHolderLabel.textColor = [UIColor colorWithString:@"#888888"];
        _placeHolderLabel.font = [UIFont systemFontOfSize:12.0f];
        [_bgView addSubview:_placeHolderLabel];
        
        [self loadAutoLayout];
        
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSearch)]];
        [_favButton addTarget:self action:@selector(showFav) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



-(void)loadAutoLayout{
    
    [_blackBack mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self).offset(6.0f);
        make.centerY.equalTo(self.bgView);
        make.width.height.equalTo(@32.0f);
    }];
    
    [_leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blackBack.mas_right);
        make.centerY.equalTo(self.blackBack);
    }];
    
    
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
        make.left.equalTo(self.leftTitle.mas_right).offset(15.0f);
        make.right.equalTo(self.favButton.mas_left).offset(-20.0f);
    }];
    
    
    [_favButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.equalTo(self).offset(-20.0f);
    }];
}

-(void)showFav{
    FavScene *scene = [[FavScene alloc]init];
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}
-(void)showSearch{
    SearchScene *scene = [[SearchScene alloc]init];
    scene.platform = _leftTitle.text;
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}

@end
