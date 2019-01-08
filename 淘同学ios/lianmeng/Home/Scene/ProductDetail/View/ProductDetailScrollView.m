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
#import "UIImage+ImgSize.h"
#import "ShareInfo.h"
#import "ActionSceneModel.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "UserCenter.h"
#import <EasyIOS/EasyIOS.h>
#import "LMNavigationController.h"
#import "WechatLoginScene.h"
#import "DetailSizeModel.h"
#import "DetailScene2.h"
@interface ProductDetailScrollView() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *adimageArray;
@property (nonatomic,strong)NSMutableArray *detailArray;
@property (nonatomic,strong)NSMutableArray *itemArray;
@property (nonatomic,strong)NSDictionary *itemDic; ///详情的功能
@property (nonatomic,retain)NSString *buyUrl;
@property (nonatomic,strong)NSMutableArray *hightArray;
@property (nonatomic,strong)GoodsModel *goodmodel;

@end
@implementation ProductDetailScrollView
-(NSMutableArray *)hightArray
{
    if (!_hightArray) {
        _hightArray = [NSMutableArray array];
    }
    return _hightArray;
}

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

-(void)reloadDetailWithDic:(NSDictionary *)dict withModel:(GoodsModel *)model
{
    self.goodmodel = model;
    self.itemDic = dict;
    self.adimageArray = dict[@"data"][@"iteminfo"][@"taobao_image"];
    self.itemArray = [GoodsModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"SimilarGoods"]];
    self.detailArray = [DetailSizeModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"images"]];
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
            headerview.adscrollview.placeholderImage = [UIImage imageNamed:@"banner"];
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
            if (self.goodmodel.itemSale.integerValue > 10000) {
                footerview.count_lab.text = [NSString stringWithFormat:@"%.2f万人已买",self.goodmodel.itemSale.floatValue/10000];
            }else{
                footerview.count_lab.text = [NSString stringWithFormat:@"%@人已买",self.goodmodel.itemSale];
            }
            NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",self.goodmodel.itemPrice.floatValue];
            footerview.total_price_lab.text = oldPrice;
            NSString *text =  [NSString stringWithFormat:@"￥%.2f",self.goodmodel.itemPrice.floatValue - self.goodmodel.couponPrice.floatValue];
            footerview.price_lab.text = text;
            NSString *youhuquan =  [NSString stringWithFormat:@"%1.f优惠券      |   立即领取",self.goodmodel.couponPrice.floatValue];
            NSLog(@"youhuquan:%@",youhuquan);
            [footerview.youhunqiuan_btn setTitle:youhuquan forState:UIControlStateNormal];
            [footerview setActionblock:^{
                [self LoginMehtod];
            }];
            return footerview;
        }else{
            return nil;
        }
    }
    return nil;
}

-(void)taobaobuy{
    ShareInfo *request = [ShareInfo Request];
    request.itemId = self.goodmodel.itemId;
    request.PATH = @"/mobile/taobao/clickUrl";
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSLog(@"data:%@",request.output[@"data"][@"clickUrl"]);
        self.buyUrl = request.output[@"data"][@"clickUrl"];
        [self tbPage:self.buyUrl];
    } error:^{
    }];
}
-(void)LoginMehtod{
    if(![[UserCenter sharedInstance] checkLogin]){
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"需要登录" message:@"此操作需要登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIViewController *vc = [[LMNavigationController alloc]initWithRootViewController:[[WechatLoginScene alloc]init]];
            [[URLNavigation navigation].currentViewController presentViewController:vc animated:YES completion:nil];
        }]];
        [[URLNavigation navigation].currentViewController presentViewController:alert animated:YES completion:nil];
        return;
    }
    if([UserCenter sharedInstance].loginModel.shopLimti.floatValue < [self.itemDic[@"data"][@"iteminfo"][@"couponPrice"]floatValue]){
        [DialogUtil showMessage:@"额度不足无法领取"];
        return;
    }
    [self taobaobuy];
}
-(void)tbPage:(NSString *)url{
    id<AlibcTradeService> tradeService = [[AlibcTradeSDK sharedInstance] tradeService];
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = AlibcOpenTypeNative;
    showParam.backUrl=@"tbopen24942494://";
    showParam.isNeedPush=NO;
    showParam.nativeFailMode = AlibcNativeFailModeJumpBrowser;
    AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
    taoKeParams.pid= @"mm_132592094_0_0"; //
    //打开商品详情页
    id<AlibcTradePage> page = [AlibcTradePageFactory page: url];
    
    [tradeService show:self page:page showParams:showParam taoKeParams:taoKeParams trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
        NSLog(@"%@",result);
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ProductContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductContentCell" forIndexPath:indexPath];
        cell.content_lab.text = self.goodmodel.itemTitle;
        NSString *shenji =  [NSString stringWithFormat:@"升级赚￥%.2f",self.goodmodel.moretkMoney.floatValue];
        [cell.shengji_btn setTitle:shenji forState:UIControlStateNormal];
        //tkMoney
        NSString *yuji = [NSString stringWithFormat:@"预计赚￥%.2f",self.goodmodel.tkMoney.floatValue];
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
        cell.baobei_lab.text = [NSString stringWithFormat:@"%@%@",model1.title?:@"",model1.score?:@""];
        cell.maijia_lab.text = [NSString stringWithFormat:@"%@%@",model2.title?:@"",model2.score?:@""];
        cell.wuliu_lab.text = [NSString stringWithFormat:@"%@%@",model3.title?:@"",model3.score?:@""];
        return cell;
    }if (indexPath.section == 2) {
        ProductImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductImgCell" forIndexPath:indexPath];
        DetailSizeModel *model = self.detailArray[indexPath.row];
        [cell.detail_img sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"banner"]];
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
        if (self.detailArray.count>0) {
            DetailSizeModel *model = self.detailArray[indexPath.row];
            return CGSizeMake(ScreenW, ScreenW*model.Height.floatValue/model.Width.floatValue);
        }
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
        GoodsModel *model =  [_detailArray safeObjectAtIndex:indexPath.row];
        if (model.platformId == 1) {
            DetailScene2 *detail = [[DetailScene2 alloc]init];
            detail.model = [_detailArray safeObjectAtIndex:indexPath.row];
            [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
        }else{
            DetailScene *detail = [[DetailScene alloc]init];
            detail.model = [_detailArray safeObjectAtIndex:indexPath.row];
            [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
        }
    }
}
@end
