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
#import "BannerListModel.h"
#import "AdThirdCell.h"
#import "ZFProductDetail.h"
#import "DetailScene2.h"
@interface GoodsCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,retain)NSArray *itemArray;
@property(nonatomic,strong)NSArray *studentArray;
@property(nonatomic,strong)NSArray *nineArray;
@property(nonatomic,strong)NSArray *recommandArray;
@property(nonatomic,strong)NSArray *secondArray;
@property(nonatomic,strong)NSArray *thirdArray;
@property(nonatomic,retain)HeaderView *headerView;
@end
@implementation GoodsCollectionView

-(void)reloadBannerData:(NSArray *)bannerList{
    [_headerView reloadBannerData:bannerList];
}
-(void)reloadBannerWitthSecondArray:(NSArray *)secondArray withThirdArray:(NSArray *)thirdArray
{
    _secondArray = secondArray;
    _thirdArray  = thirdArray;
    [self reloadData];
}

-(void)reloadGoodsDataStudentArray:(NSArray *)studentarray withNineArray:(NSArray *)nineArray withRecommandArray:(NSArray *)recommandArray withItemList:(NSArray *)itmeArray
{
    _studentArray    = studentarray;
    _nineArray       = nineArray;
    _recommandArray  = recommandArray;
    _itemArray       = itmeArray;
    [self reloadData];
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        //self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithString:@"#ECECEC"];
        [self registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
        [self registerClass:[LikeCollectionViewCell class] forCellWithReuseIdentifier:@"LikeCollectionViewCell"];
        [self registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [self registerClass:[LikeView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LikeView"];
        //todo新加的
        [self registerClass:[AdCell class] forCellWithReuseIdentifier:@"AdCell"];
        [self registerNib:[UINib nibWithNibName:@"AdThirdCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AdThirdCell"];
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
        return (CGSize){[UIScreen mainScreen].bounds.size.width,50.0f};
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
        return CGSizeMake(ScreenW, 150);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return CGSizeMake(ScreenW, 50);
        }else{
            return CGSizeMake(ScreenW,240);
        }
    }if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return CGSizeMake(ScreenW, 50);
        }else{
            return CGSizeMake(ScreenW, 240);
        }
    }
    if (indexPath.section == 3) {
        return CGSizeMake(ScreenW, 150);
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            return CGSizeMake(ScreenW, 50);
        }else{
            return CGSizeMake(ScreenW, 240);
        }
    }else{
         return CGSizeMake((ScreenW - 15)/2, 287.0f);
    }
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section == 5){
        return UIEdgeInsetsMake(7, 3.5, 7, 3.5);//分别为上、左、下、右
    }else{
        return UIEdgeInsetsZero;

    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if(section == 5) {
        return 7.0f;
    }else{
        return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if(section == 5) {
        return 7.0f;
    }else{
        return 0;
    }
}
/*
 LikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LikeCollectionViewCell" forIndexPath:indexPath];
 [cell setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ad%ld",(long)indexPath.row+1]]];
 return cell;
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //AdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdCell" forIndexPath:indexPath];
        //[cell reloadBannerData:self.secondArray];
        //return cell;
        AdThirdCell *adCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdThirdCell" forIndexPath:indexPath];
        adCell.urlArray = (NSMutableArray *)self.secondArray;
        adCell.adCrollView.placeholderImage = [UIImage imageNamed:@"lunbo.png"];
        return adCell;
    }if(indexPath.section == 1){
        if (indexPath.row == 0) {
            HeaderTtileCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderTtileCell" forIndexPath:indexPath];
            titleCell.title_lab.text = @"同学优选";
            titleCell.english_lab.text = @"// PREFERABLY";
            [titleCell setMoreblock:^{
               //同学优选跳转
                NSLog(@"同学优选");
                CategoryListScene *scene = [[CategoryListScene alloc]init];
                scene.type = 1;
                [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
            }];
            return titleCell;
        }else{
            ConetentScrollCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConetentScrollCell" forIndexPath:indexPath];
            contentCell.productTypeArray = _studentArray;
            return contentCell;
        }
    }if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            HeaderTtileCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderTtileCell" forIndexPath:indexPath];
            titleCell.title_lab.text = @"9块9包邮";
            titleCell.english_lab.text = @"// ¥ 9.9 POSTING";
            [titleCell setMoreblock:^{
                NSLog(@"9块9包邮");
                CategoryListScene *scene = [[CategoryListScene alloc]init];
                scene.type = 2;
                [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
            }];
            return titleCell;
        }else{
            ConetentScrollCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConetentScrollCell" forIndexPath:indexPath];
            contentCell.productTypeArray = _nineArray;
            return contentCell;
        }
    }if (indexPath.section == 3) {
        AdThirdCell *adCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdThirdCell" forIndexPath:indexPath];
        adCell.urlArray = (NSMutableArray *)self.thirdArray;
        adCell.adCrollView.placeholderImage = [UIImage imageNamed:@"lunbo.png"];
        return adCell;
    }if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            HeaderTtileCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderTtileCell" forIndexPath:indexPath];
            titleCell.title_lab.text = @"超级划算";
            titleCell.english_lab.text = @"// TIME - LIMITED";
            [titleCell setMoreblock:^{
                NSLog(@"超级划算");
                CategoryListScene *scene = [[CategoryListScene alloc]init];
                scene.type = 4;
                [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
            }];
            return titleCell;
        }else{
            ConetentScrollCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConetentScrollCell" forIndexPath:indexPath];
            contentCell.productTypeArray = _recommandArray;
            return contentCell;
        }
    }
    else{
        GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
        [cell setModel:[self.itemArray safeObjectAtIndex:indexPath.row]];
        return cell;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   return 6;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }if (section ==  1 ) {
        return _studentArray?2:1;
    }
    if (section == 2) {
        return _nineArray?2:1;
    }
    if (section == 3) {
        return 1;
    }
    if (section == 4) {
        return _recommandArray?2:1;
    }
    else{
        return _itemArray?_itemArray.count:0;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 5){
         GoodsModel *model =  [_itemArray safeObjectAtIndex:indexPath.row];
        if (model.platformId == 1) {
            DetailScene2 *detail = [[DetailScene2 alloc]init];
            GoodsModel *model =  [_itemArray safeObjectAtIndex:indexPath.row];
            detail.model = model;
            [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
        }else{
            DetailScene *detail = [[DetailScene alloc]init];
            detail.model = model;
            [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
        }
    }
}
@end
