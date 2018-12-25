//  MainScrollview.m
//  lianmeng
//  Created by zhufeng on 2018/12/24.
//  Copyright © 2018 zhuchao. All rights reserved
#import "MainScrollview.h"
#import "MainScene.h"
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
@interface MainScrollview () <SGPageTitleViewDelegate,SGPageContentScrollViewDelegate,QRReaderViewControllerDelegate>
@property (nonatomic,strong) SGPageTitleView *pageTitleView;
@property (nonatomic,strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) SearchView *searchView;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) NSMutableArray *childArr;
@end
@implementation MainScrollview
-(NSMutableArray *)childArr
{
    if (!_childArr) {
        _childArr = [NSMutableArray array];
    }
    return _childArr;
}
-(NSMutableArray *)titleArray
{
    if(!_titleArray){
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
-(NSMutableArray *)listArray
{
    if(!_listArray){
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.listArray removeAllObjects];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MainItem" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.listArray = [MainItemModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
    [self setupNavigtaion];
    [self setupHomeUI];
}

-(void)setupNavigtaion
{
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
        weakSelf.tabBarController.selectedIndex = 2;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"puhsMessage" object:nil];
    }];
}
-(void)setupHomeUI{
    [self.titleArray removeAllObjects];
    [self.childArr removeAllObjects];
    NSString *titleName = nil;
    UIViewController *childController = nil;
    for(int i = 0 ; i< self.listArray.count+1;i++){
        if (i == 0) {
            MainScene *mainvc = [[MainScene alloc]init];
            titleName = @"首页";
            childController = mainvc;
        }else{
            MainItemModel *model = self.listArray[i-1];
            OtherScene *othervc = [[OtherScene alloc]init];
            titleName = model.name;
            othervc.cid  = model.did;
            childController = othervc;
        }
        [self.titleArray addObject:titleName];
        [self.childArr addObject:childController];
    }
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.showBottomSeparator = NO;
    configure.titleFont = [UIFont boldSystemFontOfSize:17];
    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleGradientEffect = YES;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, self.view.frame.size.width, 44) delegate:self titleNames:self.titleArray configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    /// pageContentScrollView
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:self.childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}
#pragma mark SGPageContentScrollViewDelegate || SGPageTitleViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index
{
    NSLog(@"index:%ld",(long)index);
}
#pragma mark QRReaderViewControllerDelegate
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
@end
