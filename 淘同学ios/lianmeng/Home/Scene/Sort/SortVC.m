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
#import <MJExtension.h>
#import "Scene+NavBar.h"
static float kLeftTableViewWidth = 80.f;
static float kCollectionViewMargin = 3.f;
@interface SortVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, kLeftTableViewWidth,ScreenH-kStatusBarAndNavigationBarHeight-kCollectionViewMargin)];
        _tableView.backgroundColor = [UIColor redColor];
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kCollectionViewMargin + kLeftTableViewWidth, kStatusBarAndNavigationBarHeight, ScreenW - kLeftTableViewWidth - 2 * kCollectionViewMargin, ScreenH-kStatusBarAndNavigationBarHeight - kCollectionViewMargin) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor yellowColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"SortCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SortCollectionViewCell"];
        //注册分区头部
        [_collectionView registerNib:[UINib nibWithNibName:@"SortReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SortReusableView"];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self nav_setTitle:@"分类"];
    [self setupData];
}
-(void)setupData
{
    [[NetWorkTool shareInstacne]getWithURLString:@"http://47.110.40.176:8888/mobile/taobao/superclassifylist" parameters:nil success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            [self.dataSource removeAllObjects];
            self.dataSource = [SortTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            NSLog(@"self.dataSource.count:%lu",(unsigned long)self.dataSource.count);
            [self.view addSubview:self.tableView];
            [self.view addSubview:self.collectionView];
            [self.tableView reloadData];
            [self.collectionView reloadData];
        }else{
            [DialogUtil showMessage:@"请求失败"];
            return;
        }
    } failure:^(NSError *error) {
        [DialogUtil showMessage:@"请求失败"];
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
   // _selectIndex = indexPath.row;
    
    // http://stackoverflow.com/questions/22100227/scroll-uicollectionview-to-section-header-view
    // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
    //[self scrollToTopOfSection:_selectIndex animated:YES];
    //    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
   // [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
    // atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    SortTypeModel *typemodel = self.dataSource[0];
    NSLog(@"typemodel.data.count:%lu",(unsigned long)typemodel.data.count);
    return typemodel.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SortTypeModel *typemodel = self.dataSource[0];
    SortTypenextModel *nextmodel = typemodel.data[0];
    NSLog(@"nextmodel.info.count:%lu",(unsigned long)nextmodel.info.count);
    return nextmodel.info.count;
   // CollectionCategoryModel *model = self.dataSource[section];
   // return model.subcategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"" forIndexPath:indexPath];
//   // SubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row];
//    //cell.model = model;
//    return cell;
    return nil;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((SCREEN_WIDTH - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3,
//                      (SCREEN_WIDTH - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3 + 30);
//}


@end
