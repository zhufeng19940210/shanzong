//  LeftTableViewCell.m
//  lianmeng
//  Created by zhufeng on 2018/12/17.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "LeftTableViewCell.h"
#define defaultColor rgba(253, 212, 49, 1)
@interface LeftTableViewCell()
@property (nonatomic, strong) UIView *yellowView;
@end

@implementation LeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = rgba(130, 130, 130, 1);
        self.name.highlightedTextColor = [UIColor redColor];
        [self.contentView addSubview:self.name];
        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 45)];
        self.yellowView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.yellowView];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state

    self.contentView.backgroundColor = selected ?[UIColor colorWithWhite:0 alpha:0.1] : [UIColor whiteColor] ;
    self.highlighted = selected;
    self.name.highlighted = selected;
    self.yellowView.hidden = !selected;
}

@end
