//  StudentScene.m
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "StudentScene.h"
#import "MomentTableView.h"
@interface StudentScene ()
@property(nonatomic,retain)MomentTableView *tableView1;
@end
@implementation StudentScene
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView1 = [[MomentTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight-49) style:UITableViewStylePlain];
    [self.view addSubview:_tableView1];
    [_tableView1 startRAC:1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
