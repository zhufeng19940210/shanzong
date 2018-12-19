//  AdCell.m
//  lianmeng
//  Created by zhufeng on 2018/12/14.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "AdCell.h"
#import "BannerListModel.h"
#import "DetailScene.h"
#import <EasyIOS/EasyIOS.h>
#import "ZFSceneDetail.h"
@interface AdCell()<MCScrollViewDelegate>
@property(nonatomic,retain)MCScrollView *spotlightView;
@property(nonatomic,retain)NSArray *banners;
@end
@implementation AdCell
-(NSArray *)banners
{
    if (!_banners) {
        _banners = [NSArray array];
    }
    return _banners;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupData];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupData];
    }
    return self;
}
-(void)setupData{
    self.spotlightView = [[MCScrollView alloc]initWIthFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
    self.spotlightView.delegate = self;
    [self.contentView addSubview:self.spotlightView];
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
            DetailScene *scene = [[DetailScene alloc]init];
            scene.itemId = obj.itemId;
            scene.platformId = obj.platformId.integerValue;
            [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
        }else if(obj.type.integerValue == 2 && obj.refUrl){
            ZFSceneDetail *detilvc = [[ZFSceneDetail alloc]init];
            detilvc.detailStr = obj.refUrl;
            [[URLNavigation navigation].currentNavigationViewController pushViewController:detilvc animated:YES];
        }
    }
}
@end
