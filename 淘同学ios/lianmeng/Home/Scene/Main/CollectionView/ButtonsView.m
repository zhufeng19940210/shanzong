//  ButtonsView.m
//  lianmeng
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "ButtonsView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
#import "TaoBaoListScene.h"
#import "RankScene.h"
#import "CategoryListScene.h"

@interface ButtonsView()
@property(nonatomic,retain)UIImageView *tbImage;
@property(nonatomic,retain)UILabel *tbLabel;

@property(nonatomic,retain)UIImageView *jdImage;
@property(nonatomic,retain)UILabel *jdLabel;

@property(nonatomic,retain)UIImageView *rankImage;
@property(nonatomic,retain)UILabel *rankLabel;

@property(nonatomic,retain)UIImageView *zhuanImage;
@property(nonatomic,retain)UILabel *zhuanLabel;

@end
@implementation ButtonsView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _tbImage = [[UIImageView alloc]init];
        _tbImage.userInteractionEnabled = YES;
        [_tbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage:)]];
        [_tbImage setImage:[UIImage imageNamed:@"taobao"]];
        [self addSubview:_tbImage];
        
        _tbLabel = [[UILabel alloc]init];
        _tbLabel.text = @"淘宝";
        _tbLabel.font = [UIFont systemFontOfSize:14.0f];
        _tbLabel.textColor = [UIColor colorWithString:@"#323232"];
        [self addSubview:_tbLabel];
        
        _jdImage = [[UIImageView alloc]init];
        _jdImage.userInteractionEnabled = YES;
        [_jdImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage:)]];
        [_jdImage setImage:[UIImage imageNamed:@"jingdong"]];
        [self addSubview:_jdImage];
        
        _jdLabel = [[UILabel alloc]init];
        _jdLabel.text = @"京东";
        _jdLabel.font = [UIFont systemFontOfSize:14.0f];
        _jdLabel.textColor = [UIColor colorWithString:@"#323232"];
        [self addSubview:_jdLabel];
        
        _rankImage = [[UIImageView alloc]init];
        _rankImage.userInteractionEnabled = YES;
        [_rankImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage:)]];
        [_rankImage setImage:[UIImage imageNamed:@"chaojiquan"]];
        [self addSubview:_rankImage];
        
        _rankLabel = [[UILabel alloc]init];
        _rankLabel.text = @"超级劵";
        _rankLabel.font = [UIFont systemFontOfSize:14.0f];
        _rankLabel.textColor = [UIColor colorWithString:@"#323232"];
        [self addSubview:_rankLabel];
        
    
        _zhuanImage = [[UIImageView alloc]init];
        _zhuanImage.userInteractionEnabled = YES;
        [_zhuanImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage:)]];
        [_zhuanImage setImage:[UIImage imageNamed:@"chaojizhuan"]];
        [self addSubview:_zhuanImage];
        
        _zhuanLabel = [[UILabel alloc]init];
        _zhuanLabel.text = @"超级赚";
        _zhuanLabel.font = [UIFont systemFontOfSize:14.0f];
        _zhuanLabel.textColor = [UIColor colorWithString:@"#323232"];
        [self addSubview:_zhuanLabel];
        
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    NSArray *list = @[_tbImage,_jdImage,_rankImage,_zhuanImage];
    
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15.0f);
    }];
    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                   withFixedItemLength:45.0f
                           leadSpacing:25.0f tailSpacing:25.0f];
    
    [_tbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tbImage.mas_bottom).offset(10.0f);
        make.centerX.equalTo(self.tbImage);
        make.bottom.equalTo(self).offset(-15.0f);
    }];
    
    [_jdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jdImage.mas_bottom).offset(10.0f);
        make.centerX.equalTo(self.jdImage);
    }];
    
    [_rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rankImage.mas_bottom).offset(10.0f);
        make.centerX.equalTo(self.rankImage);
    }];
    
    [_zhuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zhuanImage.mas_bottom).offset(10.0f);
        make.centerX.equalTo(self.zhuanImage);
    }];
}

-(void)touchImage:(UITapGestureRecognizer *)recognizer{
    if ([recognizer.view isEqual:_tbImage]) {
        TaoBaoListScene *scene = [[TaoBaoListScene alloc]init];
        scene.platformId = 1;
        [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
    }else if ([recognizer.view isEqual:_jdImage]) {
        TaoBaoListScene *scene = [[TaoBaoListScene alloc]init];
        scene.platformId = 2;
        [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
    }else if ([recognizer.view isEqual:_rankImage]) {
        CategoryListScene *scene = [[CategoryListScene alloc]init];
        scene.type = 5;
        [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
        
    }else if ([recognizer.view isEqual:_zhuanImage]){
        CategoryListScene *scene = [[CategoryListScene alloc]init];
            scene.type = 6;
        [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
    }
}

@end
