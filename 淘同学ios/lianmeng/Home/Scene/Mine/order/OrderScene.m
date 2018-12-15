//
//  OrderScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "OrderScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <Masonry/Masonry.h>
#import "OrderHeaderView.h"
#import <EasyIOS/EasyIOS.h>
#import "OrderCell.h"
#import "UserOrderListSceneModel.h"
#import "OrderScrollView.h"

@interface OrderScene ()
@property(nonatomic,retain)OrderHeaderView *headerView;
@property(nonatomic,retain)OrderScrollView *scrollView;
@end

@implementation OrderScene

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
    
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"我的订单"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    
    _headerView = [[OrderHeaderView alloc]init];
    
    [self.view addSubview:_headerView];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@167.0f);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kStatusBarAndNavigationBarHeight);
    }];
    
    _scrollView = [[OrderScrollView alloc]initWithFrame:CGRectMake(0, 167.0f+kStatusBarAndNavigationBarHeight, ScreenW, ScreenH-167.0f-kStatusBarAndNavigationBarHeight) subViewCount:5];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    _headerView.delegate = _scrollView;
    _scrollView.tabDelegate = _headerView;
    _scrollView.platformId = 1;
}


@end
