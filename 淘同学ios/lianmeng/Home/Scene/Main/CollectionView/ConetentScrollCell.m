//  ConetentScrollCell.m
//  lianmeng
//  Created by zhufeng on 2018/12/14.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "ConetentScrollCell.h"
#import "GoodsCollectionViewCell.h"
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
-(void)setProductTypeArray:(NSMutableArray *)productTypeArray
{
    _productTypeArray = productTypeArray;
    [self.myCollectionView reloadData];
}
-(void)setupCollectView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout  alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    //上下的间距，可以设置0的
    flowLayout.minimumLineSpacing = 0;
    //设置间隔
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //滚动的方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *mycollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150) collectionViewLayout:flowLayout];
    mycollectionView.delegate = self;
    mycollectionView.dataSource = self;
    mycollectionView.clipsToBounds = NO;
    mycollectionView.backgroundColor = [UIColor yellowColor];
    mycollectionView.showsVerticalScrollIndicator = NO;
    mycollectionView.showsHorizontalScrollIndicator = NO;
    [mycollectionView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    [self addSubview:mycollectionView];
    _myCollectionView = mycollectionView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = 120;
    CGFloat height = 140;
    return CGSizeMake (width,height);
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
    
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
    [cell setModel:self.productTypeArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsModel *model = self.productTypeArray[indexPath.row];
    if (self.producttypeblock) {
        self.producttypeblock(model);
    }
}
@end
