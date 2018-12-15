//
//  MessageCell.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListModel.h"

@interface MessageCell : UITableViewCell
-(void)setModel:(MessageListModel *)model;
@end
