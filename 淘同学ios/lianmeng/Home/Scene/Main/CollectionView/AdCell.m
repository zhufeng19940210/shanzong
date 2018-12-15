//  AdCell.m
//  lianmeng
//  Created by zhufeng on 2018/12/14.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "AdCell.h"
#import "BannerListModel.h"
#import "DetailScene.h"
#import <EasyIOS/EasyIOS.h>
@interface AdCell()<MCScrollViewDelegate>
@property(nonatomic,retain)MCScrollView *spotlightView;
@property(nonatomic,strong)NSMutableArray *mybannerlist;
@end
@implementation AdCell
-(NSMutableArray *)mybannerlist
{
    if (!_mybannerlist) {
        _mybannerlist = [NSMutableArray array];
    }
    return _mybannerlist;
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
-(void)setBaanerList:(NSMutableArray *)baanerList
{    _baanerList = baanerList;
    [self.mybannerlist removeAllObjects];
    [self.mybannerlist addObjectsFromArray:baanerList];
    NSMutableArray *adArray = [NSMutableArray array];
    for (BannerModel *model in _baanerList) {
        [adArray addObject:model.bannerUrl];
    }
    [self.spotlightView reloadImages:adArray];
}
- (void)MCScrollView:(MCScrollView *)MCScrollView touchImageAtIndex:(int)index{
    BannerModel* obj = self.mybannerlist[index-1];
    if (obj) {
        if(obj.type.integerValue == 1 && obj.itemId && obj.platformId){
            DetailScene *scene = [[DetailScene alloc]init];
            scene.itemId = obj.itemId;
            scene.platformId = obj.platformId.integerValue;
            [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
        }else if(obj.type.integerValue == 2 && obj.refUrl){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:obj.refUrl]];
        }
    }
}



@end
