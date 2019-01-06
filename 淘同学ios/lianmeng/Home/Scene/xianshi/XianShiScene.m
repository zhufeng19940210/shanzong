//  XianShiScene.m
//  lianmeng
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "XianShiScene.h"
#import "TimeSelectView.h"
#import "DetailScene.h"
#import <EasyIOS/EasyIOS.h>
#import "Scene+NavBar.h"
#import "NavLeftView.h"
#import <Masonry/Masonry.h>
#import "TimeSegsListSceneModel.h"
#import "XianShiCell.h"
#import "DetailScene2.h"
@interface XianShiScene ()<TimeSelectDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)TimeSegsListSceneModel *sceneModel;
@property(nonatomic,retain)TimeSelectView *timeSelectView;
@property(nonatomic,retain)UITableView *tableView;
@end

@implementation XianShiScene

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"biaotilanbeijing"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"限时抢购"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    _timeSelectView = [[TimeSelectView alloc]init];
    _timeSelectView.delegate = self;
    [self.view addSubview:_timeSelectView];
    [_timeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
        make.height.equalTo(@(55.0f));
    }];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 125.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[XianShiCell class] forCellReuseIdentifier:@"XianShiCell"];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.timeSelectView.mas_bottom);
    }];
    
    @weakify(self);
    [_tableView addPullToRefreshWithActionHandler:^{
        @strongify(self);
        self.sceneModel.request.page = @1;
        self.sceneModel.request.requestNeedActive = YES;
    }];
    [_tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self);
        self.sceneModel.request.page = [self.sceneModel.request.page increase:@1];
        self.sceneModel.request.requestNeedActive = YES;
    }];
    
    
    _sceneModel = [TimeSegsListSceneModel SceneModel];
    _sceneModel.timeSegsRequest.requestNeedActive = YES;
    
    [[RACObserve(self.sceneModel, timeSegList)
      filter:^BOOL(TimeSegListModel *list) {
          return list !=nil;
      }]
     subscribeNext:^(TimeSegListModel *list) {
         @strongify(self);
         [self.timeSelectView loadData:list.list];
     }];
    
    
    [[RACObserve(self.sceneModel, dataModel)
      filter:^BOOL(GoodsListModel* value) {
          return value !=nil;
      }]
     subscribeNext:^(GoodsListModel* value) {
         @strongify(self);
         if (value.currentPage == 1) {
             [self.sceneModel.dataArray removeAllObjects];
             self.sceneModel.dataArray = [NSMutableArray array];
         }
         if([value.list count]>0){
             [self.sceneModel.dataArray addObjectsFromArray:value.list];
         }
         self.sceneModel.request.page = @(value.currentPage);
         [self.tableView reloadData];
         [self.tableView endAllRefreshingWithIntEnd:value.totalPage <= value.currentPage];
     }];
    
    // Do any additional setup after loading the view.
}

-(void)didSelectItemAtIndex:(NSUInteger)idx{
    [self.sceneModel.dataArray removeAllObjects];
    self.sceneModel.dataArray = [NSMutableArray array];
    [self.tableView reloadData];
    TimeSegModel *model = _sceneModel.timeSegList.list[idx];
    _sceneModel.request.buyDate = model.buyDate;
    _sceneModel.request.requestNeedActive = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XianShiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XianShiCell" forIndexPath:indexPath];
    [cell setModel: [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sceneModel.dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsModel *model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
    if (model.platformId == 1) {
        DetailScene2 *detail = [[DetailScene2 alloc]init];
        detail.model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
        [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
    }else{
        DetailScene *detail = [[DetailScene alloc]init];
        detail.model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
        [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
    }
}

@end
