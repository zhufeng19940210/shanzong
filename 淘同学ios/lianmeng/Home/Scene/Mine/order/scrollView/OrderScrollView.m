//
//  OrderScrollView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "OrderScrollView.h"
#import "OrderTableView.h"

@interface OrderScrollView()<UIScrollViewDelegate>
@end

@implementation OrderScrollView


-(instancetype)initWithFrame:(CGRect)frame subViewCount:(NSUInteger)count{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(frame.size.width * count, frame.size.height);
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        for (int i=0; i<count; i++) {
            OrderTableView *tableView = [[OrderTableView alloc]initWithFrame:CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
            tableView.tag = i+1;
            [self addSubview:tableView];
        }
    }
    return self;
}

-(void)setPlatformId:(NSUInteger)platformId{
    _platformId = platformId;
    OrderTableView *tableView = [self viewWithTag:1];
    [tableView startRAC:0 platformId:platformId];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    NSLog(@"%f",scrollView.contentOffset.x);
    NSInteger index = scrollView.contentOffset.x/width;
    _index = index;
    if (self.tabDelegate) {
        [self.tabDelegate moveBlackViewToIndex:index];
    }
    OrderTableView *tableView = [self viewWithTag:index+1];
    [tableView startRAC:index platformId:_platformId];
}


-(void)selectPlatformByIndex:(NSUInteger)index{
    _platformId = index;
    OrderTableView *tableView = [self viewWithTag:_index+1];
    [tableView startRAC:_index platformId:index];
}

-(void)touchSortByIndex:(NSUInteger)index{
    _index = index;
    CGFloat width =[UIScreen mainScreen].bounds.size.width;
    [self setContentOffset:CGPointMake(index*width, 0) animated:YES];
    OrderTableView *tableView = [self viewWithTag:index+1];
    [tableView startRAC:index platformId:_platformId];
}
@end
