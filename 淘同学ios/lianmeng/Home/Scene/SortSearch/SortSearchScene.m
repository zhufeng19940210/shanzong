//  SortSearchScene.m
//  lianmeng
//  Created by zhufeng on 2018/12/27.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "SortSearchScene.h"
#import <Masonry/Masonry.h>
#import "SortGoodSearchSceneModel.h"
#import "SortSearchView.h"
#import "TabBaoItemCell.h"
#import "DetailScene.h"
#import <DialogUtil.h>
#import <EasyIOS/EasyIOS.h>
#import "Scene+NavBar.h"
#import "SearchTopView.h"
#import "DetailScene2.h"
@interface SortSearchScene ()<SortSearchViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)SortSearchView *sortView;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)SortGoodSearchSceneModel *sceneModel;
@property(nonatomic,strong)SearchTopView *topView;
@end

@implementation SortSearchScene

- (void)viewDidLoad {
    [super viewDidLoad];
    _topView = [[SearchTopView alloc]init];
    _topView.backgroundColor = [UIColor redColor];
    _topView.titlelab.textColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    [_topView.titlelab setText:self.keyword];
    [_topView.leftButton addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    ///分类的视图
    _sortView = [[SortSearchView alloc]init];
    _sortView.delegate = self;
    [self.view addSubview:_sortView];
    
    [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.equalTo(@34.5f);
    }];
    ///tableview展示的视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:[TabBaoItemCell class] forCellReuseIdentifier:@"TabBaoItemCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 130.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    _sceneModel = [SortGoodSearchSceneModel SceneModel];
    _sceneModel.request.cid = @(self.cid);
    _sceneModel.request.keyword = [self.keyword copy];
    
    @weakify(self);
    [self.tableView addPullToRefreshWithActionHandler:^{
        @strongify(self);
        self.sceneModel.request.page = @1;
        self.sceneModel.request.requestNeedActive = YES;
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self);
        self.sceneModel.request.page = [self.sceneModel.request.page increase:@1];
        self.sceneModel.request.requestNeedActive = YES;
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
    [[RACObserve(self.sceneModel.request, state)
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          if (self.sceneModel.request.failed) {
              [DialogUtil showMessage:@"抱歉暂时没有找到这个产品,去看看其他的"];
          }
          return self.sceneModel.request.failed;
      }]
     subscribeNext:^(id x) {
         @strongify(self);
         self.sceneModel.request.page = self.sceneModel.dataModel?@(self.sceneModel.dataModel.currentPage):@(1);
         [self.tableView endAllRefreshingWithIntEnd:self.sceneModel.dataModel.currentPage >= self.sceneModel.dataModel.totalPage];
     }];
    [self.tableView triggerPullToRefresh];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabBaoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TabBaoItemCell" forIndexPath:indexPath];
    [cell setModel: [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sceneModel.dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsModel *model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
    if (model.platformId == 1) {
        DetailScene2 *detail = [[DetailScene2 alloc]init];
        detail.model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        DetailScene *detail = [[DetailScene alloc]init];
        detail.model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}
#pragma mark -- SortSearchViewDelegate
-(void)changeSortType:(NSUInteger)sort
{   NSLog(@"sort:%lu",(unsigned long)sort);
    self.sceneModel.request.sort = @(sort);
    self.sceneModel.request.page = @1;
    self.sceneModel.request.cid = @(self.cid);
    self.sceneModel.request.keyword = [self.keyword copy];
    self.sceneModel.request.requestNeedActive = YES;
}
@end
