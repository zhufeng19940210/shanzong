//  HeaderTtileCell.h
//  lianmeng
//  Created by zhufeng on 2018/12/14.
//  Copyright © 2018 zhuchao. All rights reserved.
#import <UIKit/UIKit.h>
typedef void (^MoreBlock)(void);
@interface HeaderTtileCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *english_lab;
@property (nonatomic,copy)MoreBlock moreblock;
@end
