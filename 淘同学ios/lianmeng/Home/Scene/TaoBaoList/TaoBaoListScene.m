//
//  TaoBaoListScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/13.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TaoBaoListScene.h"
#import "TaoBaoNavView.h"
#import <Masonry/Masonry.h>
#import "TabView.h"
#import "TaoBaoScrollView.h"
#import "HoverView.h"
#import "ActionSceneModel.h"
#import "PlatBannerRequest.h"
#import "DetailScene.h"
#import "DetailScene2.h"
@interface TaoBaoListScene ()<TaoBaoViewScrolling>
@property(nonatomic,retain)TaoBaoNavView *navView;
@property(nonatomic,retain)UIImageView *bannerImageView;
@property(nonatomic,retain)TabView *tabView;
@property(nonatomic,retain)TaoBaoScrollView *scrollView;
@property(nonatomic,retain)HoverView *hoverView;
@property(nonatomic,copy)NSString *bannerId;
@end
@implementation TaoBaoListScene
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    _bannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, ScreenW, ScreenW *133.0f/375.0f)];
    _bannerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"banner%ld",(long)_platformId]];
    [self.view addSubview:_bannerImageView];
    self.bannerImageView.userInteractionEnabled = YES;
    [self.bannerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBanner)]];
    
    _tabView = [[TabView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight+_bannerImageView.frame.size.height, ScreenW, 32.5f)
                                  platformId:self.platformId];
    [self.view addSubview:_tabView];
    [_tabView.xialaButton addTarget:self action:@selector(showHoverView) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat top = kStatusBarAndNavigationBarHeight+_bannerImageView.frame.size.height+_tabView.frame.size.height;
    _scrollView = [[TaoBaoScrollView alloc]initWithFrame:CGRectMake(0,top , ScreenW, ScreenH - top)
                                            subViewCount:17
                                              platformId:_platformId
                                                delegate:self];
    [self.view addSubview:_scrollView];
    
    _scrollView.tabDelegate = _tabView;
    _tabView.delegate = _scrollView;
    
    _navView = [[TaoBaoNavView alloc]initWithTitle:_platformId == 1?@"淘宝":@"京东"];
    [self.view addSubview:_navView];
    
    [_navView.blackBack addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    _hoverView = [[HoverView alloc]initWithFrame:CGRectMake(0, _tabView.frame.origin.y, _scrollView.size.width, _scrollView.size.height + _tabView.size.height) platformId:self.platformId];
    _hoverView.tabDelegate = _tabView;
    _hoverView.hidden = YES;
    
    [self.view addSubview:_hoverView];
    
    [self getBannerImage];
}

-(void)touchBanner{
    if (self.bannerId) {
        if (self.platformId ==1) {
            DetailScene2 *scene = [[DetailScene2 alloc]init];
            scene.itemId = self.bannerId;
            [self.navigationController pushViewController:scene animated:YES];
        }else{
            DetailScene *scene = [[DetailScene alloc]init];
            scene.itemId = self.bannerId;
            scene.platformId = self.platformId;
            [self.navigationController pushViewController:scene animated:YES];
        }
    }
}

-(void)getBannerImage{
    @weakify(self);
    if (_platformId == 1) {
        TaoBaoPlatBannerRequest *req = [TaoBaoPlatBannerRequest Request];
        
        [[ActionSceneModel sharedInstance] doRequest:req success:^{
            @strongify(self);
            NSDictionary *dict = [req.output objectForKey:@"data"];
            NSString *taobaoUrl = dict[@"taobaoUrl"];
            if (taobaoUrl) {
                self.bannerId = dict[@"taobaoItemId"];
                [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:taobaoUrl]];
            }
        } error:^{
            
        }];
    }else{
        JDPlatBannerRequest *req = [JDPlatBannerRequest Request];
        
        [[ActionSceneModel sharedInstance] doRequest:req success:^{
            @strongify(self);
            NSDictionary *dict = [req.output objectForKey:@"data"];
            NSString *jdUrl = dict[@"jdUrl"];
            if(jdUrl){
                self.bannerId = dict[@"jdItemId"];
                [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:jdUrl]];
            }
        } error:^{
            
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showHoverView{
    _hoverView.hidden = !_hoverView.hidden;
    [_hoverView showSelectedItem:_tabView.selected];
}

- (void)viewIsScrolling:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    CGFloat offsetHeight = _bannerImageView.frame.size.height;
    if (y>=0 && y<=offsetHeight) {
        y = scrollView.contentOffset.y;
    }else if(y<0){
        y = 0;
    }else{
        y =offsetHeight;
    }
    _bannerImageView.frame = CGRectMake(0, kStatusBarAndNavigationBarHeight-y, _bannerImageView.frame.size.width, _bannerImageView.frame.size.height);
    _tabView.frame = CGRectMake(0, kStatusBarAndNavigationBarHeight+_bannerImageView.frame.size.height-y,
                                _tabView.frame.size.width, _tabView.frame.size.height);
    CGFloat top = kStatusBarAndNavigationBarHeight+_bannerImageView.frame.size.height+_tabView.frame.size.height;
    _scrollView.frame = CGRectMake(0, top-y, _scrollView.frame.size.width, ScreenH - top + y);
    [_scrollView.subviews each:^(TaoBaoTableView* obj) {
        obj.frame =  CGRectMake(obj.frame.origin.x, obj.frame.origin.y, obj.frame.size.width, ScreenH - top + y);
    }];
}
@end
