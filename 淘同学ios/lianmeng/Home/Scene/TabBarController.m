//
//  TabBarController.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TabBarController.h"
#import "LMNavigationController.h"
#import "MainScene.h"
#import "MomentScene.h"
#import "NoticeScene.h"
#import "MineScene.h"

#import "UserCenter.h"
#import "WechatLoginScene.h"
#import "LMNavigationController.h"
#import <EasyIOS/EasyIOS.h>

@interface TabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,retain)LMNavigationController *mainNavController;
@property(nonatomic,retain)LMNavigationController *momentNavController;
@property(nonatomic,retain)LMNavigationController *messageNavController;
@property(nonatomic,retain)LMNavigationController *mineNavController;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainNavController = [[LMNavigationController alloc]initWithRootViewController:[[MainScene alloc] init]];
    _momentNavController = [[LMNavigationController alloc]initWithRootViewController:[[MomentScene alloc]init]];
    _messageNavController = [[LMNavigationController alloc]initWithRootViewController:[[NoticeScene alloc] init]];
    _mineNavController = [[LMNavigationController alloc]initWithRootViewController:[[MineScene alloc] init]];
    
    self.viewControllers = [NSArray arrayWithObjects:_mainNavController, _momentNavController,_messageNavController,_mineNavController,nil];
    
    NSDictionary *tabConfig = @{UITabNormalTextColor:[UIColor blackColor],
                                UITabSelectedTextColor:[UIColor redColor],
                                UITabItemsImageArray:@[
                                        @{UITabItemsSelectedImage:@"main-s",
                                          UITabItemsNormalImage:@"main"},
                                        @{UITabItemsSelectedImage:@"moment-s",
                                          UITabItemsNormalImage:@"moment"},
                                        @{UITabItemsSelectedImage:@"message-s",
                                          UITabItemsNormalImage:@"message"},
                                        @{UITabItemsSelectedImage:@"mine-s",
                                          UITabItemsNormalImage:@"mine"}]
                                };
    [self setTabBarItemsAttributes:tabConfig];
    
    NSArray *titles = @[@"首页",@"发圈",@"消息",@"我的"];
    NSUInteger i = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        [item setTitle:[titles objectAtIndex:i]];
        i++;
    }
    self.tabBar.barTintColor = [UIColor whiteColor];
    // self.tabBar.barStyle = UIBarStyleBlack;
    self.tabBar.translucent = NO;
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if([viewController isEqual:_messageNavController] || [viewController isEqual:_mineNavController]){
        if(![[UserCenter sharedInstance] checkLogin]){
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"需要登录" message:@"此操作需要登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                UIViewController *vc = [[LMNavigationController alloc]initWithRootViewController:[[WechatLoginScene alloc]init]];
                [[URLNavigation navigation].currentViewController presentViewController:vc animated:YES completion:nil];
            }]];
            [[URLNavigation navigation].currentViewController presentViewController:alert animated:YES completion:nil];
            return NO;
        }
        return YES;
    }
    return YES;
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
