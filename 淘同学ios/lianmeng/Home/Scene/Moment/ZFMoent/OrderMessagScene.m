//  OrderMessagScene.m
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "OrderMessagScene.h"
#import "UserCenter.h"
@interface OrderMessagScene ()
@property(nonatomic,retain)UIWebView *webView;
@end
@implementation OrderMessagScene
- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight-49)];
    NSString *url = [NSString stringWithFormat:@"http://www.taotongxue.cn/mobile/notice/detail/%ld",(long)[UserCenter sharedInstance].loginModel.userId];
    _webView.backgroundColor = [UIColor clearColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:_webView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
