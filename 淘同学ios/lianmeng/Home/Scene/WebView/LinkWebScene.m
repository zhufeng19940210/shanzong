//
//  LinkWebScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/11.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "LinkWebScene.h"
#import "Scene+NavBar.h"
#import "NavLeftView.h"
#import <Masonry//Masonry.h>
@interface LinkWebScene ()
@property(nonatomic,retain)UIWebView *webView;
@end

@implementation LinkWebScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *titleBgImage = [[UIImageView alloc]init];
    [titleBgImage setImage:[UIImage imageNamed:@"nav-bg"]];
    [self.view addSubview:titleBgImage];
    
    [titleBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:self.title]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];

    _webView = [[UIWebView alloc]init];
    _webView.backgroundColor = [UIColor clearColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
