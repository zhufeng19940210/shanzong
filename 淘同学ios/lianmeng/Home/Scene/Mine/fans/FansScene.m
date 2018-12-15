//
//  FansScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/24.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FansScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <Masonry/Masonry.h>
#import "RecommendView.h"
#import <EasyIOS/EasyIOS.h>
#import "FansSummaryView.h"
#import "FansListScene.h"
#import "UserFansNumRequest.h"
#import "ActionSceneModel.h"
#import "UserFansNumModel.h"

@interface FansScene ()
@property(nonatomic,retain)RecommendView *recommendView;
@property(nonatomic,retain)FansSummaryView *summaryView;;

@property(nonatomic,retain)SceneScrollView *scrollView;
@end

@implementation FansScene

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
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"粉丝"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    _scrollView = [[SceneScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor colorWithString:@"rgb(238,238,238)"];
    [self.view addSubview:_scrollView];
    [_scrollView addContentView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
    _recommendView = [[RecommendView alloc]init];
    _recommendView.layer.cornerRadius = 10.0f;
        _recommendView.hidden = YES;
    [self.scrollView.contentView addSubview:_recommendView];
    [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView.contentView).offset(15.0f);
        make.right.equalTo(self.scrollView.contentView).offset(-15.0f);
        make.height.equalTo(@95.0f);
    }];

    _summaryView = [[FansSummaryView alloc]init];
    _summaryView.layer.cornerRadius = 10.0f;
    [self.scrollView addSubview:_summaryView];

    [self.summaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.contentView).offset(15.0f);
        make.left.equalTo(self.scrollView.contentView).offset(15.0f);
        make.right.equalTo(self.scrollView.contentView).offset(-15.0f);
        make.height.equalTo(@300.0f);
        make.bottom.equalTo(self.scrollView.contentView);
    }];

    [self reloadData];
}

-(void)reloadData{
    UserFansNumRequest *request = [UserFansNumRequest Request];
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSError *error;
        UserFansNumModel *model = [[UserFansNumModel alloc]initWithDictionary:request.output[@"data"] error:&error];
        if (model) {
//            if(model.username && model.username.length > 0){
                self.recommendView.hidden = NO;
                [self.summaryView reloadData:model];
                [self.recommendView reloadData:model];
                [self.recommendView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.equalTo(self.scrollView.contentView).offset(15.0f);
                    make.right.equalTo(self.scrollView.contentView).offset(-15.0f);
                    make.height.equalTo(@95.0f);
                }];
                [self.summaryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.recommendView.mas_bottom).offset(15.0f);
                    make.left.equalTo(self.scrollView.contentView).offset(15.0f);
                    make.right.equalTo(self.scrollView.contentView).offset(-15.0f);
                    make.height.equalTo(@300.0f);
                    make.bottom.equalTo(self.scrollView.contentView);
                }];
//            }else{
//                self.recommendView.hidden = YES;
//                [self.summaryView reloadData:model];
//            }
            
        }
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
