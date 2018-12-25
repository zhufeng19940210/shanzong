//  ConetentScrollCell.m
//  lianmeng
//  Created by zhufeng on 2018/12/14.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "ConetentScrollCell.h"
#import "GoodsCollectionViewCell.h"
#import "DetailScene.h"
#import <EasyIOS/EasyIOS.h>
#import "GoodTypeCollectionViewCell.h"
@interface ConetentScrollCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak) UICollectionView * myCollectionView;
@end
@implementation ConetentScrollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        [self setupCollectView];
    }
    return self;
}
-(void)setProductTypeArray:(NSArray *)productTypeArray
{
    _productTypeArray = productTypeArray;
    [self.myCollectionView reloadData];
}
-(void)setupCollectView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout  alloc]init];
    flowLayout.minimumInteritemSpacing = 5;
    //上下的间距，可以设置0的
    flowLayout.minimumLineSpacing = 5;
    //设置间隔
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //滚动的方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *mycollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 240) collectionViewLayout:flowLayout];
    mycollectionView.delegate = self;
    mycollectionView.dataSource = self;
    mycollectionView.clipsToBounds = NO;
    mycollectionView.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1.0];
    mycollectionView.showsVerticalScrollIndicator = NO;
    mycollectionView.showsHorizontalScrollIndicator = NO;
    //[mycollectionView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    [mycollectionView registerClass:[GoodTypeCollectionViewCell class] forCellWithReuseIdentifier:@"GoodTypeCollectionViewCell"];
    [self addSubview:mycollectionView];
    _myCollectionView = mycollectionView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake ((ScreenW - 60)/2,220);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productTypeArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
    GoodTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodTypeCollectionViewCell" forIndexPath:indexPath];
    [cell setModel:self.productTypeArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsModel *model = self.productTypeArray[indexPath.row];
    DetailScene *detail = [[DetailScene alloc]init];
    detail.model = model;
    [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
}
@end
