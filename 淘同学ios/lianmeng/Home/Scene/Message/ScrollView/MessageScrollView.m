//
//  MessageScrollView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MessageScrollView.h"
#import "MessageTableView.h"

@interface MessageScrollView()
@property(nonatomic,retain)MessageTableView *tableView1;
@property(nonatomic,retain)MessageTableView *tableView2;

@end
@implementation MessageScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
        self.pagingEnabled = YES;
        
        _tableView1 = [[MessageTableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        [self addSubview:_tableView1];
        
        _tableView2 = [[MessageTableView alloc]initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        [self addSubview:_tableView2];
        self.contentSize = CGSizeMake(2*frame.size.width,  frame.size.height);
        
    }
    return self;
}

@end
