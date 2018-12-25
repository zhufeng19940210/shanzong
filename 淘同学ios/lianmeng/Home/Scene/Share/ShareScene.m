//
//  ShareScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ShareScene.h"
#import <Masonry/Masonry.h>
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import "ImageShowView.h"
#import "SceneScrollView.h"
#import "ShareDetailView.h"
#import "ShareBottomView.h"
#import "ActionSceneModel.h"
#import "ShareItemInfoRequest.h"
#import "UpdatecountRequest.h"
#import "ShareUrlRequest.h"

#import <UMShare/UMShare.h>

@interface ShareScene ()<ShareDelegate>
@property(nonatomic,retain)SceneScrollView *scrollView;
@property(nonatomic,retain)ImageShowView *imageShowView;
@property(nonatomic,retain)ShareDetailView *detailView;
@property(nonatomic,retain)ShareBottomView *bottomView;
@end

@implementation ShareScene

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *titleBgImage = [[UIImageView alloc]init];
    [titleBgImage setImage:[UIImage imageNamed:@"nav-bg"]];
    [self.view addSubview:titleBgImage];
    
    [titleBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"商品分享"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    _scrollView = [[SceneScrollView alloc]init];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    [_scrollView addContentView];


    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 10;//行间距
    flow.minimumInteritemSpacing = 10;//列间距
    flow.itemSize = CGSizeMake(78.0f, 78.0f);
    flow.sectionInset = UIEdgeInsetsZero;
    
    _imageShowView = [[ImageShowView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    [_scrollView.contentView addSubview:_imageShowView];
    
    [_imageShowView reloadImages:self.mUrlArray];
    
    [_imageShowView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.scrollView.contentView).offset(12.5f);
        make.left.equalTo(self.scrollView.contentView).offset(20.0f);
        make.right.equalTo(self.scrollView.contentView);
        make.height.equalTo(@78.0f);
    }];
    
    _detailView = [[ShareDetailView alloc]init];
    [_scrollView.contentView addSubview:_detailView];
    
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.equalTo(self.scrollView.contentView);
        make.top.equalTo(self.imageShowView.mas_bottom);
    }];
    
    [_detailView reloadData:self.model];
    
    _bottomView = [[ShareBottomView alloc]init];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.scrollView.mas_bottom);
        make.height.equalTo(@(80.0f+kBottomSafeHeight));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)copyText{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _model.itemDesc;
    [DialogUtil showMessage:@"文案已复制！"];
}

-(void)shareTimeLine{
    [self shareImageAndTextToPlatformType:UMSocialPlatformType_WechatTimeLine];
}

-(void)shareWechat{
    [self shareImageAndTextToPlatformType:UMSocialPlatformType_WechatSession];
}

-(void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType{
    [self loadHudInKeyWindow];
    [self showHudIndeterminate:@"数据加载中..."];
    self.model.itemPic = [self.imageShowView getSelectedImage];
    [ShareUrlRequest getShareInfo:@[self.model] callBack:^(NSArray *imageList) {
        [self shareImageAndTextToPlatformType:platformType withImage:imageList[0]];
        [self hideHud];
    }];
}

- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType withImage:(UIImage *)image
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = _model.itemDesc;
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    shareObject.descr = _model.itemDesc;
    shareObject.title = _model.itemTitle;
    [shareObject setShareImage:image];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    @weakify(self);
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        @strongify(self);
        if (error) {
            [DialogUtil showMessage:@"分享失败"];
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            UpdatecountRequest *request = [UpdatecountRequest Request];
            request.wechatInfoId = self.model.itemId;
            [[ActionSceneModel sharedInstance] doRequest:request success:^{
            } error:^{
            }];
            [DialogUtil showMessage:@"分享成功"];
            NSLog(@"response data is %@",data);
        }
    }];
}

-(void)genShareData:(NSString *)itemId platformId:(NSUInteger)platformId{
    ShareItemInfoRequest *request = [ShareItemInfoRequest Request];
    request.platformId = @(platformId);
    request.itemId = itemId;

    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSError *error;
        self.model = [[GoodsModel alloc]initWithDictionary:[request.output objectForKey:@"data"] error:&error];
        [self.detailView reloadData:self.model];
    } error:^{

    }];
}

@end
