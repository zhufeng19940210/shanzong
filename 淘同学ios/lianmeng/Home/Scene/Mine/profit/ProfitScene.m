//
//  ProfitScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ProfitScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import "ProfitHeaderView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "ProfitContenView.h"
#import "UserCashRequest.h"
#import "ActionSceneModel.h"
#import "ProfitModel.h"

@interface ProfitScene ()<ProfitHeaderViewDelegate>
@property(nonatomic,retain)ProfitHeaderView *headerView;
@property(nonatomic,retain)SceneScrollView *scrollView;
@property(nonatomic,retain)ProfitContenView *contentView;
@end


@implementation ProfitScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    _scrollView = [[SceneScrollView alloc]init];
    [self addSubView:_scrollView extend:EXTEND_NONE];
    [_scrollView addContentView];

    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"收益"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    _headerView = [[ProfitHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, kStatusBarAndNavigationBarHeight + 132.0f)];
    _headerView.delegate = self;
    [_scrollView.contentView addSubview:_headerView];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.top.equalTo(self.scrollView.contentView);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight + 132.0f));
    }];
    
    _contentView = [[ProfitContenView alloc]init];
    [_scrollView.contentView addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.scrollView.contentView);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    [self reloadData:1];
}

-(void)reloadData:(NSUInteger) type{
    UserCashRequest *request = [UserCashRequest  Request];
    request.type = @(type);
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSError *error;
        ProfitModel *model = [[ProfitModel alloc]initWithDictionary:request.output[@"data"] error:&error];
        [self.contentView reloadData:model];
        [self.headerView reloadData:model.userSumCash];
    } error:^{
        
    }];
}


-(void)selectIndex:(NSUInteger)index{
    [self reloadData:index];
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
