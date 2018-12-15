//
//  LMNavigationController.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "LMNavigationController.h"

@interface LMNavigationController ()

@end

@implementation LMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UIViewController *vc = self.visibleViewController;
    if(self.childViewControllers.count == 1){
        vc.hidesBottomBarWhenPushed = YES;
        [super pushViewController:viewController animated:animated];
        vc.hidesBottomBarWhenPushed = NO;
    }else{
        vc.hidesBottomBarWhenPushed = YES;
        [super pushViewController:viewController animated:animated];
    }
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
