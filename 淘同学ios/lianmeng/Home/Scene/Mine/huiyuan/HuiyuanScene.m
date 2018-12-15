//
//  HuiyuanScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "HuiyuanScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "UpdateRequest.h"
#import "ActionSceneModel.h"
#import "UpdateModel.h"

@interface HuiyuanScene ()
@property(nonatomic,retain)SceneScrollView *scrollView;
@property(nonatomic,retain)UIImageView *updateTips;
@property(nonatomic,retain)UpdateModel *model;
@end

@implementation HuiyuanScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scrollView = [[SceneScrollView alloc]init];
    [self.view addSubview:_scrollView];
    [_scrollView addContentView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self.view);
    }];
    
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"会员权益"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];


    _updateTips = [[UIImageView alloc]init];
    [self.scrollView.contentView addSubview:_updateTips];

    [_updateTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView.contentView);
    }];
    [self reloadData];
}

-(void)reloadData{
    UpdateRequest *request = [UpdateRequest Request];
    
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSError *error;
        self.model = [[UpdateModel alloc]initWithDictionary:request.output[@"data"] error:&error];
        [self.updateTips sd_setImageWithURL:[NSURL URLWithString:self.model.picUrl]];
    } error:^{
        
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
