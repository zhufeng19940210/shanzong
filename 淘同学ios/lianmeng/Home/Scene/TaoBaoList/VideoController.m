//
//  VideoController.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/18.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "VideoController.h"
#import <Masonry/Masonry.h>
#import "Scene+NavBar.h"
#import "NavLeftView.h"
#import <EasyIOS/EasyIOS.h>
#import <PBJVideoPlayer/PBJVideoPlayer.h>

@interface VideoController ()<PBJVideoPlayerControllerDelegate>

@end

@implementation VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];

    PBJVideoPlayerController *videoPlayerController = [[PBJVideoPlayerController alloc] init];
    videoPlayerController.view.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    videoPlayerController.videoPath = _videoPath;
    videoPlayerController.delegate = self;
    [self addChildViewController:videoPlayerController];
    [self.view addSubview:videoPlayerController.view];
    [videoPlayerController didMoveToParentViewController:self];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"返回"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
}

- (void)videoPlayerReady:(PBJVideoPlayerController *)videoPlayer{
    [videoPlayer playFromBeginning];
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
