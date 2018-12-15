//
//  FavScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/19.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FavScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <Masonry/Masonry.h>
#import "FavCell.h"
#import "DetailScene.h"
#import <EasyIOS/EasyIOS.h>
#import "FavBottomView.h"
#import "ShareDataModel.h"
#import "ShareInfo.H"
#import "ActionSceneModel.h"
#import "ShareUrlRequest.h"
@interface FavScene ()<UITableViewDelegate,UITableViewDataSource,FavDelegate,FavSelectAllDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *list;
@property(nonatomic,retain)NSMutableArray *selectedList;
@property(nonatomic,retain)FavBottomView *bottomView;
@end

@implementation FavScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav-bg"]];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"收藏"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont fontWithName:MediumFont size:20.0f];
    [button setTitle:@"批量删除" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self nav_showBarButton:NAV_RIGHT button:button];
    
    TMDiskCache * cache = [[TMCache sharedCache] diskCache];
    NSArray *array = (NSArray *)[cache objectForKey:@"favList"];
    
    if (array) {
        _list = [NSMutableArray arrayWithArray:array];
    }else{
        _list = [NSMutableArray array];
    }
    _selectedList = [NSMutableArray array];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:[FavCell class] forCellReuseIdentifier:@"FavCell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 130.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49.0f+kBottomSafeHeight, 0);
    _bottomView = [[FavBottomView alloc]init];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(49.0f+kBottomSafeHeight));
    }];
}

-(void)rightButtonTouch{
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    @weakify(self);
    [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        NSArray * list = [self.selectedList map:^id(GoodsModel* obj) {
            return [NSIndexPath indexPathForRow:[self.list indexOfObject:obj] inSection:0];
        }];
        [self.list removeObjectsInArray:self.selectedList];
        [self.tableView deleteRowsAtIndexPaths:list withRowAnimation:UITableViewRowAnimationLeft];
        self.selectedList = [NSMutableArray array];
        [[[TMCache sharedCache] diskCache] setObject:self.list forKey:@"favList"];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)selectAll:(BOOL)selected{
    if (selected) {
        _selectedList = _list;
    }else{
        _selectedList = [NSMutableArray array];
    }
    [self.tableView reloadData];
}



-(void)share{
    if(_selectedList.count == 0){
        [DialogUtil showMessage:@"请选择分享商品"];
        return;
    }
    [self loadHudInKeyWindow];
    [self showHudIndeterminate:@"数据加载中..."];

    [ShareUrlRequest getShareInfo:self.selectedList callBack:^(NSArray *imageList) {
        [self hideHud];
        [self shareItems:imageList];
    }];
}


- (void)shareItems:(NSArray *)list
{
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:list applicationActivities:nil];
    activityController.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            [DialogUtil showMessage:@"分享成功"];
        }
    };
    [[URLNavigation navigation].currentNavigationViewController presentViewController:activityController animated:YES completion:nil];
}


-(void)selectItem:(GoodsModel *)model{
    id find = [_selectedList find:^BOOL(GoodsModel *obj) {
        return [obj isEqual:model];
    }];
    if (!find) {
        [_selectedList addObject:model];
    }
}

-(void)unselectItem:(GoodsModel *)model{
     [_selectedList removeObject:model];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FavCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavCell" forIndexPath:indexPath];
    GoodsModel *model = [self.list safeObjectAtIndex:indexPath.row];
    [cell setModel: model];
    cell.delegate = self;
    id find = [_selectedList find:^BOOL(GoodsModel *obj) {
        return [obj isEqual:model];
    }];
    [cell setItemSelected:!!find];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailScene *detail = [[DetailScene alloc]init];
    detail.model = [self.list safeObjectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
