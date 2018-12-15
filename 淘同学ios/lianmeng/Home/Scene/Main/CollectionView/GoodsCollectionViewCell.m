//
//  GoodsCollectionViewCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "GoodsCollectionViewCell.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
@interface GoodsCollectionViewCell()
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIImageView *yjBgview;
@property(nonatomic,retain)UILabel *yjLabel;
@property(nonatomic,retain)UIImageView *iconImageView;

@property(nonatomic,retain)UILabel *originPrice;
@property(nonatomic,retain)UILabel *salesCount;
@property(nonatomic,retain)UILabel *price;
@property(nonatomic,retain)UIImageView *youhuiquanView;
@property(nonatomic,retain)UILabel *youhuiquanLabel;
@end

@implementation GoodsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 170.0f)];
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(6.5f, 195.0f, frame.size.width - 13.0f, 34.0f)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor colorWithString:@"rgb(136,136,136)"];
        [self addSubview:_titleLabel];
        
        _yjBgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 170.0f, frame.size.width, 21.0f)];
        _yjBgview.image = [UIImage imageNamed:@"yugukuang-1"];
        
        [self addSubview:_yjBgview];
        
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5.0f, 195.0f, 16.0f, 16.0f)];
        [_iconImageView setImage:[UIImage imageNamed:@"tao"]];
        [self addSubview:_iconImageView];
        
        
        _yjLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _yjBgview.frame.size.width, _yjBgview.frame.size.height)];
        _yjLabel.font = [UIFont systemFontOfSize:14.0f];
        _yjLabel.textColor = [UIColor whiteColor];
        _yjLabel.textAlignment = NSTextAlignmentCenter;
        [_yjBgview addSubview:_yjLabel];
        
        
        _originPrice= [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 195.0f+42.0f, 90.0f, 12.0f)];
        _originPrice.font = [UIFont fontWithName:MediumFont size:12.0f];
        _originPrice.textColor = [UIColor colorWithString:@"rgb(153,153,153)"];
        _originPrice.text = @"淘宝价 ￥0.00";
        [self addSubview:_originPrice];
        
        _salesCount= [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 78.0f, 195.0f+42.0f,70.0f, 12.0f)];
        _salesCount.font = [UIFont fontWithName:MediumFont size:12.0f];
        _salesCount.textColor = [UIColor colorWithString:@"rgb(153,153,153)"];
        _salesCount.textAlignment = NSTextAlignmentRight;
        _salesCount.text = @"月销 0";
        [self addSubview:_salesCount];
        
        
        _price = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 195.0f+42.0f + 22.0f, 100.0f, 21.0f)];
        _price.font = [UIFont fontWithName:MediumFont size:21.0f];
        _price.textColor = [UIColor colorWithString:@"rgb(210,7,27)"];
        _price.textAlignment = NSTextAlignmentLeft;

        [self addSubview:_price];
        
        _youhuiquanView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width -  65.0f, 195.0f+42.0f + 22.0f, 60.0f, 20.0f)];
        _youhuiquanView.image = [UIImage imageNamed:@"quankuang"];
        [self addSubview:_youhuiquanView];
        
        _youhuiquanLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  60.0f, 20.0f)];
        _youhuiquanLabel.font = [UIFont fontWithName:MediumFont size:14.0f];
        _youhuiquanLabel.textColor = [UIColor whiteColor];
        _youhuiquanLabel.textAlignment = NSTextAlignmentCenter;
        _youhuiquanLabel.text = @"券￥0";
        [_youhuiquanView addSubview:_youhuiquanLabel];
        
        
    }
    return self;
}

-(void)setModel:(GoodsModel *)model{
    if (model) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.itemPic]];
        _titleLabel.text = [NSString stringWithFormat:@"     %@",model.itemShorTtitle];
        if (model.tkMoney && model.tkMoney.floatValue >0) {
            _yjLabel.hidden = NO;
            _yjBgview.hidden = NO;
            _yjLabel.text = [NSString stringWithFormat:@"预估佣金：￥%.2f",model.tkMoney.floatValue];
        }else{
            _yjLabel.hidden = YES;
            _yjBgview.hidden = YES;
            _yjLabel.text = [NSString stringWithFormat:@"预估佣金：￥0.00"];
        }
        
        NSString *platform = @"淘宝";
        if (model.platformId == 1) {
            if (model.shopType.integerValue == 0) {
                _iconImageView.image = [UIImage imageNamed:@"tao"];
                platform = @"淘宝";
            }else{
                _iconImageView.image = [UIImage imageNamed:@"mao"];
                platform = @"天猫";
            }
            
        }else if(model.platformId == 2){
            _iconImageView.image = [UIImage imageNamed:@"jing"];
            platform = @"京东";
        }
        
         NSString *str = @"";
        if (model.couponPrice){
            _youhuiquanView.hidden = NO;
            _youhuiquanLabel.text = [NSString stringWithFormat:@"券￥%@",model.couponPrice];
            _originPrice.text = [NSString stringWithFormat:@"%@价￥%.2f",platform,model.itemPrice.floatValue];
             str = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue - model.couponPrice.floatValue];
        }else{
            _originPrice.hidden = YES;
            _youhuiquanView.hidden = YES;
             str = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue];
        }
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:15.0f] range:NSMakeRange(0, 1)];
        [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:21.0] range:NSMakeRange(1, str.length - 1)];
        [_price setAttributedText:attri];
        
        _salesCount.text = [NSString stringWithFormat:@"月销 %ld",(long)model.itemSale.integerValue];
    }
}
@end
