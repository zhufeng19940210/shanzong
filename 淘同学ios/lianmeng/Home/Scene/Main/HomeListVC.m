//  HomeListVC.m
//  lianmeng
//  Created by zhufeng on 2018/12/14.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "HomeListVC.h"
#import "MainScene.h"
#import "ZJScrollPageView.h"
#import "SearchView.h"
#import <Masonry.h>
#import "SearchScene.h"
#import "QRReaderViewController.h"
#import "CardCodeRequest.h"
#import "ActionSceneModel.h"
#import "DialogUtil.h"
#import "OtherScene.h"
#import "MainItemModel.h"
#import <MJExtension.h>
@interface HomeListVC ()<ZJScrollPageViewDelegate,QRReaderViewControllerDelegate>
@property (nonatomic, weak) ZJScrollPageView *scrollPageView;
@property (nonatomic,strong)SearchView *searchView;
@property (nonatomic,strong)NSMutableArray *listArray;
@end
@implementation HomeListVC
-(NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
#pragma mark - getter
- (ZJScrollPageView *)scrollPageView
{
    if(_scrollPageView == nil)
    {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showLine = YES;
        style.gradualChangeTitleColor = YES;
        style.contentViewBounces = NO;
        style.animatedContentViewWhenTitleClicked = NO;
        style.autoAdjustTitlesWidth = YES;
        style.scrollLineColor = [UIColor redColor];
        style.selectedTitleColor = [UIColor redColor];
        style.normalTitleColor = RGB(50,50,50);
        style.titleFont = [UIFont boldSystemFontOfSize:17];
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight-49) segmentStyle:style titles:[self.childViewControllers valueForKey:@"title"] parentViewController:self delegate:self withColor:[UIColor whiteColor]];
        [self.view addSubview:scrollPageView];
        _scrollPageView = scrollPageView;
    }
    return _scrollPageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    [self.listArray removeAllObjects];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MainItem" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.listArray = [MainItemModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
    [self setupNavigtaion];
    [self setupHomeUI];
}
-(void)setupNavigtaion{
    self.searchView = [[SearchView alloc]init];
    self.searchView.frame = CGRectMake(0, 0, ScreenW, kStatusBarAndNavigationBarHeight);
    [self.view addSubview:_searchView];
    __weak typeof(self) weakSelf = self;
    [_searchView setSearchblock:^{
        SearchScene *searchvc = [[SearchScene alloc]init];
        [weakSelf.navigationController pushViewController:searchvc animated:YES];
    }];
    [_searchView setScanblock:^{
        QRReaderViewController *vc = [[QRReaderViewController alloc]init];
        vc.delegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
       
    }];
    [_searchView setMessageblock:^{
        self.tabBarController.selectedIndex = 2;
    }];
}
-(void)didFinishedReadingQR:(NSString *)string{
    [self dismissViewControllerAnimated:YES completion:nil];
    CardCodeRequest *req = [CardCodeRequest Request];
    req.cardCode = string;
    [[ActionSceneModel sharedInstance] doRequest:req success:^{
        [DialogUtil showMessage:req.message];
    } error:^{
        [DialogUtil showMessage:req.message];
    }];
}
-(void)setupHomeUI{
    self.view.backgroundColor = RGB(240, 240, 240);
    for (int i = 0 ; i<self.listArray.count+1;i++) {
        Scene *scene = nil;
        if (i == 0) {
            MainScene *mainvc = [[MainScene alloc]init];
            mainvc.title = @"首页";
            scene = mainvc;
        }else{
            MainItemModel *model = self.listArray[i-1];
            OtherScene *othervc = [[OtherScene alloc]init];
            othervc.title = model.name;
            othervc.cid  = model.did;
            scene = othervc;
        }
        [self addChildViewController:scene];
    }
    self.scrollPageView.backgroundColor = RGB(240, 240, 240);
}
#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.childViewControllers.count;
}
- (UIViewController <ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = self.childViewControllers[index];
    }
    return childVc;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}
@end
