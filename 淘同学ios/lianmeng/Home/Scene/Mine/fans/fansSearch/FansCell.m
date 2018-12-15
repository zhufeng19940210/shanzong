//
//  FansCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/27.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FansCell.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
@interface FansCell()
@property(nonatomic,retain)UIImageView *avatar;
@property(nonatomic,retain)UILabel *nicknameLabel;
@property(nonatomic,retain)UILabel *phoneLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *recommendLabel;
@property(nonatomic,retain)UILabel *recommendCountLabel;
@end
@implementation FansCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        _avatar = [[UIImageView alloc]init];
        _avatar.layer.cornerRadius = 22.5f;
        _avatar.clipsToBounds = YES;
        [self.contentView addSubview:_avatar];
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.text = @"昵称";
        _nicknameLabel.textColor = [UIColor colorWithString:@"rgb(55,54,55)"];
        _nicknameLabel.font = [UIFont fontWithName:RegularFont size:15.0f];
        [self.contentView addSubview:_nicknameLabel];
        
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"(13000000000)";
        _phoneLabel.textColor = [UIColor colorWithString:@"rgb(170,170,170)"];
        _phoneLabel.font = [UIFont fontWithName:RegularFont size:14.0f];
        [self.contentView addSubview:_phoneLabel];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"2018-01-01 00:00";
        _timeLabel.textColor = [UIColor colorWithString:@"rgb(204,204,204)"];
        _timeLabel.font = [UIFont fontWithName:RegularFont size:12.0f];
        [self.contentView addSubview:_timeLabel];
        
        _recommendLabel = [[UILabel alloc]init];
        _recommendLabel.text = @"推荐人数";
        _recommendLabel.textColor = [UIColor colorWithString:@"rgb(170,170,170)"];
        _recommendLabel.font = [UIFont fontWithName:RegularFont size:14.0f];
        [self.contentView addSubview:_recommendLabel];
        
        _recommendCountLabel = [[UILabel alloc]init];
//        _recommendCountLabel.textColor = [UIColor colorWithString:@"rgb(170,170,170)"];
        _recommendCountLabel.font = [UIFont fontWithName:RegularFont size:18.0f];
        
        [self.contentView addSubview:_recommendCountLabel];
        
        NSString *str = @"0人";
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithString:@"rgb(119,172,249)"]
                      range:NSMakeRange(0, str.length - 1)];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithString:@"rgb(170,170,170)"]
                      range:NSMakeRange(str.length - 1, 1)];
        [_recommendCountLabel setAttributedText:attri];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@45.0f);
    }];
    
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.avatar.mas_right).offset(10.0f);
        make.top.equalTo(self.avatar).offset(3.0f);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.nicknameLabel.mas_right).offset(10.0f);
        make.centerY.equalTo(self.nicknameLabel);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.nicknameLabel);
        make.bottom.equalTo(self.avatar.mas_bottom).offset(-5.0f);
    }];
    
    [_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.phoneLabel);
        make.right.equalTo(self.contentView).offset(-20.0f);
    }];
    
    [_recommendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.timeLabel);
        make.centerX.equalTo(self.recommendLabel);
    }];
}

-(void)reloadData:(FansModel *)model{
    if(!model) return;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.headimgUrl]];
    _nicknameLabel.text = model.nickName;
    NSString *str = [NSString stringWithFormat:@"%ld人",(long)model.fansNum.integerValue];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithString:@"rgb(119,172,249)"]
                  range:NSMakeRange(0, str.length - 1)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithString:@"rgb(170,170,170)"]
                  range:NSMakeRange(str.length - 1, 1)];
    [_recommendCountLabel setAttributedText:attri];
    if(model.username){
         _phoneLabel.text = [NSString stringWithFormat:@"(%@)",model.username];
    }
   
    
    _timeLabel.text = [TimeTool formatTime:model.createTime.integerValue/1000 formatWith:@"yyyy-MM-dd h:i"];
}
@end
