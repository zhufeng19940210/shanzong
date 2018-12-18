//  ZFMomentListVC.m
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "ZFMomentListVC.h"
#import "StudentScene.h"
#import "SendCircleScene.h"
#import "OrderMessagScene.h"
#import "ZJScrollPageView.h"
@interface ZFMomentListVC ()<ZJScrollPageViewDelegate>
@property (nonatomic, weak) ZJScrollPageView *scrollPageView;
@end
@implementation ZFMomentListVC
#pragma mark - getter
- (ZJScrollPageView *)scrollPageView
{
    if(_scrollPageView == nil)
    {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showLine = YES;
        style.gradualChangeTitleColor = YES;
        style.contentViewBounces = NO;
        style.animatedContentViewWhenTitleClicked = NO;
        style.autoAdjustTitlesWidth = YES;
        style.scrollLineColor = [UIColor redColor];
        style.selectedTitleColor = [UIColor redColor];
        style.normalTitleColor = RGB(100,100,100);
        style.titleFont = [UIFont systemFontOfSize:16];
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight-49) segmentStyle:style titles:[self.childViewControllers valueForKey:@"title"] parentViewController:self delegate:self withColor:[UIColor whiteColor]];
        [self.view addSubview:scrollPageView];
        _scrollPageView = scrollPageView;
    }
    return _scrollPageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.childViewControllers.count;
}
- (UIViewController <ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = self.childViewControllers[index];
    }
    return childVc;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

@end
