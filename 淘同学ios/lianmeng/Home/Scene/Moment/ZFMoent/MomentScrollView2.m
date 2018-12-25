//  MomentScrollView.m
//  lianmeng
//  Created by zhufeng on 2018/12/25.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "MomentScrollView2.h"
#import "StudentScene.h"
#import "OrderMessagScene.h"
#import "SendCircleScene.h"
@interface MomentScrollView2 ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>
@property (nonatomic,strong)SGPageTitleView *pageTitleView;
@property (nonatomic,strong)SGPageContentScrollView *pageContentScrollView;
@property (nonatomic,strong)SearchTopView *topView;
@end
@implementation MomentScrollView2
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden =YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reciveMessage) name:@"puhsMessage" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.topView = [[SearchTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, kStatusBarAndNavigationBarHeight)];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.leftButton.hidden = YES;
    self.topView.titlelab.text = @"同学圈";
    self.topView.titlelab.textColor = [UIColor blackColor];
    [self.view addSubview:self.topView];
    [self setupUI];
}
-(void)reciveMessage
{
   [self.pageContentScrollView setPageContentScrollViewCurrentIndex:2];
}
-(void)setupUI
{
    NSArray *titleArr = @[@"同学精选", @"发圈素材", @"消息通知"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.showBottomSeparator = NO;
    configure.titleFont = [UIFont boldSystemFontOfSize:17];
    configure.indicatorAdditionalWidth = 10;
    // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleGradientEffect = YES;
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    StudentScene *studentvc = [[StudentScene alloc]init];
    OrderMessagScene *messagevc = [[OrderMessagScene alloc]init];
    SendCircleScene *sendcirlevc  = [[SendCircleScene alloc]init];
    NSArray *childArr = @[studentvc,sendcirlevc,messagevc];
    /// pageContentScrollView
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
