//
//  RankScrollView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/22.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "RankScrollView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "RankCell.h"

@interface RankScrollView()
@property(nonatomic,retain)UIImageView *firstImageView;
@property(nonatomic,retain)UILabel *firstLabel;
@property(nonatomic,retain)UILabel *firstUser;
@property(nonatomic,retain)UIView *wrapView;
@end

@implementation RankScrollView

-(void)addContentView{
    [super addContentView];
    _firstImageView = [[UIImageView alloc]init];
    _firstImageView.image = [UIImage imageNamed:@"1"];
    [self.contentView addSubview:_firstImageView];
    
    _firstLabel = [[UILabel alloc]init];
    _firstLabel.font = [UIFont fontWithName:BoldFont size:20.0f];
    _firstLabel.text = @"￥0";
    _firstLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_firstLabel];
    
    _firstUser = [[UILabel alloc]init];
    _firstUser.font = [UIFont fontWithName:BoldFont size:12.5f];
    _firstUser.text = @"130000000";
    _firstUser.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_firstUser];
    
    _wrapView = [[UIView alloc]init];
    _wrapView.layer.cornerRadius = 10.0f;
    _wrapView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_wrapView];
    
    [self loadAutoLayout];
}

-(void)reloadList:(NSMutableArray *)list{
    if (list.count >0) {
        NSDictionary *first = [list safeObjectAtIndex:0];
        _firstUser.text = [first objectForKey:@"username"];
        _firstLabel.text = [NSString stringWithFormat:@"￥%@",[first objectForKey:@"cashSum"]];
        [list removeObjectAtIndex:0];
        
        NSArray *views = [list mapWithIndex:^id(id obj, NSUInteger idx) {
            RankCell *cell = [[RankCell alloc]init];
            [cell setModel:obj forIndex:idx];
            [self.wrapView addSubview:cell];
            return cell;
        }];
        
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.wrapView);
            make.height.equalTo(@60.0f);
        }];
        
        [views mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.0f leadSpacing:0 tailSpacing:0];
        
    }
}

-(void)loadAutoLayout{
    [_firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(15.0f);
    }];
    
    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.contentView);
       make.top.equalTo(self.firstImageView.mas_bottom).offset(10.0f);
    }];
    
    [_firstUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.firstLabel.mas_bottom).offset(10.0f);
    }];
    [_wrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.right.equalTo(self.contentView).offset(-15.0f);
        make.top.equalTo(self.firstUser.mas_bottom).offset(17.5f);
        make.height.equalTo(@540.0f).priorityLow();
        make.bottom.equalTo(self.contentView).offset(-20.0f);
    }];
}

@end
