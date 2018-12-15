//
//  NoticeScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "NoticeScene.h"
#import <Masonry/Masonry.h>
#import "MessageScrollView.h"
#import "UserCenter.h"

@interface NoticeScene ()
@property(nonatomic,retain)UIWebView *webView;
@end

@implementation NoticeScene

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


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
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text =@"消息";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleBgImage).offset(15.0f);
        make.bottom.equalTo(titleBgImage).offset(-10.0f);
    }];
    
    NSString *url = [NSString stringWithFormat:@"http://www.taotongxue.cn/mobile/notice/detail/%ld",(long)[UserCenter sharedInstance].loginModel.userId];
    _webView = [[UIWebView alloc]init];
    _webView.backgroundColor = [UIColor clearColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(titleBgImage.mas_bottom);
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
