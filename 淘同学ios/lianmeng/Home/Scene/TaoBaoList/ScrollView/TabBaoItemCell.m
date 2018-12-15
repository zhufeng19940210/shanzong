//
//  TabBaoItemCell.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/14.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TabBaoItemCell.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "VideoController.h"

@interface TabBaoItemCell()
@property(nonatomic,retain)UIImageView *leftImageView;
@property(nonatomic,retain)UIImageView *iconImageView;

@property(nonatomic,retain)UILabel *shortTitleLabel;

@property(nonatomic,retain)UIImageView *youhuiquanBg;
@property(nonatomic,retain)UILabel *youhuiquan;
@property(nonatomic,retain)UILabel *saleCount;
@property(nonatomic,retain)UIButton *favBtn;
@property(nonatomic,retain)UILabel *yenLabel;
@property(nonatomic,retain)UILabel *originPricelabel;
@property(nonatomic,retain)UIImageView *yujiImageView;
@property(nonatomic,retain)UIImageView *shengjiImageView;
@property(nonatomic,retain)UILabel *yujiLabel;
@property(nonatomic,retain)UILabel *shengjiLabel;
@property(nonatomic,retain)NSString *videoUrl;

@property(nonatomic,retain)UIImageView *playerBtn;
@property(nonatomic,retain)GoodsModel *model;
@end
@implementation TabBaoItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _leftImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_leftImageView];
        [_leftImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoView)]];
        
        _playerBtn = [[UIImageView alloc]init];
        _playerBtn.hidden = YES;
        _playerBtn.image = [UIImage imageNamed:@"player-btn"];
        [_leftImageView addSubview:_playerBtn];
        
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setImage:[UIImage imageNamed:@"tao"]];
        [self.contentView addSubview:_iconImageView];
        
        _shortTitleLabel = [[UILabel alloc]init];
        _shortTitleLabel.font = [UIFont fontWithName:RegularFont size:12.0f];
        _shortTitleLabel.textColor = [UIColor colorWithString:@"#111111"];
        _shortTitleLabel.text = @"这里是标题";
        [self.contentView addSubview:_shortTitleLabel];
        
        
        _youhuiquanBg = [[UIImageView alloc]init];
        [_youhuiquanBg setImage:[UIImage imageNamed:@"quanK"]];
        [self.contentView addSubview:_youhuiquanBg];
        
        _youhuiquan = [[UILabel alloc]init];
        _youhuiquan.font = [UIFont fontWithName:BoldFont size:12.0f];
        _youhuiquan.textColor = [UIColor whiteColor];
        _youhuiquan.text = @"0元券";
        _youhuiquan.textAlignment = NSTextAlignmentCenter;
        [_youhuiquanBg addSubview:_youhuiquan];
        
        
        _saleCount = [[UILabel alloc]init];
        _saleCount.font = [UIFont fontWithName:RegularFont size:10.0f];
        _saleCount.textColor = [UIColor colorWithString:@"#9D9D9D"];
        _saleCount.text = @"0人已买";
        [self.contentView addSubview:_saleCount];
        
        _favBtn = [[UIButton alloc]init];
        [_favBtn setImage:[UIImage imageNamed:@"shoucang-btn1"] forState:UIControlStateNormal];
        [_favBtn setImage:[UIImage imageNamed:@"shoucang-btn2"] forState:UIControlStateSelected];
        [_favBtn addTarget:self action:@selector(fav) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_favBtn];
        
        _yenLabel = [[UILabel alloc]init];
        _yenLabel.textColor = [UIColor colorWithString:@"rgb(180,41,44)"];
        NSString *text = @"￥0.00";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:11.0f] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:18.0] range:NSMakeRange(1, text.length - 1)];
        _yenLabel.attributedText = str;
        
        [self.contentView addSubview:_yenLabel];
        
        _originPricelabel = [[UILabel alloc]init];
        _originPricelabel.textColor = [UIColor colorWithString:@"#9D9D9D"];
        _originPricelabel.font = [UIFont fontWithName:RegularFont size:10.0f];
        NSString *oldPrice = @"￥0.00";
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                      range:NSMakeRange(0, oldPrice.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithString:@"#9D9D9D"]
                      range:NSMakeRange(0, oldPrice.length)];
        [_originPricelabel setAttributedText:attri];
        [self.contentView addSubview:_originPricelabel];
        
        
        _yujiImageView = [[UIImageView alloc]init];
        _yujiImageView.image = [UIImage imageNamed:@"yujizhuanK"];
        [self.contentView addSubview:_yujiImageView];
        
        _yujiLabel = [[UILabel alloc]init];
        _yujiLabel.text = @"预计赚￥0.00";
        _yujiLabel.font = [UIFont fontWithName:RegularFont size:9.5f];
        _yujiLabel.textColor = [UIColor colorWithString:@"rgb(180,41,44)"];
        _yujiLabel.textAlignment = NSTextAlignmentCenter;
        [_yujiImageView addSubview:_yujiLabel];
        
        
        _shengjiImageView = [[UIImageView alloc]init];
        _shengjiImageView.image = [UIImage imageNamed:@"yujizhuanK"];
        [self.contentView addSubview:_shengjiImageView];
        
        _shengjiLabel = [[UILabel alloc]init];
        _shengjiLabel.text = @"升级赚￥0.00";
        _shengjiLabel.font = [UIFont fontWithName:RegularFont size:9.5f];
        _shengjiLabel.textColor = [UIColor colorWithString:@"rgb(180,41,44)"];
        _shengjiLabel.textAlignment = NSTextAlignmentCenter;
        [_shengjiImageView addSubview:_shengjiLabel];
        
        [self loadAutoLayout];
        
        
    }
    return self;
}

-(void)loadAutoLayout{
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0f);
        make.top.equalTo(self.contentView).offset(10.0f);
        make.width.height.equalTo(@120.0f);
    }];
    
    [_playerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.center.equalTo(self.leftImageView);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.leftImageView.mas_right).offset(15.0f);
        make.top.equalTo(self.contentView).offset(16.0f);
        make.width.height.equalTo(@13.0f);
    }];
    
    [_shortTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
       make.left.equalTo(self.iconImageView.mas_right).offset(5.0f);
        make.right.equalTo(self.contentView).offset(-15.0f);
    }];
    

    [_youhuiquanBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(13.0f);
        make.height.equalTo(@16.0f);
        make.width.equalTo(@65.0f);
    }];
    
    [_youhuiquan mas_makeConstraints:^(MASConstraintMaker *make) {
       make.center.equalTo(self.youhuiquanBg);
    }];
    
    [_saleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView).offset(70.0f);
        make.bottom.equalTo(self.youhuiquanBg);
        make.height.equalTo(@15.0f);
    }];
    
    [_favBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.contentView).offset(-15.0f);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(13.0f);
        make.height.equalTo(@18.0f);
        make.width.equalTo(@45.0f);
    }];
    
    [_yenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.bottom.equalTo(self.leftImageView.mas_bottom).offset(-30.0f);
    }];
    
    [_originPricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yenLabel.mas_right).offset(5.0f);
        make.bottom.equalTo(self.yenLabel);
    }];
    
    
    [_yujiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.iconImageView);
        make.bottom.equalTo(self.contentView).offset(-6.0f);
    }];
    
    [_yujiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.yujiImageView);
        make.left.equalTo(self.yujiImageView).offset(3.0f);
        make.right.equalTo(self.yujiImageView).offset(-3.0f);
    }];
    
    [_shengjiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yujiImageView.mas_right).offset(5.0f);
        make.bottom.equalTo(self.contentView).offset(-6.0f);
    }];
    
    [_shengjiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.shengjiImageView);
        make.left.equalTo(self.shengjiImageView).offset(3.0f);
        make.right.equalTo(self.shengjiImageView).offset(-3.0f);
    }];
    
}

-(void)fav{
    TMDiskCache * cache = [[TMCache sharedCache] diskCache];
    NSArray *object = (NSArray *)[cache objectForKey:@"favList"];
    if (object) {
        id find = [object find:^BOOL(GoodsModel* obj) {
            return obj.itemId.integerValue == self.model.itemId.integerValue;
        }];
        if (!find) {
            NSMutableArray *ar = [NSMutableArray arrayWithArray:object];
            [ar addObject:self.model];
            [cache setObject:ar forKey:@"favList"];
        }
    }else{
        NSArray *array = @[self.model];
        [cache setObject:array forKey:@"favList"];
    }
    _favBtn.selected = YES;
}

-(void)setModel:(GoodsModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    
    if (model.platformId == 1) {
        if (model.shopType.integerValue == 0) {
            _iconImageView.image = [UIImage imageNamed:@"tao"];
        }else{
            _iconImageView.image = [UIImage imageNamed:@"mao"];
        }
    }else if(model.platformId == 2){
        _iconImageView.image = [UIImage imageNamed:@"jing"];
    }

    _shortTitleLabel.text = model.itemShorTtitle;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.itemPic]];
    if (model.itemSale.integerValue > 10000) {
        _saleCount.text = [NSString stringWithFormat:@"%.2f万人已买",model.itemSale.floatValue/10000];
    }else{
        _saleCount.text = [NSString stringWithFormat:@"%@人已买",model.itemSale];
    }
    
    
    
    if(model.couponPrice){
        _originPricelabel.hidden = NO;
         _youhuiquan.hidden = NO;
        _youhuiquan.text = [NSString stringWithFormat:@"%ld元券",(long)model.couponPrice.integerValue];
        NSString *text = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue - model.couponPrice.floatValue];;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:11.0f] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:18.0] range:NSMakeRange(1, text.length - 1)];
        _yenLabel.attributedText = str;
        
        NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                      range:NSMakeRange(0, oldPrice.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithString:@"#9D9D9D"]
                      range:NSMakeRange(0, oldPrice.length)];
        [_originPricelabel setAttributedText:attri];
        
        [_saleCount mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView).offset(70.0f);
        }];
    }else{
        _originPricelabel.hidden = YES;
        _youhuiquan.hidden = YES;
        
        [_saleCount mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView);
        }];
        
        NSString *text = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue];;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:11.0f] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:MediumFont size:18.0] range:NSMakeRange(1, text.length - 1)];
        _yenLabel.attributedText = str;
    }
    
    
    if(model.moretkMoney){
        _shengjiImageView.hidden = NO;
        _shengjiLabel.text =[NSString stringWithFormat:@"升级赚￥%.2f",model.moretkMoney.floatValue];
    }else{
        _shengjiImageView.hidden = YES;
    }
    
    if(model.tkMoney){
        _yujiImageView.hidden = NO;
        _yujiLabel.text =[NSString stringWithFormat:@"预计赚￥%.2f",model.tkMoney.floatValue];
        [_shengjiImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.yujiImageView.mas_right).offset(5.0f);
            make.bottom.equalTo(self.contentView).offset(-6.0f);
        }];
    }else{
        _yujiImageView.hidden = YES;
        [_shengjiImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView);
            make.bottom.equalTo(self.contentView).offset(-6.0f);
        }];
    }
    
    _videoUrl = model.videoUrl;
    if (model.videoUrl) {
        _leftImageView.userInteractionEnabled = YES;
        _playerBtn.hidden = NO;
    }else{
        _playerBtn.hidden = YES;
        _leftImageView.userInteractionEnabled = NO;
    }
}


-(void)showVideoView{
   VideoController *videoPlayerController = [[VideoController alloc] init];
   videoPlayerController.videoPath = _videoUrl;
   [[URLNavigation navigation].currentNavigationViewController pushViewController:videoPlayerController animated:YES];
}

@end
