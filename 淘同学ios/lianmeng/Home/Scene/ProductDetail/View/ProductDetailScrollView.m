//  ProductDetailScrollView.m
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
#import "ProductDetailScrollView.h"
#import "ProductHeaderReusableView.h"
#import "PrductFooterReusableView.h"
#import "ProductContentCell.h"
#import "ProductImgCell.h"
#import "ProductLikeCell.h"
#import "GoodsCollectionViewCell.h"
#import "LikeView.h"
#import "DetailScene.h"
#import <EasyIOS/EasyIOS.h>
@interface ProductDetailScrollView() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *adimageArray;
@property (nonatomic,strong)NSMutableArray *detailArray;
@property (nonatomic,strong)NSMutableArray *itemArray;
@end
@implementation ProductDetailScrollView
-(NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}
-(NSMutableArray *)adimageArray
{
    if (!_adimageArray) {
        _adimageArray = [NSMutableArray array];
    }
    return _adimageArray;
}
-(NSMutableArray *)detailArray
{
    if (!_detailArray) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerNib:[UINib nibWithNibName:@"ProductHeaderReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductHeaderReusableView"];
        [self registerNib:[UINib nibWithNibName:@"PrductFooterReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PrductFooterReusableView"];
        [self registerClass:[LikeView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LikeView"];
        [self registerNib:[UINib nibWithNibName:@"ProductContentCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductContentCell"];
        [self registerNib:[UINib nibWithNibName:@"ProductLikeCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductLikeCell"];
        [self registerNib:[UINib nibWithNibName:@"ProductImgCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProductImgCell"];
        //todo新加的
        [self registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    }
    return self;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            ProductHeaderReusableView *headerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProductHeaderReusableView" forIndexPath:indexPath];
            return headerview ;
        }
        else if(indexPath.section == 5){
            LikeView *view  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LikeView" forIndexPath:indexPath];
            return view;
        }
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            PrductFooterReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PrductFooterReusableView" forIndexPath:indexPath];
            return footerview;
        }else{
            return nil;
        }
    }
    return nil;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ProductContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductContentCell" forIndexPath:indexPath];
        return cell;
    }if (indexPath.section == 1) {
        ProductLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductLikeCell" forIndexPath:indexPath];
        return cell;
    }if (indexPath.section == 2) {
        ProductImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductImgCell" forIndexPath:indexPath];
        return cell;
    }if (indexPath.section == 3) {
        GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return (CGSize){[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width};
    }else if(section == 2){
        return (CGSize){[UIScreen mainScreen].bounds.size.width,50.0f};
    }else{
        return (CGSize){[UIScreen mainScreen].bounds.size.width,0.0};
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return (CGSize){[UIScreen mainScreen].bounds.size.width,100};
    }else{
        return (CGSize){[UIScreen mainScreen].bounds.size.width,0.0};
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenW, 100);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(ScreenW, 100);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(ScreenW, 240);
    }
    if (indexPath.section == 3) {
        return CGSizeMake((ScreenW - 15)/2, 287.0f);
    }else{
        return CGSizeZero;
    }
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section == 3){
        return UIEdgeInsetsMake(7, 3.5, 7, 3.5);//分别为上、左、下、右
    }else{
        return UIEdgeInsetsZero;
        
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if(section == 3) {
        return 7.0f;
    }else{
        return 0;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }if (section == 1) {
        return 1;
    }if (section == 2) {
        return self.detailArray.count;
    }if (section == 3) {
        return self.itemArray.count;
    }else{
        return 0;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3){
        DetailScene *detail = [[DetailScene alloc]init];
        detail.model = [_detailArray safeObjectAtIndex:indexPath.row];
        [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
    }
}
@end
