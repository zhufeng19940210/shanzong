//
//  MessageCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/5.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MessageCell.h"
#import <Masonry/Masonry.h>
@interface MessageCell()
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *subTitleLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@end

@implementation MessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setImage:[UIImage imageNamed:@"ring"]];
        [self.contentView addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.textColor = [UIColor colorWithRed:4.0f/255.0f green:4.0f/255.0f blue:4.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_titleLabel];
        
        // fixes an iOS 8 issue with UIViewEncapsulated height 44 bug
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375.0f, 100.0f)];
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        _subTitleLabel.textColor = [UIColor colorWithRed:115.0f/255.0f green:115.0f/255.0f blue:115.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_subTitleLabel];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:11.0f];
        _timeLabel.textColor = [UIColor colorWithRed:179.0f/255.0f green:179.0f/255.0f blue:179.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_timeLabel];
        
        [self loadAutoLayout];
    
    }
    return self;
}

-(void)loadAutoLayout{
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(17.0f);
        make.top.equalTo(self.contentView).offset(17.0f);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(18.0f);
        make.top.equalTo(self.contentView).offset(20.0f);
        make.right.equalTo(self.contentView).offset(-30.0f);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30.0f);
        make.height.greaterThanOrEqualTo(@50.0f);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(9.0f);
    }];
}

-(void)setModel:(MessageListModel *)model{
    _titleLabel.text = @"通知";
    _subTitleLabel.text = @"一开始我只是想布局一个九宫格，但是后来又想，如果需求扩展到了N个单元，该如何实现呢，我的办法是从九宫格开始，由小及大来推导，然后就是要知道自动布局需要添加哪些约束，能够完整的固定视图，不能多，也不要少，这是很重要的。";
    _timeLabel.text = @"2018.05.17 10:10";
}
@end
