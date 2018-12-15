//
//  RankScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/22.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "RankScene.h"
#import "Scene+NavBar.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
#import "RankScrollView.h"
#import "RankListRequest.h"
#import "ActionSceneModel.h"

@interface RankScene ()
@property(nonatomic,retain)UISegmentedControl *segment;
@property(nonatomic,retain)RankScrollView *scrollView;
@end

@implementation RankScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithString:@"#f33019"].CGColor, (__bridge id)[UIColor colorWithString:@"#f47018"].CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.view.frame;
    [self.view.layer addSublayer:gradientLayer];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"white-back"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_LEFT button:btn];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"收入榜单";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:RegularFont size:18.0f];
    self.navBar.centerView = label;
    
    
    _segment = [[UISegmentedControl alloc]initWithItems:@[@"今日收入榜单",@"7日收入榜单"]];
    _segment.tintColor = [UIColor whiteColor];
    [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#f33019"]} forState:UIControlStateSelected];
    [_segment addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    
    [_segment setSelectedSegmentIndex:0];
    
    [_segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kStatusBarAndNavigationBarHeight + 10.0f);
    }];
    
    _scrollView = [[RankScrollView alloc]init];
    [self.view addSubview:_scrollView];
    [_scrollView addContentView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.segment.mas_bottom).offset(10.0f);
    }];
    [self reloadData:1];
}

-(void)reloadData:(NSUInteger)type{
    RankListRequest *request = [RankListRequest Request];
    request.type = @(type);
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSMutableArray * array = [NSMutableArray arrayWithArray:[request.output objectForKey:@"data"]];
        [self.scrollView reloadList:array];
    } error:^{
        
    }];
}

-(void)segChanged:(UISegmentedControl *)seg{
    NSUInteger selectedSegmentIndex = seg.selectedSegmentIndex + 1;
    [self reloadData:selectedSegmentIndex];
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
