//
//  MessageTableView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MessageTableView.h"
#import "MessageCell.h"
@interface MessageTableView()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation MessageTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 120.0f;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[MessageCell class] forCellReuseIdentifier:@"MessageCell"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    [cell setModel:nil];
    return cell;
}

@end
