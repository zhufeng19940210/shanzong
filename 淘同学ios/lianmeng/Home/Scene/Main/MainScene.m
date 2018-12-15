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
#import "GoodsListModel.h"
#import <MJExtension.h>
#import "BannerListModel.h"
@interface MainScene ()
@property(nonatomic,retain)GoodsCollectionView *collectionView;
@property(nonatomic,retain)MainSceneModel *sceneModel;
@property(nonatomic,retain)SearchView *searchView;
@property(nonatomic,strong)GoodsListModel *model;
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
      filter:^BOOL(NSDictionary* value) {
          return value !=nil;
      }]
     subscribeNext:^(NSDictionary* value) {
         @strongify(self);
         NSDictionary *categoryItemList1  =  value[@"categoryItemList1"];
         NSDictionary *categoryItemList2  =  value[@"categoryItemList2"];
         NSDictionary *categoryItemList3   =  value[@"categoryItemList3"];
         NSDictionary *itemlistDic=value[@"itemlist"];
         if (categoryItemList1) {
             if ([categoryItemList1[@"currentPage"] intValue] == 1) {
                 [self.sceneModel.studentArray removeAllObjects];
                 self.sceneModel.studentArray = [NSMutableArray array];
             }
             if ([categoryItemList1[@"list"] count] >0) {
                   [self.sceneModel.studentArray addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:categoryItemList1[@"list"]]];
             }
         }
         if (categoryItemList2) {
             if ([categoryItemList2[@"currentPage"] intValue] ==1) {
                 [self.sceneModel.ninetonineArray removeAllObjects];
                 self.sceneModel.ninetonineArray = [NSMutableArray array];
             }
             if ([categoryItemList2[@"list"] count] >0) {
                  [self.sceneModel.ninetonineArray addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:categoryItemList2[@"list"]]];
             }
         }
         if ([categoryItemList3[@"currentPage"] intValue] == 1) {
             [self.sceneModel.recommandArray removeAllObjects];
             self.sceneModel.recommandArray = [NSMutableArray array];
             if ([categoryItemList3[@"list"] count] >0) {
                  [self.sceneModel.recommandArray addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:categoryItemList3[@"list"]]];
             }
         }
         if (itemlistDic) {
             if ([itemlistDic[@"currentPage"] intValue] == 1) {
                 [self.sceneModel.likeArray removeAllObjects];
                  self.sceneModel.likeArray = [NSMutableArray array];
             }
             if ([itemlistDic[@"list"] count] >0) {
                [self.sceneModel.likeArray addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:itemlistDic[@"list"]]];
             }
             self.sceneModel.likeRequest.page = itemlistDic[@"currentPage"];
             NSLog(@"self.sceneModel.likeRequest.page:%@",self.sceneModel.likeRequest.page);
         }
         [self.collectionView reloadGoodsDataStudentArray:self.sceneModel.studentArray withNineArray:self.sceneModel.ninetonineArray withRecommandArray:self.sceneModel.recommandArray withItemList:self.sceneModel.likeArray];
         [self.collectionView endAllRefreshingWithIntEnd:itemlistDic[@"totalPage"] <= itemlistDic[@"currentPage"]];
     }];
    [[RACObserve(self.sceneModel, banaerModel)
      filter:^BOOL(NSMutableArray* value) {
          return value !=nil;
      }]
     subscribeNext:^(NSMutableArray* value) {
         @strongify(self);
         [self.sceneModel.firstArray removeAllObjects];
         [self.sceneModel.secdonArray removeAllObjects];
         [self.sceneModel.thirdArray removeAllObjects];
         self.sceneModel.firstArray = [NSMutableArray array];
         self.sceneModel.secdonArray = [NSMutableArray array];
         self.sceneModel.thirdArray  = [NSMutableArray array];
         self.sceneModel.firstArray = [BannerModel mj_objectArrayWithKeyValuesArray:value[0]];
         self.sceneModel.secdonArray = [BannerModel mj_objectArrayWithKeyValuesArray:value[1]];
         self.sceneModel.thirdArray  = [BannerModel mj_objectArrayWithKeyValuesArray:value[2]];
         [self.collectionView reloadBannerData:self.sceneModel.firstArray];
         [self.collectionView reloadBannerWitthSecondArray:self.sceneModel.secdonArray withThirdArray:self.sceneModel.thirdArray];
     }];
    [[RACObserve(self.sceneModel.likeRequest, state)
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          return self.sceneModel.likeRequest.failed;
      }]
     subscribeNext:^(id x) {
         @strongify(self);
         self.sceneModel.likeRequest.page = self.sceneModel.dataModel?@([self.sceneModel.dataModel[@"currentPage"] integerValue]):@(1);
         [self.collectionView endAllRefreshingWithIntEnd:self.sceneModel.dataModel[@"currentPage"] >= self.sceneModel.dataModel[@"totalPage"]];
     }];
    [self.collectionView triggerPullToRefresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
