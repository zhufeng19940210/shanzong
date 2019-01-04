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
#import "GoodsListModel.h"
#import <MJExtension.h>
#import "EvlationModel.h"
@interface ProductDetailScrollView() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *adimageArray;
@property (nonatomic,strong)NSMutableArray *detailArray;
@property (nonatomic,strong)NSMutableArray *itemArray;
@property (nonatomic,strong)NSDictionary *itemDic; ///详情的功能
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

-(void)reloadDetailWithDic:(NSDictionary *)dict
{
    NSLog(@"dict:%@",dict);
    self.itemDic = dict;
    self.adimageArray = dict[@"data"][@"iteminfo"][@"taobao_image"];
    self.itemArray = [GoodsModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"SimilarGoods"]];
    [self reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor colorWithRed:(240/255.0f) green:(240/255.0f) blue:(240/255.0f) alpha:1.0];
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
            headerview.adscrollview.backgroundColor = [UIColor clearColor];
            headerview.adscrollview.placeholderImage = [UIImage imageNamed:@""];
            headerview.imgArray = self.adimageArray;
            return headerview ;
        }
        else if(indexPath.section == 3){
            LikeView *view  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LikeView" forIndexPath:indexPath];
            return view;
        }
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            PrductFooterReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PrductFooterReusableView" forIndexPath:indexPath];
            if ( [self.itemDic[@"data"][@"iteminfo"][@"itemSale"] integerValue] > 10000) {
                footerview.count_lab.text = [NSString stringWithFormat:@"%.2f万人已买",[self.itemDic[@"data"][@"iteminfo"][@"itemSale"] floatValue]/10000];
            }else{
                footerview.count_lab.text = [NSString stringWithFormat:@"%@人已买",self.itemDic[@"data"][@"iteminfo"][@"itemSale"]];
            }
            NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[self.itemDic[@"data"][@"iteminfo"][@"itemPrice"]floatValue]];
            footerview.total_price_lab.text = oldPrice;
              NSString *text =  [NSString stringWithFormat:@"￥%.2f",  [self.itemDic[@"data"][@"iteminfo"][@"itemPrice"]floatValue] -  [self.itemDic[@"data"][@"iteminfo"][@"couponPrice"]floatValue]];
            footerview.price_lab.text = text;
    
            NSString *youhuquan =  [NSString stringWithFormat:@"%1.f优惠券      |   立即领取",[self.itemDic[@"data"][@"iteminfo"][@"couponPrice"]floatValue]];
            NSLog(@"youhuquan:%@",youhuquan);
            [footerview.youhunqiuan_btn setTitle:youhuquan forState:UIControlStateNormal];
            [footerview setActionblock:^{
                NSLog(@"领取优惠券的东西了");
            }];
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
        cell.content_lab.text = self.itemDic[@"data"][@"iteminfo"][@"itemTitle"];
        NSString *shenji =  [NSString stringWithFormat:@"升级赚￥%.2f",[self.itemDic[@"data"][@"iteminfo"][@"moretkMoney"]floatValue]];
        [cell.shengji_btn setTitle:shenji forState:UIControlStateNormal];
        //tkMoney
        NSString *yuji = [NSString stringWithFormat:@"预计赚￥%.2f",[self.itemDic[@"data"][@"iteminfo"][@"tkMoney"]floatValue]];
        [cell.yuji_btn setTitle:yuji forState:UIControlStateNormal];
        return cell;
    }if (indexPath.section == 1) {
        ProductLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductLikeCell" forIndexPath:indexPath];
        [cell.icon_img sd_setImageWithURL:[NSURL URLWithString:self.itemDic[@"data"][@"sellerInfo"][@"shopIcon"]] placeholderImage:nil];
        cell.name_lab.text = self.itemDic[@"data"][@"sellerInfo"][@"shopName"];
        cell.subtitle_lab.text = self.itemDic[@"data"][@"sellerInfo"][@"shopName"];
        NSMutableArray *array = [NSMutableArray array];
        array = [EvlationModel mj_objectArrayWithKeyValuesArray:self.itemDic[@"data"][@"sellerInfo"][@"evaluates"]];
        EvlationModel *model1 = array[0];
        EvlationModel *model2 = array[1];
        EvlationModel *model3 = array[2];
        cell.baobei_lab.text = [NSString stringWithFormat:@"%@%@",model1.title,model1.score];
        cell.maijia_lab.text = [NSString stringWithFormat:@"%@%@",model2.title,model2.score];
        cell.wuliu_lab.text = [NSString stringWithFormat:@"%@%@",model3.title,model3.score];
        return cell;
    }if (indexPath.section == 2) {
        ProductImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductImgCell" forIndexPath:indexPath];
        return cell;
    }if (indexPath.section == 3) {
        GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
        GoodsModel *model = self.itemArray[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return (CGSize){[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width};
    }else if(section == 3){
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
        //这里的时候需要去判断下图片的大小
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
    }if (section == 0) {
       return UIEdgeInsetsMake(7, 0, 7, 0);//分别为上、左、下、右
    }
    if (section == 1) {
        return UIEdgeInsetsMake(7, 0, 7, 0);//分别为上、左、下、右
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
    return 4;
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
