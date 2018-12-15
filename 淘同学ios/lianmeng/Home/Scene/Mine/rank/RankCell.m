//
//  RankCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/22.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "RankCell.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>

@interface RankCell()
@property(nonatomic,retain)UILabel *leftNumberLabel;
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *moneyLabel;
@property(nonatomic,retain)UIButton *favButton;
@end


@implementation RankCell

-(instancetype)init{
    self = [super init];
    if (self) {
        _iconImageView = [[UIImageView alloc]init];
        [self addSubview:_iconImageView];
        
        _leftNumberLabel = [[UILabel alloc]init];
        _leftNumberLabel.textAlignment = NSTextAlignmentCenter;
        _leftNumberLabel.font = [UIFont fontWithName:BoldFont size:15.5f];
        _leftNumberLabel.textColor = [UIColor colorWithString:@"rgb(81,79,79)"];
        [self addSubview:_leftNumberLabel];
        
        _nameLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont fontWithName:BoldFont size:13.5f];
        _moneyLabel.textColor = [UIColor colorWithString:@"rgb(81,79,79)"];
        [self addSubview:_nameLabel];
        
        _moneyLabel= [[UILabel alloc]init];
        _moneyLabel.font = [UIFont fontWithName:BoldFont size:19.0f];
        _moneyLabel.textColor = [UIColor colorWithString:@"rgb(244,112,22)"];
        [self addSubview:_moneyLabel];
        
        _favButton = [[UIButton alloc]init];
        [_favButton setImage:[UIImage imageNamed:@"star0"] forState:UIControlStateNormal];
        [self addSubview:_favButton];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.equalTo(@1.0f);
            make.bottom.equalTo(self);
            make.right.equalTo(self).offset(-20.0f);
            make.left.equalTo(self).offset(60.0f);
        }];
        [self loadAutoLayout];
    }
    return self;
}

-(void)setModel:(NSDictionary *)model forIndex:(NSUInteger)idx{
    
    if (idx < 2) {
        _iconImageView.hidden = NO;
        _leftNumberLabel.hidden = YES;
        _iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)idx+2]];
    }else{
        _iconImageView.hidden = YES;
        _leftNumberLabel.hidden = NO;
        _leftNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)idx+2];
    }

    _nameLabel.text = [model objectForKey:@"username"];
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@",[model objectForKey:@"cashSum"]];
    
}

-(void)loadAutoLayout{
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
    }];
    
    [_leftNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(25.0f);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(60.0f);
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.favButton.mas_left).offset(-5.0f);
    }];
    
    [_favButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-20.0f);
    }];
    
}

@end
