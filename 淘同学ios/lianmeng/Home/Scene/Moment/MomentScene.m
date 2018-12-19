//
//  MomentScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MomentScene.h"
#import "SlideBar.h"
#import <Masonry/Masonry.h>
#import "MomentScrollView.h"
#import "Scene+NavBar.h"
@interface MomentScene ()<UIScrollViewDelegate,SlideBarDelegate>
@property(nonatomic,retain)SlideBar *slideBar;
@property(nonatomic,retain)MomentScrollView *scrollview;
@end
@implementation MomentScene
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self nav_setTitle:@"同学圈"];
    _slideBar = [[SlideBar alloc]init];
    _slideBar.delegate = self;
    [self.view addSubview:_slideBar];
    [_slideBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarAndNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@47.0f);
    }];
    
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    CGFloat height =[UIScreen mainScreen].bounds.size.height-kStatusBarAndNavigationBarHeight-47.0f - 49.0f;
    _scrollview = [[MomentScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    _scrollview.delegate = self;
    [self.view addSubview:_scrollview];
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.slideBar.mas_bottom);
    }];
    _scrollview.contentInset = UIEdgeInsetsMake(0, 0, kBottomSafeHeight+49.0f, 0);
    
    // Do any additional setup after loading the view.
}

-(void)switchIndex:(NSUInteger)idx{
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    [_scrollview setContentOffset:CGPointMake(idx*width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    NSInteger index = scrollView.contentOffset.x/width;
    [_slideBar setHeightLight:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
