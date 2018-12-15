//  GoodsCollectionView.m
//  lianmeng
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "GoodsCollectionView.h"
#import "GoodsCollectionViewCell.h"
#import "LikeCollectionViewCell.h"
#import "HeaderView.h"
#import "LikeView.h"
#import <EasyIOS/EasyIOS.h>
#import "CategoryListScene.h"
#import "XianShiScene.h"
#import "DetailScene.h"
#import "HeaderTtileCell.h"
#import "ConetentScrollCell.h"
#import "AdCell.h"

@interface GoodsCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,retain)NSArray *list;
@property(nonatomic,strong)NSArray *firstArray;
@property(nonatomic,strong)NSArray *secondArray;
@property(nonatomic,strong)NSArray *thirdArray;
@property(nonatomic,retain)HeaderView *headerView;
@end
@implementation GoodsCollectionView
-(NSArray *)firstArray
{
    if (!_firstArray) {
        _firstArray = [NSArray array];
    }
    return _firstArray;
}
-(NSArray *)secondArray
{
    if (!_secondArray) {
        _secondArray = [NSArray array];
    }
    return _secondArray;
}
-(NSArray *)thirdArray
{
    if (!_thirdArray) {
        _thirdArray = [NSArray array];
    }
    return _thirdArray;
}
-(void)reloadBannerData:(NSArray *)bannerList{
    [_headerView reloadBannerData:bannerList];
}
-(void)reloadGoodsData:(NSArray *)array{
    _list = array;
//    [UIView performWithoutAnimation:^{
//        //[self reloadSections:5];
//        [self reloadSections:[NSIndexSet indexSetWithIndex:6]];
//    }];
    [self reloadData];
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor colorWithString:@"#ECECEC"];
        [self registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
        [self registerClass:[LikeCollectionViewCell class] forCellWithReuseIdentifier:@"LikeCollectionViewCell"];
        [self registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [self registerClass:[LikeView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LikeView"];
        //todo新加的
        [self registerNib:[UINib nibWithNibName:@"AdCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AdCell"];
        [self registerNib:[UINib nibWithNibName:@"HeaderTtileCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HeaderTtileCell"];
        [self registerClass:[ConetentScrollCell class] forCellWithReuseIdentifier:@"ConetentScrollCell"];
    }
    return self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return (CGSize){[UIScreen mainScreen].bounds.size.width,297.5f};
    }else if(section == 5){
        return (CGSize){[UIScreen mainScreen].bounds.size.width,35.0f};
    }else{
        return (CGSize){[UIScreen mainScreen].bounds.size.width,0.0};
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            _headerView  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            return _headerView;
        }else if(indexPath.section == 5){
            LikeView *view  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LikeView" forIndexPath:indexPath];
            return view;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenW, 100);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return CGSizeMake(ScreenW, 50);
        }else{
            return CGSizeMake(ScreenW, 150);
        }
    }if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return CGSizeMake(ScreenW, 50);
        }else{
            return CGSizeMake(ScreenW, 150);
        }
    }
    if (indexPath.section == 3) {
        return CGSizeMake(ScreenW, 100);
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            return CGSizeMake(ScreenW, 50);
        }else{
            return CGSizeMake(ScreenW, 150);
        }
    }else{
         return CGSizeMake((ScreenW - 15)/2, 287.0f);
    }
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else{
        return UIEdgeInsetsMake(7, 3.5, 7, 3.5);//分别为上、左、下、右
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 7.0f;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 7.0f;
    }
}
/*
 LikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LikeCollectionViewCell" forIndexPath:indexPath];
 [cell setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ad%ld",(long)indexPath.row+1]]];
 return cell;
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdCell" forIndexPath:indexPath];
        return cell;
    }if(indexPath.section == 1){
        if (indexPath.row == 0) {
            HeaderTtileCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderTtileCell" forIndexPath:indexPath];
            return titleCell;
        }else{
            ConetentScrollCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConetentScrollCell" forIndexPath:indexPath];
            return contentCell;
        }
    }if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            HeaderTtileCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderTtileCell" forIndexPath:indexPath];
            return titleCell;
        }else{
            ConetentScrollCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConetentScrollCell" forIndexPath:indexPath];
            return contentCell;
        }
    }if (indexPath.section == 3) {
        AdCell *adCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdCell" forIndexPath:indexPath];
        return adCell;
    }if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            HeaderTtileCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderTtileCell" forIndexPath:indexPath];
            return titleCell;
        }else{
            ConetentScrollCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConetentScrollCell" forIndexPath:indexPath];
            return contentCell;
        }
    }
    else{
        GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
        [cell setModel:[_list safeObjectAtIndex:indexPath.row]];
        return cell;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   return 7;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }if (section ==  1 ) {
        return _firstArray?_firstArray.count+1:1;
    }
    if (section == 2) {
        return _secondArray?_secondArray.count+1:1;
    }
    if (section == 3) {
        return 1;
    }
    if (section == 4) {
        return _thirdArray?_thirdArray.count+1:1;
    }
    else{
        return _list?_list.count:0;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if(indexPath.row == 1){
            XianShiScene *scene = [[XianShiScene alloc]init];
            [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
        }else{
            CategoryListScene *scene = [[CategoryListScene alloc]init];
            if (indexPath.row == 0) {
                scene.type = 1;
            }else if (indexPath.row == 2) {
                scene.type = 10;
            }else if (indexPath.row == 3) {
                scene.type = 4;
            }else if (indexPath.row == 4) {
                scene.type = 2;
            }
            [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
        }
    }else if (indexPath.section == 1){
        DetailScene *detail = [[DetailScene alloc]init];
        detail.model = [_list safeObjectAtIndex:indexPath.row];
        [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
    }
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat y = scrollView.contentOffset.y;
//    if(self.animationDelegate){
//        if (y<=150.0f) {
//            if(y>0){
//                [self.animationDelegate animationWithPercent:y/150.0f];
//            }else{
//                [self.animationDelegate animationWithPercent:0.0f];
//            }
//        }else if(y<=300.0f){
//             [self.animationDelegate animationWithPercent:1.0f];
//        }
//    }
//}

@end
