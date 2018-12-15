//
//  MessageScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MessageScene.h"
#import <Masonry/Masonry.h>
#import "MessageScrollView.h"

@interface MessageScene ()<UIScrollViewDelegate>
@property(nonatomic,retain)UIButton *button1;
@property(nonatomic,retain)UIButton *button2;

@property(nonatomic,retain)MessageScrollView *scrollview;
@end

@implementation MessageScene

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

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
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text =@"消息";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(titleBgImage).offset(15.0f);
        make.bottom.equalTo(titleBgImage).offset(-10.0f);
    }];
    
    UIView *buttonsView = [[UIView alloc]init];
    buttonsView.backgroundColor = [UIColor colorWithString:@"#F5F4F3"];
    [self.view addSubview:buttonsView];
    [buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarAndNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@50.0f);
    }];
    
    UIColor *yellowColor = [UIColor colorWithRed:244.0f/255.0f green:112.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
    UIColor *grayColor = [UIColor colorWithRed:160.0f/255.0f green:160.0f/255.0f blue:160.0f/255.0f alpha:1.0f];
    
    _button1 = [[UIButton alloc]init];
    _button1.tag = 0;
    [_button1 addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    _button1.backgroundColor = [UIColor whiteColor];
    [_button1 setTitleColor:yellowColor forState:UIControlStateNormal];
    [_button1 setTitle:@"官方通知" forState:UIControlStateNormal];
    _button1.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    _button1.selected = YES;
    [buttonsView addSubview:_button1];
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonsView);
        make.height.equalTo(@50.0f);
    }];
    
    _button2 = [[UIButton alloc]init];
    _button2.tag = 1;
    [_button2 addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    _button2.backgroundColor = [UIColor whiteColor];
    [_button2 setTitleColor:grayColor forState:UIControlStateNormal];
    [_button2 setTitle:@"订单通知" forState:UIControlStateNormal];
    _button2.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [buttonsView addSubview:_button2];
    [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonsView);
        make.height.equalTo(@50.0f);
    }];
    
    [@[_button1,_button2] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1.0f leadSpacing:0 tailSpacing:0];
    
    
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    CGFloat height =[UIScreen mainScreen].bounds.size.height-kStatusBarAndNavigationBarHeight-50.0f;
    _scrollview = [[MessageScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    _scrollview.delegate = self;
    [self.view addSubview:_scrollview];
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.button1.mas_bottom);
    }];
    
    _scrollview.contentInset = UIEdgeInsetsMake(0, 0, kBottomSafeHeight+49.0f, 0);
    
    // Do any additional setup after loading the view.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)touchButton:(UIButton *)sender{
    [self switchSlide:sender.tag];
}

-(void)switchSlide:(NSUInteger)idx{
    UIColor *yellowColor = [UIColor colorWithRed:244.0f/255.0f green:112.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
    UIColor *grayColor = [UIColor colorWithRed:160.0f/255.0f green:160.0f/255.0f blue:160.0f/255.0f alpha:1.0f];
    if (idx == 0) {
        [_button1 setTitleColor:yellowColor forState:UIControlStateNormal];
        [_button2 setTitleColor:grayColor forState:UIControlStateNormal];
    }else{
        [_button1 setTitleColor:grayColor forState:UIControlStateNormal];
        [_button2 setTitleColor:yellowColor forState:UIControlStateNormal];
    }
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    [_scrollview setContentOffset:CGPointMake(idx*width, 0) animated:YES];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    NSInteger index = scrollView.contentOffset.x/width;
    [self switchSlide:index];
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
