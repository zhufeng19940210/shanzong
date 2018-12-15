//
//  XianShiCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "XianShiCell.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>

@interface XianShiCell()
@property(nonatomic,retain)UIImageView *leftImageView;
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *shortTitleLabel;

@property(nonatomic,retain)UIImageView *yhqImageView;
@property(nonatomic,retain)UILabel *yhqLabel;

@property(nonatomic,retain)UILabel *pricelabel;
@property(nonatomic,retain)UILabel *originPricelabel;

@property(nonatomic,retain)UIImageView *yujiImageView;
@property(nonatomic,retain)UILabel *yujiLabel;

@property(nonatomic,retain)GoodsModel *model;
@end
@implementation XianShiCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _leftImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_leftImageView];
        
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setImage:[UIImage imageNamed:@"tao"]];
        [self.contentView addSubview:_iconImageView];
        
        _shortTitleLabel = [[UILabel alloc]init];
        _shortTitleLabel.font = [UIFont fontWithName:RegularFont size:13.0f];
        _shortTitleLabel.textColor = [UIColor colorWithString:@"#111111"];
        _shortTitleLabel.text = @"这里是标题";
        _shortTitleLabel.numberOfLines = 2;
        [self.contentView addSubview:_shortTitleLabel];
        
        
        
        _yhqImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quanxiaobiao-blue"]];
        [self.contentView addSubview:_yhqImageView];
        
        _yhqLabel = [[UILabel alloc]init];
        _yhqLabel.font = [UIFont fontWithName:RegularFont size:10.0f];
        _yhqLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_yhqLabel];
        
        
        _pricelabel = [[UILabel alloc]init];
        _pricelabel.textColor = [UIColor colorWithString:@"#490AD4"];
        NSString *price = @"￥0.00";
        NSMutableAttributedString *priceAttri = [[NSMutableAttributedString alloc] initWithString:price];
        [priceAttri addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:11.0] range:NSMakeRange(0, 1)];
        [priceAttri addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:16.0] range:NSMakeRange(1, price.length - 1)];
        [_pricelabel setAttributedText:priceAttri];
        [self.contentView addSubview:_pricelabel];
        
        _originPricelabel = [[UILabel alloc]init];
        _originPricelabel.textColor = [UIColor colorWithString:@"#AAAAAA"];
        _originPricelabel.font = [UIFont fontWithName:RegularFont size:10.0f];
        NSString *oldPrice = @"￥0.00";
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                      range:NSMakeRange(0, oldPrice.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithString:@"#AAAAAA"]
                      range:NSMakeRange(0, oldPrice.length)];
        [_originPricelabel setAttributedText:attri];
        [self.contentView addSubview:_originPricelabel];
        
        
        _yujiImageView = [[UIImageView alloc]init];
        _yujiImageView.image = [UIImage imageNamed:@"yujizhuanK-blue"];
        [self.contentView addSubview:_yujiImageView];
        
        _yujiLabel = [[UILabel alloc]init];
        _yujiLabel.text = @"预计赚￥0.00";
        _yujiLabel.font = [UIFont fontWithName:RegularFont size:10.0f];
        _yujiLabel.textColor = [UIColor colorWithString:@"#8A46E1"];
        _yujiLabel.textAlignment = NSTextAlignmentCenter;
        [_yujiImageView addSubview:_yujiLabel];
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithString:@"#F2F4F4"];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.contentView);
            make.height.equalTo(@1.0f);
        }];
        [self loadAutoLayout];
        
    }
    return self;
}

-(void)loadAutoLayout{
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.top.equalTo(self.contentView).offset(10.0f);
        make.width.height.equalTo(@104.0f);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(15.0f);
        make.top.equalTo(self.contentView).offset(16.0f);
        make.width.height.equalTo(@13.0f);
    }];
    
    [_shortTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView);
        make.right.equalTo(self.contentView).offset(-15.0f);
    }];
    
    
    [_yhqImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shortTitleLabel);
        make.top.equalTo(self.shortTitleLabel.mas_bottom).offset(9.0f);;
    }];
    
    [_yhqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.yhqImageView);
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.bottom.equalTo(self.leftImageView);
    }];
    
    [_originPricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.pricelabel.mas_right).offset(5.0f);
        make.bottom.equalTo(self.leftImageView);
    }];
    
    [_yujiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15.0f);
        make.bottom.equalTo(self.leftImageView);
    }];
    
    [_yujiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.yujiImageView);
        make.left.equalTo(self.yujiImageView).offset(3.0f);
        make.right.equalTo(self.yujiImageView).offset(-3.0f);
    }];
}


-(void)setModel:(GoodsModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    
    if (model.platformId == 1) {
        _iconImageView.image = [UIImage imageNamed:@"tao"];
    }else if(model.platformId == 2){
        _iconImageView.image = [UIImage imageNamed:@"jing"];
    }
    
    
    _shortTitleLabel.text = [NSString stringWithFormat:@"     %@",model.itemTitle];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.itemPic]];

    if(model.couponPrice){
        _yhqLabel.hidden = NO;
        _originPricelabel.hidden = NO;
        _yhqLabel.text = [NSString stringWithFormat:@"%@元券",model.couponPrice];
        NSString *price = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue - model.couponPrice.floatValue];
        NSMutableAttributedString *priceAttri = [[NSMutableAttributedString alloc] initWithString:price];
        [priceAttri addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:11.0] range:NSMakeRange(0, 1)];
        [priceAttri addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:16.0] range:NSMakeRange(1, price.length - 1)];
        [_pricelabel setAttributedText:priceAttri];
        
        
        NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                      range:NSMakeRange(0, oldPrice.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithString:@"#AAAAAA"]
                      range:NSMakeRange(0, oldPrice.length)];
        [_originPricelabel setAttributedText:attri];
    }else{
        _yhqLabel.hidden = YES;
        _originPricelabel.hidden = YES;
        
        NSString *price = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue];
        
        NSMutableAttributedString *priceAttri = [[NSMutableAttributedString alloc] initWithString:price];
        [priceAttri addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:11.0] range:NSMakeRange(0, 1)];
        [priceAttri addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:16.0] range:NSMakeRange(1, price.length - 1)];
        [_pricelabel setAttributedText:priceAttri];
    }
    
    if(model.tkMoney){
        _yujiImageView.hidden = NO;
        _yujiLabel.text =[NSString stringWithFormat:@"预计赚￥%.2f",model.tkMoney.floatValue];
    }else{
        _yujiImageView.hidden = YES;
    }
    
}
@end
