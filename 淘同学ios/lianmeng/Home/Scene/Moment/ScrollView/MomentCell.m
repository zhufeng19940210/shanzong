//
//  MomentCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/3.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MomentCell.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "MRImgShowView.h"
#import "ShareScene.h"
#import "DetailScene.h"
#import "ActionSceneModel.h"
#import "ShareUrlRequest.h"
#import "ShareDataModel.h"
#import "UpdatecountRequest.h"

#import <UMShare/UMShare.h>

#import "UserCenter.h"
#import "LMNavigationController.h"
#import "WechatLoginScene.h"



@interface ShareButton : UIView
@property(nonatomic,retain)UILabel *shareLabel;
@end

@implementation ShareButton
-(instancetype)init{
    self = [super init];
    if (self) {
        
        UIColor * red = [UIColor colorWithRed:242.0f/255.0f green:74.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
        self.layer.borderColor = red.CGColor;
        self.layer.borderWidth = 1.0f;
        
        UIImageView *image = [[UIImageView alloc]init];
        [image setImage:[UIImage imageNamed:@"shareIco"]];
        [self addSubview:image];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self);
            make.left.equalTo(self).offset(12.0f);
        }];
        
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.font = [UIFont systemFontOfSize:12.0f];
        _shareLabel.textColor = red;
        _shareLabel.text = @"0";
        [self addSubview:_shareLabel];
        
        [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(image.mas_right).offset(5.0f);
            make.right.equalTo(self).offset(-12.0f);
        }];
        
       
    }
    return self;
}
@end

@interface MomentCell()
@property(nonatomic,retain)UIImageView *avatarView;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)ShareButton *shareButton;
@property(nonatomic,retain)UILabel *contentLabel;
@property(nonatomic,retain)UIView *imageWrapView;
@property(nonatomic,retain)UIView *splitView;

@property(nonatomic,retain)MomentModel *dataModel;
@end

@implementation MomentCell

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
        
        
        _shareButton = [[ShareButton alloc]init];
        _shareButton.layer.cornerRadius = 12.0f;
        
        [self.contentView addSubview:_shareButton];

        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:15.0f];
        _contentLabel.textColor =[UIColor colorWithRed:90.0f/255.0f green:90.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_contentLabel];
        
        _imageWrapView = [[UIView alloc]init];
        [self.contentView addSubview:_imageWrapView];
        
        
        _splitView = [[UIView alloc]init];
        _splitView.backgroundColor = [UIColor colorWithRed:0.973f green:0.973f blue:0.973f alpha:1.0f];
        [self.contentView addSubview:_splitView];
        
        
        [self loadAutoLayout];
        
        [_shareButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openShare)]];
        

    }
    return self;
}

-(void)loadAutoLayout{
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(11.0f);
        make.left.equalTo(self.contentView).offset(25.0f);
        make.width.height.equalTo(@30.0f);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).offset(10.0f);
        make.top.equalTo(self.avatarView);
        make.width.equalTo(@180.0f);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(4.0f);
    }];
    
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24.0f);
        make.right.equalTo(self.contentView).offset(-25.0f);
        make.centerY.equalTo(self.avatarView);
    }];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView);
        make.right.equalTo(self.shareButton);
        make.top.equalTo(self.avatarView.mas_bottom).offset(11.0f);
    }];
    

    
    [_imageWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.right.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(8.0f);
        make.bottom.equalTo(self.contentView).offset(-20.0f);
        make.height.equalTo(@0);
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
    if (model.shareCount) {
        _shareButton.shareLabel.text = [NSString stringWithFormat:@"%ld",(long)model.shareCount.integerValue];
    }
    
    NSArray *imageList = model.pictures;
    [self setImageList:imageList money:model.flMoney items:model.itemId platformId:model.platformId];
}

-(void)setImageList:(NSArray *)imageList money:(NSArray *)money items:(NSArray *)itemIds platformId:(NSUInteger)platformId {
    
    for (UIView *subView  in _imageWrapView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (imageList.count >0) {
        for (NSString *imageUrl  in imageList) {
            UIImageView *image = [[UIImageView alloc]init];
            image.userInteractionEnabled = YES;
            [image sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            [_imageWrapView addSubview:image];
        
            NSUInteger idx = [imageList indexOfObject:imageUrl];
            NSNumber *m = [money safeObjectAtIndex:idx];
            
            if (m.floatValue > 0) {
                UIImageView *kuang = [[UIImageView alloc]init];
                kuang.image = [UIImage imageNamed:@"jiagekuang"];
                [image addSubview:kuang];
                [kuang mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(image.mas_right);
                    make.bottom.equalTo(image.mas_bottom);
                }];
                UILabel *price = [[UILabel alloc]init];
                price.textColor = [UIColor whiteColor];
                price.font = [UIFont fontWithName:MediumFont size:11.0f];
                
                NSString *str = m.description;
                if (m.description.length >= 16) {
                    str = @([m floatValue]).description;
                }
                price.text = [NSString stringWithFormat:@"￥%@",str];
                price.textAlignment = NSTextAlignmentCenter;
                [kuang addSubview:price];
                [price mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(kuang);
                }];
            }

            
            
            UITapGestureRecognizer *recognizer = [UITapGestureRecognizer rac_recognizer];
            [image addGestureRecognizer:recognizer];
            [[recognizer rac_signal] subscribeNext:^(id x) {
                DetailScene *scene = [[DetailScene alloc]init];
                scene.itemId = [itemIds safeObjectAtIndex:idx];
                scene.platformId = platformId;
                [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
            }];
        }
        
        NSArray *list = _imageWrapView.subviews;
        CGFloat padding = 9.0f;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50.0f - 18.0f)/3;
        CGFloat height = [self gridLayoutWithNumPerRow:list.count == 4?2:3 width:width height:width padding:padding views:list];
        
        [_imageWrapView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
    }
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
            self.shareButton.shareLabel.text = [NSString stringWithFormat:@"%ld",(long)self.dataModel.shareCount.integerValue + 1];
        }
    };
    
    [[URLNavigation navigation].currentNavigationViewController presentViewController:activityController animated:YES completion:nil];
}


@end
