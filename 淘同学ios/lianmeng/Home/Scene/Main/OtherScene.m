//  OtherScene.m
//  lianmeng
//  Created by zhufeng on 2018/12/15.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "OtherScene.h"
#import "TaoBaoTableView.h"
@interface OtherScene ()
@property (nonatomic,strong)TaoBaoTableView *tableview;
@end
@implementation OtherScene
- (void)viewDidLoad {
    [super viewDidLoad];
    TaoBaoTableView *tableView = [[TaoBaoTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight-100) style:UITableViewStylePlain];
    self.tableview = tableView;
    tableView.sceneModel.platformId = 1;
    [self.view addSubview:tableView];
    [tableView startRAC:[self.cid intValue] withMain:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
