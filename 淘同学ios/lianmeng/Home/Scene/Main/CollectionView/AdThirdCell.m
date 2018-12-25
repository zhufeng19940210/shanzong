//  AdThirdCell.m
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "AdThirdCell.h"
#import "BannerListModel.h"
#import "DetailScene.h"
#import <EasyIOS/EasyIOS.h>
#import "ZFSceneDetail.h"
@interface AdThirdCell()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *imageArray;
@end
@implementation AdThirdCell
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.adCrollView.delegate = self;
}

-(void)setUrlArray:(NSMutableArray *)urlArray
{
    self.imageArray = urlArray;
    NSMutableArray *url = [NSMutableArray array];
    for (BannerModel *model  in self.imageArray) {
        [url addObject:model.bannerUrl];
    }
    self.adCrollView.imageURLStringsGroup = url;
    //默认是2s,给4s
    self.adCrollView.autoScrollTimeInterval = 4;
}
#pragma mark -- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    BannerModel* obj = self.imageArray[index];
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
