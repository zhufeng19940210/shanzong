//
//  TaoBaoScrollView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/14.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TaoBaoScrollView.h"
#import "TabBaoItemCell.h"
#import <GCDObjC/GCDObjC.h>

@interface TaoBaoScrollView()<UIScrollViewDelegate>
@end
@implementation TaoBaoScrollView

-(instancetype)initWithFrame:(CGRect)frame subViewCount:(NSUInteger)count platformId:(NSUInteger)platformId
delegate:(id<TaoBaoViewScrolling>)scrollingDelegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(frame.size.width * count, frame.size.height);
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.delegate = self;
        for (int i=0; i<count; i++) {
            TaoBaoTableView *tableView = [[TaoBaoTableView alloc]initWithFrame:CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
            tableView.tag = i+1;
            tableView.scrollingDelegate = scrollingDelegate;
            tableView.sceneModel.platformId = platformId;
            [self addSubview:tableView];
        }
        
        TaoBaoTableView *tableView = [self viewWithTag:1];
        [tableView startRAC:0];
    }
    return self;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    NSInteger index = scrollView.contentOffset.x/width;
    if (self.tabDelegate) {
        [self.tabDelegate moveBlackViewToIndex:index];
    }
    TaoBaoTableView *tableView = [self viewWithTag:index+1];
    [tableView startRAC:index];
}



-(void)tabBarDidChange:(NSUInteger)index{
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    [self setContentOffset:CGPointMake(index*width, 0) animated:YES];
    [[GCDQueue mainQueue] queueBlock:^{
        TaoBaoTableView *tableView = [self viewWithTag:index+1];
        [tableView startRAC:index];
    } afterDelay:0.3f];
}
@end

