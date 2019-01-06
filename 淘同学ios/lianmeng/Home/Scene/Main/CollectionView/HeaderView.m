//  HeaderView.m
//  lianmeng
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "HeaderView.h"
#import "MCScrollView.h"
#import "ButtonsView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "DetailScene.h"
#import "BannerListModel.h"
#import "ZFSceneDetail.h"
#import "DetailScene2.h"
@interface HeaderView()<MCScrollViewDelegate>
@property(nonatomic,retain)MCScrollView *spotlightView;
@property(nonatomic,retain)ButtonsView *buttonsView;

@property(nonatomic,retain)NSArray *banners;
@end

@implementation HeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _spotlightView = [[MCScrollView alloc]initWIthFrame:CGRectMake(0, 0, frame.size.width, 202.0f)];
        _spotlightView.delegate = self;
        [self addSubview:_spotlightView];
        
        _buttonsView = [[ButtonsView alloc]init];
        [self addSubview:_buttonsView];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(202.0f);
    }];
}

-(void)reloadBannerData:(NSArray *)bannerList{
    _banners = bannerList;
    [_spotlightView reloadImages:[bannerList map:^id(BannerModel* obj) {
        return obj.bannerUrl;
    }]];
}

- (void)MCScrollView:(MCScrollView *)MCScrollView touchImageAtIndex:(int)index{
    BannerModel* obj = _banners[index - 1];
    if (obj) {
        if(obj.type.integerValue == 1 && obj.itemId && obj.platformId){
            if (obj.platformId.integerValue == 1) {
                DetailScene2 *scene = [[DetailScene2 alloc]init];
                scene.itemId = obj.itemId;
                [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
            }else{
                DetailScene *scene = [[DetailScene alloc]init];
                scene.itemId = obj.itemId;
                scene.platformId = obj.platformId.integerValue;
                [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];

            }
        }else if(obj.type.integerValue == 2 && obj.refUrl){
            ZFSceneDetail *detilvc = [[ZFSceneDetail alloc]init];
            detilvc.detailStr = obj.refUrl;
            [[URLNavigation navigation].currentNavigationViewController pushViewController:detilvc animated:YES];
        }
    }
}

@end
