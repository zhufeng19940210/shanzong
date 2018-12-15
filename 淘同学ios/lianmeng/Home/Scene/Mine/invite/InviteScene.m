//
//  InviteScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/24.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "InviteScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
#import "PosterRequest.h"
#import "ActionSceneModel.h"

@interface InviteScene ()
@property(nonatomic,retain)SceneScrollView *scrollView;
@property(nonatomic,retain)UIImageView *imageView;
@end

@implementation InviteScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithString:@"#EEEDEE"];
    
    UIImageView *titleBgImage = [[UIImageView alloc]init];
    [titleBgImage setImage:[UIImage imageNamed:@"nav-bg"]];
    [self.view addSubview:titleBgImage];
    
    [titleBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"邀请"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    _scrollView = [[SceneScrollView alloc]init];
    [self.view addSubview:_scrollView];
    [_scrollView addContentView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.textColor = [UIColor colorWithString:@"rgb(204,204,204)"];
    tipLabel.font = [UIFont fontWithName:MediumFont size:12.0f];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"分享专属海报，新用户可免邀请码注册，关系自动绑定";
    [self.scrollView.contentView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.scrollView.contentView).offset(20.0f);
        make.centerX.equalTo(self.scrollView.contentView);
    }];
    
    _imageView = [[UIImageView alloc]init];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset((ScreenW - 265.0f)/2);
         make.right.equalTo(self.view.mas_right).offset(-(ScreenW - 265.0f)/2);
        make.top.equalTo(tipLabel.mas_bottom).offset(20.0f);
        make.height.equalTo(@470.0f);
        make.width.equalTo(@265.0f);
    }];
    
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setImage:[UIImage imageNamed:@"share-Image"] forState:UIControlStateNormal];
    [self.scrollView.contentView addSubview:btn1];
    [btn1 addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setImage:[UIImage imageNamed:@"share-words"] forState:UIControlStateNormal];
    [self.scrollView.contentView addSubview:btn2];
    [btn2 addTarget:self action:@selector(copyRegister) forControlEvents:UIControlEventTouchUpInside];
    
    [@[btn1,btn2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(30.0f);
        make.bottom.equalTo(self.scrollView.contentView);
    }];
    
    [@[btn1,btn2] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10.0F leadSpacing:10.0F tailSpacing:10.0f];
    
    PosterRequest *req = [PosterRequest Request];
    [[ActionSceneModel sharedInstance] doRequest:req success:^{
        NSString *imageUrl = [req.output objectForKey:@"data"];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    } error:^{
        
    }];

}


-(void)shareImage{
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:@[self.imageView.image] applicationActivities:nil];
    [[URLNavigation navigation].currentNavigationViewController presentViewController:activityController animated:YES completion:nil];
}

-(void)copyRegister{
    if (self.inviteCode) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.inviteCode;
        [DialogUtil showMessage:@"邀请码已复制!"];
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
