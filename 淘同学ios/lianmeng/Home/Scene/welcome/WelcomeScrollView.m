//  WelcomeScene.m
//  philips
//  Created by zhuchao on 2017/7/31.
//  Copyright © 2017年 zhuchao. All rights reserved.
#import "WelcomeScrollView.h"
#import "SceneScrollView.h"
#import <Masonry/Masonry.h>
@interface WelcomeScrollView ()<UIScrollViewDelegate>
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)UIButton *enterButton;

@property(nonatomic,assign)NSUInteger listCount;
@end

@implementation WelcomeScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = false;
        self.delegate = self;

    }
    return self;
}

-(void)loadImages:(NSArray *)list{
    _listCount = list.count;

    NSArray * viewArray = [list mapWithIndex:^UIImageView *(NSString* obj,NSUInteger idx) {
        UIImageView * item = [[UIImageView alloc]init];
        item.contentMode = UIViewContentModeScaleToFill;
        [item sd_setImageWithURL:[NSURL URLWithString:obj]];
        return item;
    }];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.contentSize = CGSizeMake((list.count+1)*screenWidth, screenHeight);
    
    [viewArray eachWithIndex:^(UIImageView* obj, NSUInteger idx) {
        obj.frame = CGRectMake(idx*screenWidth, 0, screenWidth, screenHeight);
        [self addSubview:obj];
    }];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    NSInteger index = fabs(sView.contentOffset.x) / sView.frame.size.width;
    if (index==_listCount) {
        [self removeFromSuperview];
    }
}

@end
