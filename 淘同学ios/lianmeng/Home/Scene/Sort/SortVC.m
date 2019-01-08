//  SortVC.m
//  lianmeng
//  Created by zhufeng on 2018/12/17.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "SortVC.h"
#import "NetWorkTool.h"
#import <DialogUtil.h>
#import "LeftTableViewCell.h"
#import "SortReusableView.h"
#import "SortCollectionViewCell.h"
#import "SortTypeModel.h"
#import "SortTypenextModel.h"
#import "SortInfoModel.h"
#import "CollectionViewHeaderView.h"
#import "CollectionViewCell.h"
#import <MJExtension.h>
#import "Scene+NavBar.h"
#import "SearchListScene.h"
#import "SortSearchScene.h"
static float kLeftTableViewWidth = 80.f;
static float kCollectionViewMargin = 3.f;
@interface SortVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;
@property (nonatomic,assign)int MidddleNumber;
@end
@implementation SortVC
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray *)collectionDatas
{
    if (!_collectionDatas) {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, kLeftTableViewWidth,ScreenH-kStatusBarAndNavigationBarHeight-kCollectionViewMargin-65)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout =  [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kCollectionViewMargin + kLeftTableViewWidth, kStatusBarAndNavigationBarHeight, ScreenW - kLeftTableViewWidth - 2 * kCollectionViewMargin, ScreenH-kStatusBarAndNavigationBarHeight - kCollectionViewMargin-65) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
         _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //注册cell
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
        //注册分区头标题
        [_collectionView registerClass:[CollectionViewHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"CollectionViewHeaderView"];
    }
    return _collectionView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.dataSource.count == 0) {
        [self setupData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self nav_setTitle:@"分类"];
    _selectIndex = 0;
}
-(void)setupData
{
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [[NetWorkTool shareInstacne]getWithURLString:@"https://ttx.yuncai58.top/mobile/taobao/superclassifylist" parameters:nil success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        if ([responseObject[@"status"] integerValue] == 200) {
            [weakSelf.dataSource removeAllObjects];
            weakSelf.dataSource = [SortTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            weakSelf.MidddleNumber = (int)weakSelf.dataSource.count / 2;
            [weakSelf.view addSubview:weakSelf.tableView];
            [weakSelf.view addSubview:weakSelf.collectionView];
            [weakSelf.tableView reloadData];
            [weakSelf.collectionView reloadData];
            [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionNone];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            return;
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        return;
    }];
}

#pragma mark -- uitableviewdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
    SortTypeModel *typemodel = self.dataSource[indexPath.row];
    cell.name.text = typemodel.main_name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    //todo 这里要修改下
    if (_selectIndex >= self.MidddleNumber) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];
    }
    [self.collectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    SortTypeModel *typemodel = self.dataSource[_selectIndex];
    return typemodel.data.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SortTypeModel *typemodel = self.dataSource[_selectIndex];
    SortTypenextModel *nextmodel = typemodel.data[section];
    return nextmodel.info.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SortTypeModel *typemodel = self.dataSource[_selectIndex];
    SortTypenextModel *nextmodel = typemodel.data[indexPath.section];
    SortInfoModel *info = nextmodel.info[indexPath.row];
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:info.imgurl] placeholderImage:[UIImage imageNamed:@""]];
    cell.name.text = [NSString stringWithFormat:@"%@",info.son_name];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{    SortTypeModel *typemodel = self.dataSource[_selectIndex];
     SortTypenextModel *nextmodel = typemodel.data[indexPath.section];
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionViewHeaderView  *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionViewHeaderView" forIndexPath:indexPath];
        headerView.title.text = nextmodel.next_name;
        return headerView;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenW - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3,
                      (ScreenW - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3 + 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenW, 40);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SortTypeModel *typemodel = self.dataSource[_selectIndex];
    SortTypenextModel *nextmodel = typemodel.data[indexPath.section];
    SortInfoModel *info = nextmodel.info[indexPath.row];
    SortSearchScene *sortsearchsence = [[SortSearchScene alloc]init];
    sortsearchsence.myword = info.son_name;
    sortsearchsence.keyword = [NSString stringWithFormat:@"%@%@",info.son_name,typemodel.main_name];
    sortsearchsence.cid  = [typemodel.cid integerValue];
    [self.navigationController pushViewController:sortsearchsence animated:YES];
}
@end
