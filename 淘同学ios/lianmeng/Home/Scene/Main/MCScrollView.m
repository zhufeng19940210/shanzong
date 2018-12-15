//
//  MCScrollView.m
//  MCBook
//
//  Created by Dariel on 16/3/31.
//  Copyright © 2016年 Dariel. All rights reserved.
//

#import "MCScrollView.h"
#import <UIImageView+WebCache.h>
#import <EasyIOS/EasyIOS.h>
#import "UIView+MCExtension.h"


@interface MCScrollView ()<UIGestureRecognizerDelegate>
{
    int curPage;
    UIScrollView *curScrollView;
    CGRect showFrame;
    NSArray *showImages;
    NSMutableArray *curImages;  // 存放当前滚动的三张图片
    
    UIPageControl *pageCtrl;
    UIView *superView;
    
    NSTimer *timer;
}
@end


@implementation MCScrollView


//frameSize
-(instancetype)initWIthFrame:(CGRect)frameSize
{
    if (self = [super initWithFrame:frameSize]) {
        showFrame = frameSize;
        curImages = [[NSMutableArray alloc] init];
        curPage = 1;
        showImages = @[];
            
        curScrollView = [[UIScrollView alloc] initWithFrame:frameSize];
        curScrollView.backgroundColor = [UIColor lightGrayColor];
        curScrollView.showsHorizontalScrollIndicator = NO;
        curScrollView.showsVerticalScrollIndicator = NO;
        curScrollView.pagingEnabled = YES;
        curScrollView.delegate = self;
        curScrollView.bounces = NO;
        
        [curScrollView setContentSize:CGSizeMake(curScrollView.frame.size.width * 3, curScrollView.frame.size.height)];
        
        [self addSubview:curScrollView];
        [self addPageCtrl];
     
    }
    return self;
}

-(void)reloadImages:(NSArray *)imageArray{
    NSLog(@"imageArray.count:%lu",(unsigned long)imageArray.count);
    showImages = [NSArray arrayWithArray:imageArray];
    pageCtrl.numberOfPages = (int)imageArray.count;
    [self refreshScrollView];
    [self start];
}

- (void)addPageCtrl
{
    
    UIPageControl *page = [[UIPageControl alloc] init];
    pageCtrl = page;
//    page.MC_height = 8;
//    page.MC_width = 8;
    pageCtrl.numberOfPages = 0;
    CGFloat centerX = showFrame.size.width * 0.5;
    CGFloat centerY = showFrame.size.height* 0.92;
    pageCtrl.center = CGPointMake(centerX, centerY);
    pageCtrl.userInteractionEnabled = NO;
    
    // 2.设置圆点的颜色
//    pageCtrl.currentPageIndicatorTintColor = [UIColor colorWithString:@"#31C2EA"];
//    pageCtrl.pageIndicatorTintColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.8];
    
    [self addSubview:pageCtrl];
}

-(void)refreshScrollView
{
    NSArray *subViews = [curScrollView subviews];
    if (subViews.count != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurPage:curPage];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
        [imageView addGestureRecognizer:tap];
        //加载图片数据
        NSString *url = [curImages safeObjectAtIndex:i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_image"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;

        imageView.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, showFrame.size.height);
        
        [curScrollView addSubview:imageView];
    }
    
    [curScrollView setContentOffset:CGPointMake(showFrame.size.width, 0)];
}

- (void)imageViewClick:(UIImageView *)imageView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MCScrollView:touchImageAtIndex:)]) {
        [self.delegate MCScrollView:self touchImageAtIndex:curPage];
    }
}

- (NSArray *)getDisplayImagesWithCurPage:(int)page
{
    int pre = [self validPageValue:curPage-1];
    int last = [self validPageValue:curPage+1];
    
    if([curImages count] != 0) [curImages removeAllObjects];
    
    NSString *img1 = [showImages safeObjectAtIndex:pre-1];
    
    if (img1.isNotEmpty) {
         [curImages addObject:img1];
    }
    
    NSString *img2 = [showImages safeObjectAtIndex:curPage-1];
    
    if (img2.isNotEmpty) {
        [curImages addObject:img2];
    }
    
    NSString *img3 = [showImages safeObjectAtIndex:last-1];
    
    if (img3.isNotEmpty) {
        [curImages addObject:img3];
    }
    
    return curImages;
}

- (int)validPageValue:(NSInteger)value {
    
    // value＝1为第一张，value = 0为前面一张
    if(value == 0) value = pageCtrl.numberOfPages;
    if(value == pageCtrl.numberOfPages + 1) value = 1;
    
    return (int)value;
}


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    
    // 往下翻一张
    if(x >= (2*showFrame.size.width))
    {
        curPage = [self validPageValue:curPage+1];
        [self refreshScrollView];
    }
    if(x <= 0)
    {
        curPage = [self validPageValue:curPage-1];
        [self refreshScrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    [curScrollView setContentOffset:CGPointMake(showFrame.size.width, 0) animated:YES];
    
    [pageCtrl setCurrentPage:curPage - 1];
}
- (void)start
{
    [self addTimer];
}

- (void)stop
{
    [self killTimer];
}

- (void)addTimer
{
    if(timer == nil)
        timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)killTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)autoScroll
{
    [curScrollView scrollRectToVisible:CGRectMake(showFrame.size.width * 2, 0, showFrame.size.width, showFrame.size.height) animated:YES];
    
    if (curPage == showImages.count) {
        [pageCtrl setCurrentPage:0];
    }
    else
        [pageCtrl setCurrentPage:curPage];
}

@end

