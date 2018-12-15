//  MainScene.m
//  lianmeng
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved
#import "MainScene.h"
#import "GoodsCollectionView.h"
#import <Masonry/Masonry.h>
#import "MainSceneModel.h"
#import <EasyIOS/EasyIOS.h>
#import "SearchView.h"
@interface MainScene ()
@property(nonatomic,retain)GoodsCollectionView *collectionView;
@property(nonatomic,retain)MainSceneModel *sceneModel;
@property(nonatomic,retain)SearchView *searchView;
@end
@implementation MainScene

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.navigationController.navigationBar.hidden =YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;

    flow.minimumLineSpacing = 1;//行间距
    flow.minimumInteritemSpacing = 1;//列间距
    _collectionView = [[GoodsCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self.view);
    }];
    _collectionView.contentInset = UIEdgeInsetsMake(kStatusBarAndNavigationBarHeight, 0, kBottomSafeHeight+49.0f, 0);
    
    _searchView = [[SearchView alloc]init];
    [self.view addSubview:_searchView];
    
    _collectionView.animationDelegate = _searchView;
    
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];

    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
    
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
    _sceneModel = [MainSceneModel SceneModel];
    _sceneModel.likeRequest.page = @1;
    
    @weakify(self);
    [_collectionView addPullToRefreshWithActionHandler:^{
        @strongify(self);
        self.sceneModel.likeRequest.page = @1;
        self.sceneModel.likeRequest.requestNeedActive = YES;
        self.sceneModel.bannerRequest.requestNeedActive = YES;
    }];
    [_collectionView addInfiniteScrollingWithActionHandler:^{
        @strongify(self);
        self.sceneModel.likeRequest.page = [self.sceneModel.likeRequest.page increase:@1];
        self.sceneModel.likeRequest.requestNeedActive = YES;
    }];
    
    
    [[RACObserve(self.sceneModel, dataModel)
      filter:^BOOL(GoodsListModel* value) {
          return value !=nil;
      }]
     subscribeNext:^(GoodsListModel* value) {
         @strongify(self);
         if (value.currentPage == 1) {
             [self.sceneModel.likeArray removeAllObjects];
             self.sceneModel.likeArray = [NSMutableArray array];
         }
         if([value.list count]>0){
             [self.sceneModel.likeArray addObjectsFromArray:value.list];
         }
         self.sceneModel.likeRequest.page = @(value.currentPage);
         [self.collectionView reloadGoodsData:self.sceneModel.likeArray];
         [self.collectionView endAllRefreshingWithIntEnd:value.totalPage <= value.currentPage];
     }];
    
    [[RACObserve(self.sceneModel, bannerModel)
      filter:^BOOL(BannerListModel* value) {
          return value !=nil;
      }]
     subscribeNext:^(BannerListModel* value) {
         @strongify(self);
         [self.collectionView reloadBannerData:value.list];
     }];
    
    [[RACObserve(self.sceneModel.likeRequest, state)
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          return self.sceneModel.likeRequest.failed;
      }]
     subscribeNext:^(id x) {
         @strongify(self);
         self.sceneModel.likeRequest.page = self.sceneModel.dataModel?@(self.sceneModel.dataModel.currentPage):@(1);
         [self.collectionView endAllRefreshingWithIntEnd:self.sceneModel.dataModel.currentPage >= self.sceneModel.dataModel.totalPage];
     }];
    [self.collectionView triggerPullToRefresh];

}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    if(_collectionView && _collectionView.contentOffset.y >= 150.0f){
//        return UIStatusBarStyleDefault;
//    }else{
//        return UIStatusBarStyleLightContent;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
