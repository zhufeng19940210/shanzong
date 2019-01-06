//
//  CategoryListScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/18.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "CategoryListScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <Masonry/Masonry.h>
#import "SortView.h"
#import "YouhuiQuanView.h"
#import "CategoryListSceneModel.h"
#import <EasyIOS/EasyIOS.h>
#import "TabBaoItemCell.h"
#import "DetailScene.h"
#import "DetailScene2.h"
@interface CategoryListScene ()<UITableViewDelegate,UITableViewDataSource,SortViewDelegate,YouhuiQuanViewDelegate>
@property(nonatomic,retain)SortView *sortView;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)CategoryListSceneModel *sceneModel;
@end

@implementation CategoryListScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav-bg"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    NSString *title = @"";
    if (self.type == 1) {
        title = @"今日推荐";
    }else if (self.type == 2) {
        title = @"9.9包邮";
    }else if (self.type == 4) {
        title = @"聚划算";
    }else if (self.type == 5) {
        title = @"超级券";
    }else if (self.type == 6) {
        title = @"超级赚";
    }else if (self.type == 10) {
        title = @"视频购";
    }
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:title]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    _sortView = [[SortView alloc]init];
    _sortView.delegate = self;
    [self.view addSubview:_sortView];
    
    [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
        make.height.equalTo(@34.5f);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:[TabBaoItemCell class] forCellReuseIdentifier:@"TabBaoItemCell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 130.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    _sceneModel = [CategoryListSceneModel SceneModel];
    _sceneModel.request.type = @(self.type);
    
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
          return self.sceneModel.request.failed;
      }]
     subscribeNext:^(id x) {
         @strongify(self);
         self.sceneModel.request.page = self.sceneModel.dataModel?@(self.sceneModel.dataModel.currentPage):@(1);
         [self.tableView endAllRefreshingWithIntEnd:self.sceneModel.dataModel.currentPage >= self.sceneModel.dataModel.totalPage];
     }];
    [self.tableView triggerPullToRefresh];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeSort:(NSUInteger)sort{
    self.sceneModel.request.sort = @(sort);
    self.sceneModel.request.page = @1;
    self.sceneModel.request.requestNeedActive = YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TabBaoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TabBaoItemCell" forIndexPath:indexPath];
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
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        DetailScene *detail = [[DetailScene alloc]init];
        detail.model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
