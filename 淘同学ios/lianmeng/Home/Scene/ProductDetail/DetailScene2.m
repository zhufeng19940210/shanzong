//
//  DetailScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "DetailScene2.h"
#import "Scene+NavBar.h"
#import <Masonry/Masonry.h>
#import "DetailHeaderView.h"
#import "DetailBottomView.h"
#import "FavScene.h"
#import "ShareInfo.h"
#import "ActionSceneModel.h"
#import "ShareItemInfoRequest.h"

#import "ShareScene.h"
#import <JDSDK/JDKeplerSDK.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "UserCenter.h"
#import "LMNavigationController.h"
#import "WechatLoginScene.h"
#import "ProdcutRequest.h"
#import "ActionSceneModel.h"
#import "ProductDetailScrollView.h"
#import "Scene+NavBar.h"
#import <Masonry.h>
@interface DetailScene2 ()<DetailDelegate>
@property (nonatomic,strong)ProductDetailScrollView *collectionview;
@property(nonatomic,retain)DetailBottomView *bottomView;
@end
@implementation DetailScene2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_LEFT button:leftButton];
    
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setImage:[UIImage imageNamed:@"xihuan"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_RIGHT button:rightButton];
    //创建collectionview的视图
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = 1;//行间距
    flow.minimumInteritemSpacing = 1;//列间距
    _collectionview = [[ProductDetailScrollView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionview.frame = CGRectMake(0, 0, ScreenW, ScreenH-50);
    [self.view addSubview:_collectionview];
    if (@available(iOS 11.0, *)) {
        _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _bottomView = [[DetailBottomView alloc]init];
    _bottomView.frame = CGRectMake(0, ScreenH-50, ScreenW, 50);
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    
    ProdcutRequest *request = [ProdcutRequest Request];
    request.itemId = _itemId;
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSDictionary *responsedic = request.output;
        if ([[responsedic valueForKey:@"status"] intValue] == 200) {
            [self.collectionview reloadDetailWithDic:responsedic];
        }
    } error:^{
        NSLog(@"暂无数据");
    }];
}
@end
