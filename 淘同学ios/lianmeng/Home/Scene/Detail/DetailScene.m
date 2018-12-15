//
//  DetailScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "DetailScene.h"
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

@interface DetailScene ()<UIWebViewDelegate,DetailDelegate,DetailHeaderViewDelegate>
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)DetailHeaderView *headerView;
@property(nonatomic,retain)DetailBottomView *bottomView;

@property(nonatomic,strong)UIImageView *shengjizhuanBg;
@property(nonatomic,strong)UILabel *shengjizhuanLabel;

@property(nonatomic,strong)UIImageView *yujizhuanBg;
@property(nonatomic,strong)UILabel *yujizhuanLabel;

@property(nonatomic,retain)NSString *buyUrl;
@property(nonatomic,retain)NSArray *mUrlArray;
@end

@implementation DetailScene

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_LEFT button:leftButton];
    
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setImage:[UIImage imageNamed:@"xihuan"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_RIGHT button:rightButton];
    
    _webView = [[UIWebView alloc]init];
    _webView.delegate = self;
    [self addSubView:_webView extend:EXTEND_NONE];
    
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    CGFloat height = 425.0f;
    _webView.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 55.0f+kBottomSafeHeight, 0);

    
    _bottomView = [[DetailBottomView alloc]init];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(55.0f+kBottomSafeHeight));
    }];
    
    _shengjizhuanBg = [[UIImageView alloc]init];
    [self.view addSubview:_shengjizhuanBg];
    [_shengjizhuanBg setImage:[UIImage imageNamed:@"shengjizhuan"]];
    
    _shengjizhuanLabel = [[UILabel alloc]init];
    [_shengjizhuanBg addSubview:_shengjizhuanLabel];
    _shengjizhuanLabel.numberOfLines = 2;
    _shengjizhuanLabel.text = @"升级赚￥0.00";
    _shengjizhuanLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10.0f];
    _shengjizhuanLabel.textColor = [UIColor whiteColor];
    
    _yujizhuanBg = [[UIImageView alloc]init];
    [self.view addSubview:_yujizhuanBg];
    [_yujizhuanBg setImage:[UIImage imageNamed:@"yuji"]];
    
    _yujizhuanLabel = [[UILabel alloc]init];
    [_yujizhuanBg addSubview:_yujizhuanLabel];
    _yujizhuanLabel.numberOfLines = 2;
    _yujizhuanLabel.text = @"预计赚￥0.00";
    _yujizhuanLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10.0f];
    _yujizhuanLabel.textColor = [UIColor whiteColor];
    
    
    [_shengjizhuanBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(220.0f);
    }];
    
    [_shengjizhuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shengjizhuanBg).offset(-10.0f);
        make.centerY.equalTo(self.shengjizhuanBg);
        make.width.equalTo(@30.0f);
    }];
    
    [_yujizhuanBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(258.0f);
    }];
    
    [_yujizhuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.yujizhuanBg).offset(-10.0f);
        make.centerY.equalTo(self.yujizhuanBg);
        make.width.equalTo(@30.0f);
    }];

    [self getModel];
    // Do any additional setup after loading the view.
}

-(void)getModel{
    if (self.model) {
        NSString *url = [NSString stringWithFormat:@"%@/mobile/%@/itemdetail?itemId=%@",URLHOST,self.model.platformId == 1?@"taobao":@"jd",self.model.itemId];
        [_webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]]];
        
        [self loadModel:_model];
    }else{
        NSString *url = [NSString stringWithFormat:@"%@/mobile/%@/itemdetail?itemId=%@",URLHOST,_platformId == 1?@"taobao":@"jd",_itemId];
        [_webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]]];
        
        ShareItemInfoRequest *request = [ShareItemInfoRequest Request];
        request.platformId = @(_platformId);
        request.itemId = _itemId;
        
        @weakify(self);
        [[ActionSceneModel sharedInstance] doRequest:request success:^{
            @strongify(self);
            NSError *error;
            self.model = [[GoodsModel alloc]initWithDictionary:[request.output objectForKey:@"data"] error:&error];
            [self loadModel:self.model];
        } error:^{
            
        }];
    }
}

-(void)loadModel:(GoodsModel *)model{
    CGFloat height = 425.0f;
    
    if (model.couponPrice) {
        height = 567.0f;
    }
    _headerView = [[DetailHeaderView alloc]initWithFrame:CGRectMake(0, -height, [UIScreen mainScreen].bounds.size.width, height)];
    _headerView.delegate = self;
    [_webView.scrollView addSubview:_headerView];
    
    _webView.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 55.0f+kBottomSafeHeight, 0);

    _bottomView.model = model;
    _headerView.model = model;
    
    if(_model.moretkMoney && [UserCenter sharedInstance].loginModel.userLevel < 3){
        _shengjizhuanBg.hidden = NO;
        _shengjizhuanLabel.text =[NSString stringWithFormat:@"升级赚￥%.2f",model.moretkMoney.floatValue];
    }else{
        _shengjizhuanBg.hidden = YES;
    }
    
    if(_model.tkMoney){
        _yujizhuanBg.hidden = NO;
        _yujizhuanLabel.text =[NSString stringWithFormat:@"预计赚￥%.2f",model.tkMoney.floatValue];
    }else{
        _yujizhuanBg.hidden = YES;
    }
    [self getUrl:model];
}

-(void)getUrl:(GoodsModel *)model{
    if(model.platformId == 1){
        ShareInfo *request = [ShareInfo Request];
        request.itemId = model.itemId;
        request.PATH = @"/mobile/taobao/clickUrl";
        @weakify(self);
        [[ActionSceneModel sharedInstance] doRequest:request success:^{
            @strongify(self);
            self.buyUrl = request.output[@"data"];
        } error:^{
            
        }];
    }else{
        self.buyUrl = model.activityid;
    }

}

-(void)rightButtonTouch{
    FavScene *scene = [[FavScene alloc]init];
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    self.mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
}


-(void)shareAction{
    if(!self.mUrlArray) return;
    ShareScene *share = [[ShareScene alloc]init];
    share.model = self.model;
    share.mUrlArray = self.mUrlArray;
    [self.navigationController pushViewController:share animated:YES];
}

-(void)buyAction{
    
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
    
    if([UserCenter sharedInstance].loginModel.shopLimti.floatValue < _model.couponPrice.floatValue){
        [DialogUtil showMessage:@"额度不足无法领取"];
        return;
    }
    if(!_buyUrl) {
        [self getUrl:_model];
        return;
    }
    if (self.model.platformId == 1) {
        [self tbPage:_buyUrl];
    }else {
        [self jdPage:_buyUrl];
    }
}

-(void)jdPage:(NSString *)url{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"jdlogin://"]]){
        [[KeplerApiManager sharedKPService] openKeplerPageWithURL:url userInfo:nil failedCallback:^(NSInteger code, NSString *url) {
            if (code == 422) {
                [DialogUtil showMessage:@"请先安装京东APP"];
            }
        }];
    }else{
        [DialogUtil showMessage:@"未安装京东APP"];
    }

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
