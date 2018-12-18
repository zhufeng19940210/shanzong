//  SendCircleScene.m
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "SendCircleScene.h"
#import "CircleTableView.h"
@interface SendCircleScene ()
@property(nonatomic,retain)CircleTableView *tableView1;
@end
@implementation SendCircleScene
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView1 = [[CircleTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight-49) style:UITableViewStylePlain];
    [self.view addSubview:_tableView1];
    [_tableView1 startRAC:4];
}
@end
