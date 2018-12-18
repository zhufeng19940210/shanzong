//
//  SearchListScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/13.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SearchListScene.h"
#import <Masonry/Masonry.h>
#import "SearchNavBar.h"
#import "SearchNavBar.h"
#import "SearchDropDownView.h"
#import "SortView.h"
#import "YouhuiQuanView.h"
#import "TabBaoItemCell.h"
#import "GoodsSearchSceneModel.h"
#import "DetailScene.h"
#import "SearchTopView.h"

@interface SearchListScene ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,SortViewDelegate,YouhuiQuanViewDelegate>
@property(nonatomic,retain)SearchNavBar *searchBar;
@property(nonatomic,retain)SearchDropDownView *dropDownView;
@property(nonatomic,retain)SortView *sortView;
@property(nonatomic,retain)YouhuiQuanView *yhqView;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)GoodsSearchSceneModel *sceneModel;
@property(nonatomic,retain)SearchTopView *topView;
@end

@implementation SearchListScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.isSort == YES) {
        _topView = [[SearchTopView alloc]init];
        [self.view addSubview:_topView];
        [_topView.titlelab setText:self.keyword];
        [_topView.leftButton addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
        }];
        _sortView = [[SortView alloc]init];
        _sortView.delegate = self;
        [self.view addSubview:_sortView];
        
        [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.topView.mas_bottom);
            make.height.equalTo(@34.5f);
        }];
        _yhqView = [[YouhuiQuanView alloc]init];
        _yhqView.delegate = self;
        [self.view addSubview:_yhqView];
        
        [_yhqView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.sortView.mas_bottom);
            make.height.equalTo(@40.0f);
        }];
    }else{
        _searchBar = [[SearchNavBar alloc]init];
        [self.view addSubview:_searchBar];
        [_searchBar.leftButton addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        [_searchBar.dropDownButton addTarget:self action:@selector(showDropDownBox) forControlEvents:UIControlEventTouchUpInside];
        _searchBar.textField.delegate = self;
        _searchBar.textField.text = self.keyword;
        _searchBar.textField.returnKeyType = UIReturnKeySearch;
        
        if (self.platformId == 1) {
            [_searchBar.dropDownButton setTitle:@"淘宝" forState:UIControlStateNormal];
        }else{
            [_searchBar.dropDownButton setTitle:@"京东" forState:UIControlStateNormal];
        }
        
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
        }];
        
        _sortView = [[SortView alloc]init];
        _sortView.delegate = self;
        [self.view addSubview:_sortView];
        
        [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.searchBar.mas_bottom);
            make.height.equalTo(@34.5f);
        }];
        
        _yhqView = [[YouhuiQuanView alloc]init];
        _yhqView.delegate = self;
        [self.view addSubview:_yhqView];
        
        [_yhqView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.sortView.mas_bottom);
            make.height.equalTo(@40.0f);
        }];
        _dropDownView = [[SearchDropDownView alloc]init];
        _dropDownView.hidden = YES;
        [self.view addSubview:_dropDownView];
        [_dropDownView.button1 addTarget:self action:@selector(touchTaobao) forControlEvents:UIControlEventTouchUpInside];
        [_dropDownView.button2 addTarget:self action:@selector(touchJd) forControlEvents:UIControlEventTouchUpInside];
        
        [_dropDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@65.0f);
            make.top.equalTo(self.searchBar.mas_bottom).offset(-8.0f);
            make.left.equalTo(self.searchBar.mas_left).offset(60.0f);
        }];
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:[TabBaoItemCell class] forCellReuseIdentifier:@"TabBaoItemCell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 130.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.yhqView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    _sceneModel = [GoodsSearchSceneModel SceneModel];
    _sceneModel.request.platformId = @(self.platformId);
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
          return self.sceneModel.request.failed;
      }]
     subscribeNext:^(id x) {
         @strongify(self);
         self.sceneModel.request.page = self.sceneModel.dataModel?@(self.sceneModel.dataModel.currentPage):@(1);
         [self.tableView endAllRefreshingWithIntEnd:self.sceneModel.dataModel.currentPage >= self.sceneModel.dataModel.totalPage];
     }];
        [self.tableView triggerPullToRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)switchYHQ:(NSUInteger)isCoupon{
    self.sceneModel.request.isCoupon = @(isCoupon);
    self.sceneModel.request.page = @1;
    self.sceneModel.request.requestNeedActive = YES;
}

-(void)changeSort:(NSUInteger)sort{
    self.sceneModel.request.sort = @(sort);
    self.sceneModel.request.page = @1;
    self.sceneModel.request.requestNeedActive = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *keyWord = [textField.text copy];
    if(keyWord.length >0){
        self.sceneModel.request.keyword = keyWord;
        [self.tableView triggerPullToRefresh];
    }
    return YES;
}

-(void)touchTaobao{
    self.platformId = 1;
    _dropDownView.hidden = YES;
    [_searchBar.dropDownButton setTitle:@"淘宝" forState:UIControlStateNormal];
    _searchBar.pinkArrow.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    
    self.sceneModel.request.platformId = @(1);
    [self.tableView triggerPullToRefresh];
}

-(void)touchJd{
    self.platformId = 2;
    _dropDownView.hidden = YES;
    [_searchBar.dropDownButton setTitle:@"京东" forState:UIControlStateNormal];
    _searchBar.pinkArrow.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    
    self.sceneModel.request.platformId = @(2);
    [self.tableView triggerPullToRefresh];
}

-(void)showDropDownBox{
    
    if(_dropDownView.hidden){
        _searchBar.pinkArrow.transform = CGAffineTransformMakeRotation(0);
    }else{
        _searchBar.pinkArrow.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    }
    _dropDownView.hidden = !_dropDownView.hidden;
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
    DetailScene *detail = [[DetailScene alloc]init];
    detail.model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
