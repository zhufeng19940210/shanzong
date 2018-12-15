//
//  MineScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MineScene.h"
#import "Scene+NavBar.h"
#import "MineHeaderView.h"
#import <Masonry/Masonry.h>
#import "MineItemView.h"
#import "MineCellView.h"
#import "FavScene.h"
#import "RankScene.h"
#import "ProfitScene.h"
#import "OrderScene.h"
#import "FansScene.h"
#import "InviteScene.h"
#import "UserCenter.h"
#import "WechatLoginScene.h"
#import "UserCenterRequest.h"
#import "ActionSceneModel.h"
#import "LMNavigationController.h"
#import "LinkWebScene.h"
#import "AboutUsScene.h"
#import "QRReaderViewController.h"
#import "CardCodeRequest.h"
#import <EasyIOS/EasyIOS.h>
@interface MineScene ()<QRReaderViewControllerDelegate>
@property(nonatomic,retain)SceneScrollView *scrollView;
@property(nonatomic,retain)LoginModel *model;
@property(nonatomic,retain)MineHeaderView *headerView;
@end

@implementation MineScene

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
    
    _scrollView = [[SceneScrollView alloc]init];
    [self.view addSubview:_scrollView];
    [_scrollView addContentView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _headerView = [[MineHeaderView alloc]init];
    [self.scrollView.contentView addSubview:_headerView];
    [_headerView setData:[UserCenter sharedInstance].loginModel];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.scrollView.contentView);
        make.height.equalTo(@(238.5+kStatusBarAndNavigationBarHeight));
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self nav_showBarButton:NAV_RIGHT button:button];
    
    
    UIView *item1View = [[UIView alloc]init];
    item1View.backgroundColor = [UIColor whiteColor];
    [self.scrollView.contentView addSubview:item1View];
    
    [item1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@90.0f);
        make.left.right.equalTo(self.scrollView.contentView);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    MineItemView *item1 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"shouyi"] title:@"收益"];
    item1.tag = 1;
    [item1View addSubview:item1];
    MineItemView *item2 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"dingdan"] title:@"订单"];
    item2.tag = 2;
    [item1View addSubview:item2];
    MineItemView *item3 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"fensi"] title:@"粉丝"];
     item3.tag = 3;
    [item1View addSubview:item3];
    MineItemView *item4 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"yaoqing"] title:@"邀请"];
    item4.tag = 4;
    [item1View addSubview:item4];
//    MineItemView *item5 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"shouyipaihang"] title:@"收益排行"];
//    item5.tag = 5;
//    [item1View addSubview:item5];
    
    [@[item1,item2,item3,item4] mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.bottom.equalTo(item1View);
    }];
    [@[item1,item2,item3,item4] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    
    UIView *item2View = [[UIView alloc]init];
    item2View.backgroundColor = [UIColor whiteColor];
    [self.scrollView.contentView addSubview:item2View];
    
    [item2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@90.0f);
        make.left.right.equalTo(self.scrollView.contentView);
        make.top.equalTo(item1View.mas_bottom).offset(10.0f);
    }];
    
    MineItemView *item6 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"xsgl"] title:@"新手攻略"];
    item6.tag = 6;
    [item2View addSubview:item6];
    MineItemView *item7 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"wdsc"] title:@"我的收藏"];
    item7.tag = 7;
    [item2View addSubview:item7];
    MineItemView *item8 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"cjwt"] title:@"常见问题"];
    item8.tag = 8;
    [item2View addSubview:item8];
    MineItemView *item9 = [[MineItemView alloc]initWithImage:[UIImage imageNamed:@"lxkf"] title:@"联系客服"];
    item9.tag = 9;
    [item2View addSubview:item9];
    
    [@[item6,item7,item8,item9] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(item2View);
    }];
    [@[item6,item7,item8,item9] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    
    MineCellView *cell1 = [[MineCellView alloc]initWithImage:[UIImage imageNamed:@"guanfgg"] title:@"官方公告"];
    cell1.tag = 10;
    [self.scrollView.contentView addSubview:cell1];
    MineCellView *cell2 = [[MineCellView alloc]initWithImage:[UIImage imageNamed:@"yijianfankui"] title:@"意见反馈"];
    cell2.tag = 11;
    [self.scrollView.contentView addSubview:cell2];
    MineCellView *cell3 = [[MineCellView alloc]initWithImage:[UIImage imageNamed:@"guanyuwomen"] title:@"设置"];
    cell3.tag = 12;
    [self.scrollView.contentView addSubview:cell3];
    
    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2View.mas_bottom).offset(10.0f);
        make.left.right.equalTo(self.scrollView.contentView);
        make.height.equalTo(@44.0f);
    }];
    [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell1.mas_bottom);
        make.left.right.equalTo(self.scrollView.contentView);
        make.height.equalTo(@44.0f);
    }];
    [cell3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell2.mas_bottom);
        make.left.right.equalTo(self.scrollView.contentView);
        make.height.equalTo(@44.0f);
        make.bottom.equalTo(self.scrollView.contentView);
    }];
    
    
    [item1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [item2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [item3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [item4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
//    [item5 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [item6 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [item7 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [item8 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [item9 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [cell1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [cell2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    [cell3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchButtons:)]];
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
}

-(void)reloadData{
    UserCenterRequest *req = [UserCenterRequest Request];
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:req success:^{
        @strongify(self);
        NSError *error;
        LoginModel *model = [[LoginModel alloc]initWithDictionary:req.output[@"data"] error:&error];
        self.model = model;
        [[UserCenter sharedInstance] saveUserData:model];
        [self.headerView setData:model];
    } error:^{
        
    }];
}

-(void)rightButtonTouch{
  QRReaderViewController *vc = [[QRReaderViewController alloc]init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)didFinishedReadingQR:(NSString *)string{
    [self dismissViewControllerAnimated:YES completion:nil];
    CardCodeRequest *req = [CardCodeRequest Request];
    req.cardCode = string;
    [[ActionSceneModel sharedInstance] doRequest:req success:^{
        [DialogUtil showMessage:req.message];
    } error:^{
        [DialogUtil showMessage:req.message];
    }];
}

-(void)touchButtons:(UITapGestureRecognizer *)gesture{
    NSUInteger index = gesture.view.tag;
    switch (index) {
        case 1:
            [self.navigationController pushViewController:[[ProfitScene alloc]init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[OrderScene alloc]init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[FansScene alloc]init] animated:YES];
            break;
        case 4:{
                InviteScene *scene = [[InviteScene alloc]init];
                scene.inviteCode = self.model.inviteCode;
                [self.navigationController pushViewController:scene animated:YES];
                break;
            }
        case 5:
             [self.navigationController pushViewController:[[RankScene alloc]init] animated:YES];
            break;
        case 6:
            {
                LinkWebScene *web = [[LinkWebScene alloc]init];
                web.url = [NSString stringWithFormat:@"%@/mobile/h5/toTutorial",URLHOST];
                web.title = @"新手教程";
                [self.navigationController pushViewController:web animated:YES];
                break;
            }
        case 7:
            [self.navigationController pushViewController:[[FavScene alloc]init] animated:YES];
            break;
        case 8:
            {
                LinkWebScene *web = [[LinkWebScene alloc]init];
                web.url = [NSString stringWithFormat:@"%@/mobile/h5/toAnswer",URLHOST];
                web.title = @"常见问题";
                [self.navigationController pushViewController:web animated:YES];
                break;
            }
        case 9:
            {
                LinkWebScene *web = [[LinkWebScene alloc]init];
                web.url = [NSString stringWithFormat:@"%@/mobile/h5/toRobot",URLHOST];
                web.title = @"联系客服";
                [self.navigationController pushViewController:web animated:YES];
                break;
            }
        case 10:{
                LinkWebScene *web = [[LinkWebScene alloc]init];
                web.url = [NSString stringWithFormat:@"%@/mobile/officeNotice/officialMessage",URLHOST];
                web.title = @"官方公告";
                [self.navigationController pushViewController:web animated:YES];
                break;
            }
        case 11:
            {
                LinkWebScene *web = [[LinkWebScene alloc]init];
                web.url = [NSString stringWithFormat:@"%@/mobile/feedback/%ld",URLHOST,(long)[UserCenter sharedInstance].loginModel.userId];
                web.title = @"意见反馈";
                [self.navigationController pushViewController:web animated:YES];
                break;
            }
        case 12:
            {
                AboutUsScene *web = [[AboutUsScene alloc]init];
                [self.navigationController pushViewController:web animated:YES];
                break;
            }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
