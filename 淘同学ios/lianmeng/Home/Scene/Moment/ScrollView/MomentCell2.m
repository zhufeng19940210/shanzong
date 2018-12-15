//
//  MomentCell2.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/1.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MomentCell2.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "MRImgShowView.h"
#import "ShareUrlRequest.h"
#import "ActionSceneModel.h"
#import "ShareDataModel.h"
#import "UpdatecountRequest.h"
#import "UserCenter.h"
#import "WechatLoginScene.h"
#import "LMNavigationController.h"

@interface MomentCell2()
@property(nonatomic,retain)UIImageView *avatarView;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *contentLabel;
@property(nonatomic,retain)UIView *imageWrapView;
@property(nonatomic,retain)UIImageView *qianIcon;
@property(nonatomic,retain)UILabel *qianLabel;
@property(nonatomic,retain)UIButton *shareBtn;

@property(nonatomic,retain)UIView *splitView;
@property(nonatomic,retain)MomentModel *dataModel;

@end
@implementation MomentCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _avatarView = [[UIImageView alloc]init];
        _avatarView.backgroundColor = [UIColor redColor];
        _avatarView.clipsToBounds = YES;
        _avatarView.layer.cornerRadius = 15.0f;
        [self.contentView addSubview:_avatarView];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14.0f];
        _nameLabel.textColor = [UIColor colorWithRed:2.0f/255.0f green:2.0f/255.0f blue:2.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.textColor = [UIColor colorWithRed:154.0f/255.0f green:154.0f/255.0f blue:154.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_timeLabel];
        
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:15.0f];
        _contentLabel.textColor =[UIColor colorWithRed:90.0f/255.0f green:90.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_contentLabel];
        
        _imageWrapView = [[UIView alloc]init];
        [self.contentView addSubview:_imageWrapView];
        
        
        _qianIcon = [[UIImageView alloc]init];
        _qianIcon.image = [UIImage imageNamed:@"qian"];
        [self.contentView addSubview:_qianIcon];
        
        _qianLabel = [[UILabel alloc]init];
        _qianLabel.font = [UIFont systemFontOfSize:11.0f];
        _qianLabel.textColor =[UIColor colorWithString:@"#f4341d"];
        _qianLabel.text = @"预计赚￥0.00";
        [self.contentView addSubview:_qianLabel];
        
        _shareBtn = [[UIButton alloc]init];
        [_shareBtn setImage:[UIImage imageNamed:@"yijianfenxiang"] forState:UIControlStateNormal];
        [self.contentView addSubview:_shareBtn];
        
        [_shareBtn addTarget:self action:@selector(openShare) forControlEvents:UIControlEventTouchUpInside];
        
        _splitView = [[UIView alloc]init];
        _splitView.backgroundColor = [UIColor colorWithRed:0.973f green:0.973f blue:0.973f alpha:1.0f];
        [self.contentView addSubview:_splitView];
        
        
        [self loadAutoLayout];
        
    }
    return self;
}

-(void)loadAutoLayout{
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(11.0f);
        make.left.equalTo(self.contentView).offset(15.0f);
        make.width.height.equalTo(@30.0f);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).offset(10.0f);
        make.top.equalTo(self.avatarView);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(4.0f);
    }];
    
//    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@24.0f);
//        make.right.equalTo(self.contentView).offset(-25.0f);
//        make.centerY.equalTo(self.avatarView);
//    }];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-25.0f);
        make.top.equalTo(self.avatarView.mas_bottom).offset(11.0f);
    }];
    
    
    
    [_imageWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.right.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(8.0f);
       
        make.height.equalTo(@0);
    }];
    
    [_qianIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.imageWrapView);
        make.top.equalTo(self.imageWrapView.mas_bottom).offset(15.0f);
         make.bottom.equalTo(self.contentView).offset(-30.0f);
    }];
    
    [_qianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.qianIcon);
        make.left.equalTo(self.qianIcon.mas_right).offset(5.0f);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(self.qianIcon);
        make.right.equalTo(self.contentLabel);
    }];
    
    [_splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@10.0f);
    }];
    
}

-(void)openShare{
    
    if(![[UserCenter sharedInstance] checkLogin]){
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"需要登录" message:@"此操作需要登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIViewController *vc = [[LMNavigationController alloc]initWithRootViewController:[[WechatLoginScene alloc]init]];
            [[URLNavigation navigation].currentViewController presentViewController:vc animated:YES completion:nil];
        }]];
        [[URLNavigation navigation].currentViewController presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    UIViewController *vc = [URLNavigation navigation].currentViewController;
    [vc loadHudInKeyWindow];
    
    [vc showHudIndeterminate:@"数据加载中..."];
    
    ShareUrlRequest *req = [ShareUrlRequest Request];
    req.wechatInfoId = _dataModel.id;
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:req success:^{
        @strongify(self);
        NSError *error;
        ShareDataModel *model = [[ShareDataModel alloc]initWithDictionary:[req.output objectForKey:@"data"] error:&error];
        
        NSArray *imageList = [model.item map:^UIImage*(ShareDataItemModel *item) {
            return [item genImage];
        }];
        
        [vc hideHud];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.dataModel.goodsDesc;
        [DialogUtil showMessage:@"文案已复制！"];
        [self shareItems:imageList wechatInfoId:self.dataModel.id];
        
    } error:^{
        [vc hideHudFailed:@"分享数据获取失败"];
    }];
    
}


-(void)setModel:(MomentModel *)model{
    _dataModel = model;
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    _nameLabel.text = model.title;
    _timeLabel.text = [TimeTool formatTime:model.createTime/1000 formatWith:@"MM-dd HH:mm"];
    _contentLabel.text = model.goodsDesc;
    if (model.flMoney) {
        CGFloat money = 0;
        for (NSNumber *flmoney in model.flMoney) {
            money += flmoney.floatValue;
        }
        _qianLabel.text = [NSString stringWithFormat:@"预计赚￥%.2f",money];
    }
    
    NSArray *imageList = model.pictures;
    [self setImageList:imageList];
}

-(void)setImageList:(NSArray *)imageList{
    
    for (UIView *subView  in _imageWrapView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (imageList.count >0) {
        for (NSString *imageUrl  in imageList) {
            UIImageView *image = [[UIImageView alloc]init];
            image.userInteractionEnabled = YES;
            [image sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            [_imageWrapView addSubview:image];
            
            UITapGestureRecognizer *recognizer = [UITapGestureRecognizer rac_recognizer];
            [image addGestureRecognizer:recognizer];
            [[recognizer rac_signal] subscribeNext:^(id x) {
                [self creatImgShow:imageList index:[imageList indexOfObject:imageUrl]];
            }];
        }
        
        NSArray *list = _imageWrapView.subviews;
        CGFloat padding = 9.0f;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 80.0f - 18.0f)/3;
        CGFloat height = [self gridLayoutWithNumPerRow:list.count == 4?2:3 width:width height:width padding:padding views:list];
        
        [_imageWrapView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
    }
}


- (void)shareItems:(NSArray *)list wechatInfoId:(NSNumber *)wechatInfoId
{
    
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:list applicationActivities:nil];
    activityController.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            UpdatecountRequest *request = [UpdatecountRequest Request];
            request.wechatInfoId = wechatInfoId;
            [[ActionSceneModel sharedInstance] doRequest:request success:^{
                NSLog(@"shareSuccess");
            } error:^{
                NSLog(@"shareError");
            }];
            [DialogUtil showMessage:@"分享成功"];
        }
    };
    
    [[URLNavigation navigation].currentNavigationViewController presentViewController:activityController animated:YES completion:nil];
}

/**
 九宫格布局（不限于九宫格，可以是N个格子），每个格子给定高（cellHeight）宽（cellWidth），
 每行格子数量（numPerRow），格子总数量（totalNum），格子与边界距离（viewPadding），格
 子之间的距离（viewPaddingCell）。
 @param numPerRow       每行格子数量
 @param padding     格子与边界距离
 @param width   格子宽
 @param height  格子高
 */
- (CGFloat)gridLayoutWithNumPerRow:(NSInteger)numPerRow
                             width:(NSInteger)width
                            height:(NSInteger)height
                           padding:(CGFloat)padding
                             views:(NSArray *)views
{
    for (int i=0; i<views.count; i++) {
        UIView * view = views[i];
        CGFloat x = (i%numPerRow)*(padding + width);
        CGFloat y = (i/numPerRow)*(padding + height);
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.superview).offset(x);
            make.top.equalTo(view.superview).offset(y);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
    }
    return (views.count - 1)/numPerRow*(padding + height) + height;
}

- (void)creatImgShow:(NSArray *)data index:(NSUInteger)index{
    UIView *blackView = [[UIView alloc]init];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.0f;
    
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    [vc.view addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(blackView.superview);
    }];
    
    UITapGestureRecognizer *recognizer = [UITapGestureRecognizer rac_recognizer];
    [blackView addGestureRecognizer:recognizer];
    [[recognizer rac_signal] subscribeNext:^(UITapGestureRecognizer *sender){
        [UIView animateWithDuration:0.5f animations:^{
            blackView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [blackView removeGestureRecognizer:recognizer];
            [blackView removeFromSuperview];
        }];
    }];
    
    MRImgShowWrapView *imgShowView = [[MRImgShowWrapView alloc]
                                      initWithFrame:vc.view.bounds
                                      withSourceData:data
                                      withIndex:index];
    // 解决兼容
    [imgShowView.scrollView requireDoubleGestureRecognizer:[[blackView gestureRecognizers] lastObject]];
    [blackView addSubview:imgShowView];
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = data.count;
    pageControl.currentPage = 0;
    [blackView addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(pageControl.superview).offset(-30.0f);
        make.height.equalTo(@30.0f);
        make.centerX.equalTo(pageControl.superview);
    }];
    
    [RACObserve(imgShowView.scrollView, curIndex)
     subscribeNext:^(NSNumber* index) {
         pageControl.currentPage = index.integerValue;
     }];
    
    [UIView animateWithDuration:0.5f animations:^{
        blackView.alpha = 1.0f;
    }];
}
@end
