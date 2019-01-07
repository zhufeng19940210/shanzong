//
//  DetailScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "DetailScene2.h"
#import "Scene+NavBar.h"
#import <Masonry/Masonry.h>
#import "DetailHeaderView.h"
#import "DetailBottomView.h"
#import "FavScene.h"
#import "ShareInfo.h"
#import "ActionSceneModel.h"
#import "ShareItemInfoRequest.h"
#import "ShareScene.h"
#import <JDSDK/JDKeplerSDK.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "UserCenter.h"
#import "LMNavigationController.h"
#import "WechatLoginScene.h"
#import "ProdcutRequest.h"
#import "ActionSceneModel.h"
#import "ProductDetailScrollView.h"
#import "Scene+NavBar.h"
#import <Masonry.h>
#import "ProductBottomView.h"
#import <EasyIOS/EasyIOS.h>
#import "UserCenter.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "DetailSizeModel.h"
@interface DetailScene2 ()<DetailDelegate,ProductBottomViewDelegate>
@property (nonatomic,strong)ProductDetailScrollView *collectionview;
@property (nonatomic,retain)DetailBottomView *bottomView;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong)ProductBottomView *bottomview;
@property (nonatomic,retain)NSString *buyUrl;
@property (nonatomic,strong)NSDictionary *responseDict;
@property (nonatomic,strong)NSMutableArray *detailArray;
@end
@implementation DetailScene2
-(NSMutableArray *)detailArray
{
    if (!_detailArray) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}
-(UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 50, 50)];
        [_backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(actionBackBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_LEFT button:leftButton];
    
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setImage:[UIImage imageNamed:@"xihuan"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_RIGHT button:rightButton];
    //创建collectionview的视图
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = 1;//行间距
    flow.minimumInteritemSpacing = 1;//列间距
    _collectionview = [[ProductDetailScrollView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionview.frame = CGRectMake(0, 0, ScreenW, ScreenH-50);
    [self.view addSubview:_collectionview];
    if (@available(iOS 11.0, *)) {
        _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    _bottomView = [[DetailBottomView alloc]init];
//    _bottomView.frame = CGRectMake(0, ScreenH-50, ScreenW, 50);
//    _bottomView.delegate = self;
//    [self.view addSubview:_bottomView];
    self.bottomview = [ProductBottomView filterView];
    self.bottomview.frame = CGRectMake(0, ScreenH-50, ScreenW, 50);
    self.bottomview.delegate = self;
    [self.view addSubview:self.bottomview];
    [SVProgressHUD show];
    ProdcutRequest *request = [ProdcutRequest Request];
    NSString *imteid = [NSString stringWithFormat:@"%@",self.model.itemId];
    if (imteid.length !=0) {
        request.itemId = imteid;
    }else{
      request.itemId = self.itemId;
    }
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        [SVProgressHUD dismiss];
        self.responseDict = request.output;
        self.bottomview.middle_price_lab.text = [NSString stringWithFormat:@"￥%.2f",[self.responseDict[@"data"][@"iteminfo"][@"tkMoney"]floatValue]] ;
        self.bottomview.last_price_lab.text  = [NSString stringWithFormat:@"￥%.2f",[self.responseDict[@"data"][@"iteminfo"][@"couponPrice"]floatValue]];
        self.detailArray = self.responseDict[@"data"][@"images"];
        if ([[self.responseDict valueForKey:@"status"] intValue] == 200) {
            [self.collectionview reloadDetailWithDic:self.responseDict];
            //[self setupReloadMethodWithDict:self.responseDict];
        }
    } error:^{
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        return;
    }];
}
-(void)setupReloadMethodWithDict:(NSDictionary *)dict
{
}
#pragma mark -- actionBackBtn
-(void)actionBackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    for(UIView *view in keyWindow.subviews){
        if ([view isKindOfClass:[self.backBtn class]]) {
            [view removeFromSuperview];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.backBtn];
}
-(void)ProductBottomWithTag:(int)productTag
{
    NSLog(@"productTag:%d",productTag);
    if (productTag == 0) {
        NSLog(@"收藏");
        TMDiskCache * cache = [[TMCache sharedCache] diskCache];
        NSArray *object = (NSArray *)[cache objectForKey:@"favList"];
        if (object) {
            id find = [object find:^BOOL(GoodsModel* obj) {
                return obj.itemId.integerValue == self.model.itemId.integerValue;
            }];
            if (!find) {
                NSMutableArray *ar = [NSMutableArray arrayWithArray:object];
                [ar addObject:self.model];
                [cache setObject:ar forKey:@"favList"];
            }
        }else{
            NSArray *array = @[self.model];
            [cache setObject:array forKey:@"favList"];
        }
        self.bottomview.love_title_lab.text = @"已收藏";
        self.bottomview.love_imag.image = [UIImage imageNamed:@"star1"];
    }else if(productTag == 1){
        NSLog(@"分享赚");
        [self myshareAction];
    }else if(productTag == 2){
        NSLog(@"自己买");
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
        if([UserCenter sharedInstance].loginModel.shopLimti.floatValue < [self.responseDict[@"data"][@"iteminfo"][@"couponPrice"]floatValue]){
            [DialogUtil showMessage:@"额度不足无法领取"];
            return;
        }
        [self taobaobuy2];
    }
}
-(void)myshareAction{
    if(!self.detailArray) return;
    ShareScene *share = [[ShareScene alloc]init];
    share.model = self.model;
    share.mUrlArray = self.detailArray;
    [self.navigationController pushViewController:share animated:YES];
}
-(void)taobaobuy2{
    ShareInfo *request = [ShareInfo Request];
    request.itemId = self.responseDict[@"data"][@"iteminfo"][@"itemId"];
    NSLog(@"request.itemId:%@",request.itemId);
    request.PATH = @"/mobile/taobao/clickUrl";
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSLog(@"data:%@",request.output[@"data"]);
        self.buyUrl = request.output[@"data"][@"clickUrl"];
        [self mybuyAction];
    } error:^{
    }];
}
-(void)mybuyAction{
   
    [self tbPage:self.buyUrl];
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
@end
