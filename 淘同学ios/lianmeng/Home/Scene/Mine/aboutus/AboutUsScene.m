//
//  AboutUsScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/8/2.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "AboutUsScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <Masonry/Masonry.h>
#import "LinkWebScene.h"
#import "UserCenter.h"
#import "LMNavigationController.h"
#import "WechatLoginScene.h"
#import "JPUSHService.h"
#import <EasyIOS/EasyIOS.h>
#import "TabBarController.h"

@interface AboutUsScene ()
@property(nonatomic,retain)UIScrollView *scrollView;
@end

@implementation AboutUsScene

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *titleBgImage = [[UIImageView alloc]init];
    [titleBgImage setImage:[UIImage imageNamed:@"nav-bg"]];
    [self.view addSubview:titleBgImage];
    
    [titleBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"设置"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];

    
    _scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:_scrollView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
    UIImageView *logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [_scrollView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).offset(45.0f);
    }];
    
    UILabel *version = [[UILabel alloc]init];
    [_scrollView addSubview:version];
    version.font = [UIFont fontWithName:MediumFont size:15.0f];
    version.textColor = [UIColor colorWithString:@"#A9A8A7"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    version.text = [NSString stringWithFormat:@"%@ %@",app_Name,app_Version];
    [version mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(logo);
        make.top.equalTo(logo.mas_bottom).offset(12.5f);
    }];
    
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.font = [UIFont fontWithName:MediumFont size:14.0F];
    label1.textColor = [UIColor colorWithString:@"#636161"];
    label1.text = @"功能介绍";
    label1.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.scrollView).offset(20.0f);
        make.right.equalTo(self.scrollView).offset(-20.0f);
        make.top.equalTo(version.mas_bottom).offset(80.0f);
    }];
    
    label1.userInteractionEnabled = YES;
    [label1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLabel:)]];
    
    
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fengex"]];
     [_scrollView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20.0f);
        make.right.equalTo(self.scrollView).offset(-20.0f);
        make.top.equalTo(label1.mas_bottom).offset(12.5f);
    }];
    
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.font = [UIFont fontWithName:MediumFont size:14.0F];
    label2.textColor = [UIColor colorWithString:@"#636161"];
    label2.text = @"投诉";
    label2.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20.0f);
        make.right.equalTo(self.scrollView).offset(-20.0f);
        make.top.equalTo(label1.mas_bottom).offset(24.0f);
    }];
    label2.userInteractionEnabled = YES;
    [label2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLabel:)]];
    
    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fengex"]];
    [_scrollView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20.0f);
        make.right.equalTo(self.scrollView).offset(-20.0f);
        make.top.equalTo(label2.mas_bottom).offset(12.5f);
    }];
    
    
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.font = [UIFont fontWithName:MediumFont size:14.0F];
    label3.textColor = [UIColor colorWithString:@"#636161"];
    label3.text = @"检查新版本";
    label3.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20.0f);
        make.right.equalTo(self.scrollView).offset(-20.0f);
        make.top.equalTo(label2.mas_bottom).offset(24.0f);
    }];
    label3.userInteractionEnabled = YES;
    [label3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLabel:)]];
    
    
    UIImageView *line3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fengex"]];
    [_scrollView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20.0f);
        make.right.equalTo(self.scrollView).offset(-20.0f);
        make.top.equalTo(label3.mas_bottom).offset(12.5f);
    }];
    
    
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.font = [UIFont fontWithName:MediumFont size:14.0F];
    label4.textColor = [UIColor colorWithString:@"#636161"];
    label4.text = @"退出登录";
    label4.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:label4];
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20.0f);
        make.right.equalTo(self.scrollView).offset(-20.0f);
        make.top.equalTo(label3.mas_bottom).offset(24.0f);
    }];
    label4.userInteractionEnabled = YES;
    [label4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLabel:)]];
    
    
    UIImageView *line4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fengex"]];
    [_scrollView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(20.0f);
        make.right.equalTo(self.scrollView).offset(-20.0f);
        make.top.equalTo(label4.mas_bottom).offset(12.5f);
    }];
    
    
    
    UIImageView *aboutUsBottom = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aboutUs-bottom"]];
    [_scrollView addSubview:aboutUsBottom];
    [aboutUsBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).offset(ScreenH - 64 - 50.0f - kStatusBarAndNavigationBarHeight);
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchLabel:(UITapGestureRecognizer *)gesture{
    UILabel *label = (UILabel *)gesture.view;

    if ([label.text isEqualToString:@"功能介绍"]) {
        LinkWebScene *web = [[LinkWebScene alloc]init];
        web.url = [NSString stringWithFormat:@"%@/mobile/toIntroFunction",URLHOST];
        web.title = @"功能介绍";
        [self.navigationController pushViewController:web animated:YES];
    }else if ([label.text isEqualToString:@"投诉"]) {
        LinkWebScene *web = [[LinkWebScene alloc]init];
        web.url = [NSString stringWithFormat:@"%@/mobile/complain/%ld",URLHOST,(long)[UserCenter sharedInstance].loginModel.userId];
        web.title = @"投诉";
        [self.navigationController pushViewController:web animated:YES];
    }else if ([label.text isEqualToString:@"检查新版本"]) {
        [DialogUtil showMessage:@"已是最新版本"];
//        NSString *appStoreStr = @"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8";
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreStr]];
    }else if([label.text isEqualToString:@"退出登录"]){
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
        } seq:0];
        [[UserCenter sharedInstance] removeUserData];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarController alloc]init];
    }
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
