//
//  OrderCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/23.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "OrderCell.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "UserCenter.h"
@interface OrderCell()
@property(nonatomic,retain)UIImageView *avatarView;
@property(nonatomic,retain)UILabel *orderTimeLabel;
@property(nonatomic,retain)UIButton *statusLabel;
@property(nonatomic,retain)UIImageView *leftImageView;
@property(nonatomic,retain)UILabel *orderNumLabel;
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *shortTitleLabel;
@property(nonatomic,retain)UILabel *priceLabel;
@property(nonatomic,retain)UIButton *yujizhuan;
@end
@implementation OrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _avatarView = [[UIImageView alloc]init];
        _avatarView.layer.cornerRadius = 21.5f;
        _avatarView.clipsToBounds = YES;
        _avatarView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_avatarView];
        
        _orderTimeLabel = [[UILabel alloc]init];
        _orderTimeLabel.text = @"2000-01-01 00:00";
        _orderTimeLabel.textColor = [UIColor colorWithString:@"#c5c5c5"];
        _orderTimeLabel.font = [UIFont fontWithName:RegularFont size:12.0f];
        [self.contentView addSubview:_orderTimeLabel];
        
        _statusLabel = [[UIButton alloc]init];
        _statusLabel.backgroundColor = [UIColor colorWithString:@"#6090f7"];
        _statusLabel.titleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        [_statusLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _statusLabel.layer.cornerRadius = 14.0f;
        [self.contentView addSubview:_statusLabel];
        
        UIView *line1 = [[UIView alloc]init];
        line1.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self.contentView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.equalTo(@1.0f);
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.avatarView.mas_bottom).offset(5.0f);
        }];
        
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_leftImageView];
        
        
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1.0f);
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.leftImageView.mas_bottom).offset(10.0f);
        }];
        
        _orderNumLabel = [[UILabel alloc]init];
        _orderNumLabel.text = @"订单编号: 000000000000";
        _orderNumLabel.textColor = [UIColor colorWithString:@"#c5c5c5"];
        _orderNumLabel.font = [UIFont fontWithName:RegularFont size:12.0f];
        [self.contentView addSubview:_orderNumLabel];
        
        UIView *line3 = [[UIView alloc]init];
        line3.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self.contentView addSubview:line3];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10.0f);
            make.left.right.bottom.equalTo(self.contentView);
        }];
        
        
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setImage:[UIImage imageNamed:@"taobao-share"]];
        [self.contentView addSubview:_iconImageView];
        
        _shortTitleLabel = [[UILabel alloc]init];
        _shortTitleLabel.font = [UIFont fontWithName:RegularFont size:14.0f];
        _shortTitleLabel.textColor = [UIColor blackColor];
        _shortTitleLabel.text = @"             这里是标题";
        _shortTitleLabel.numberOfLines = 2;
        [self.contentView addSubview:_shortTitleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont fontWithName:BoldFont size:16.0f];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.text = @"￥0.00";
        _priceLabel.numberOfLines = 2;
        [self.contentView addSubview:_priceLabel];
        
        
        _yujizhuan = [[UIButton alloc]init];
        [_yujizhuan setTitle:@"预计赚:￥0.00" forState:UIControlStateNormal];
        [_yujizhuan setTitleColor:[UIColor colorWithString:@"#eb5d85"] forState:UIControlStateNormal];
        _yujizhuan.layer.cornerRadius = 6.0f;
        _yujizhuan.layer.borderColor =[UIColor colorWithString:@"#eb5d85"].CGColor;
        _yujizhuan.layer.borderWidth = 1.0f;
        _yujizhuan.titleLabel.font = [UIFont fontWithName:MediumFont size:14.0f];
        [self.contentView addSubview:_yujizhuan];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.width.height.equalTo(@43.0f);
        make.left.equalTo(self.contentView).offset(15.0f);
        make.top.equalTo(self.contentView).offset(5.0f);
    }];
    
    [_orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarView);
        make.left.equalTo(self.avatarView.mas_right).offset(6.0f);
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.avatarView);
        make.right.equalTo(self.contentView).offset(-20.0f);
        make.width.equalTo(@52.0f);
    }];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.avatarView);
        make.top.equalTo(self.avatarView.mas_bottom).offset(15.0f);
        make.width.height.equalTo(@90.0f);
    }];
    
    [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.avatarView);
        make.top.equalTo(self.leftImageView.mas_bottom).offset(20.0f);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.leftImageView.mas_right).offset(10.0f);
        make.top.equalTo(self.leftImageView);
    }];
    
    [_shortTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.leftImageView.mas_right).offset(10.0f);
        make.top.equalTo(self.leftImageView);
        make.right.equalTo(self.contentView).offset(-15.0f);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.iconImageView);
        make.bottom.equalTo(self.leftImageView.mas_bottom).offset(-10.0f);
    }];
    
    [_yujizhuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15.0f);
        make.bottom.equalTo(self.leftImageView);
        make.width.equalTo(@110.0f);
    }];
    
}

-(void)reloadData:(UserOrderModel *)model{
    if (!model) return;
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:[UserCenter sharedInstance].loginModel.headimgUrl]];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.pictUrl]];
    _shortTitleLabel.text = [NSString stringWithFormat:@"             %@",model.title];
    [_yujizhuan setTitle:[NSString stringWithFormat:@"预计赚:￥%.2f",model.cash.floatValue] forState:UIControlStateNormal];
    _orderNumLabel.text = [NSString stringWithFormat:@"订单编号: %@",model.orderId];
    _orderTimeLabel.text = [TimeTool formatTime:model.createTime.integerValue/1000 formatWith:@"yyyy-mm-dd hh:ii"];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.payPrice.floatValue];
    if (model.payStatus.integerValue == 12) {
        [_statusLabel setTitle:@"已付款" forState:UIControlStateNormal];
    }else if(model.payStatus.integerValue == 3){
        [_statusLabel setTitle:@"已收货" forState:UIControlStateNormal];
    }else if(model.payStatus.integerValue == 13){
        [_statusLabel setTitle:@"已失效" forState:UIControlStateNormal];
    }else if(model.payStatus.integerValue == 1){
        [_statusLabel setTitle:@"已结算" forState:UIControlStateNormal];
    }
    
}
@end
