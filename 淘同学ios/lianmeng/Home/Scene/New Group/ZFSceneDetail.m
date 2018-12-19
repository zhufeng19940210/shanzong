//  ZFSceneDetail.m
//  lianmeng
//  Created by zhufeng on 2018/12/19.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "ZFSceneDetail.h"
@interface ZFSceneDetail ()
@property(nonatomic,strong)SearchTopView *topView;
@property(nonatomic,retain)UIWebView *webView;
@end
@implementation ZFSceneDetail
- (void)viewDidLoad {
    [super viewDidLoad];
    _topView = [[SearchTopView alloc]init];
    _topView.frame = CGRectMake(0, 0, ScreenW, kStatusBarAndNavigationBarHeight);
    _topView.backgroundColor = [UIColor redColor];
    _topView.titlelab.textColor = [UIColor whiteColor];
    _topView.titlelab.text = @"轮播详情";
    [_topView.leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topView];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight)];
    NSString *url = [NSString stringWithFormat:@"%@",self.detailStr];
    _webView.backgroundColor = [UIColor clearColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:_webView];
}
-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
