
#import "DetailHeaderView.h"
#import <Masonry/Masonry.h>

@interface DetailHeaderView()
@property(nonatomic,strong)UIImageView *topImage;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *platIcon;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UIImageView *quanhoujia;
@property(nonatomic,strong)UILabel *originPrice;
@property(nonatomic,strong)UILabel *saleNum;
@property(nonatomic,strong)UIView *youhuiquanView;
@property(nonatomic,strong)UIImageView *youhuiquan;
@property(nonatomic,strong)UILabel *youhuiquanTitle;
@property(nonatomic,strong)UILabel *youhuiquanTime;
@property(nonatomic,strong)UILabel *rest;
@property(nonatomic,strong)UIButton *takeYHQ;


@end
@implementation DetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithString:@"#EEEEEE"];

        _topImage = [[UIImageView alloc]init];
        [self addSubview:_topImage];

        _bgView = [[UIView alloc]init];
        [self addSubview:_bgView];
        _bgView.backgroundColor = [UIColor colorWithString:@"white"];

        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"            这里是标题";

        _platIcon = [[UIImageView alloc]init];
        [self addSubview:_platIcon];
        _platIcon.image = [UIImage imageNamed:@"taobao-share"];

        _price = [[UILabel alloc]init];
        [self addSubview:_price];
        _price.textColor = [UIColor colorWithString:@"rgb(216,89,77)"];
        
        NSString *text = @"￥0.0";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:17.0f] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:23.0] range:NSMakeRange(1, text.length - 1)];
        _price.attributedText = str;
        

        _quanhoujia = [[UIImageView alloc]init];
        [self addSubview:_quanhoujia];
        _quanhoujia.image = [UIImage imageNamed:@"quanhoujia"];

        _originPrice = [[UILabel alloc]init];
        [self addSubview:_originPrice];
        _originPrice.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f];
        _originPrice.textColor = [UIColor colorWithString:@"#888888"];
        _originPrice.text = @"原价 ￥0.0";

        _saleNum = [[UILabel alloc]init];
        [self addSubview:_saleNum];
        _saleNum.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f];
        _saleNum.textColor = [UIColor colorWithString:@"#888888"];
        _saleNum.text = @"0 人已买";
        
        

        
        
        if(frame.size.height >=567.0f){
            _youhuiquanView = [[UIView alloc]init];
            [self addSubview:_youhuiquanView];
            _youhuiquanView.backgroundColor = [UIColor colorWithString:@"white"];
            
            _youhuiquan = [[UIImageView alloc]init];
            [self addSubview:_youhuiquan];
            _youhuiquan.image = [UIImage imageNamed:@"quanxiaobiao"];
            
            _youhuiquanTitle = [[UILabel alloc]init];
            [self addSubview:_youhuiquanTitle];
            _youhuiquanTitle.text = @"8元优惠券";
            _youhuiquanTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
            _youhuiquanTitle.textColor = [UIColor colorWithString:@"white"];
            
            _youhuiquanTime = [[UILabel alloc]init];
            [self addSubview:_youhuiquanTime];
            _youhuiquanTime.text = @"有效期: 2018.06.06-2018.06.11";
            _youhuiquanTime.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10.0f];
            _youhuiquanTime.textColor = [UIColor colorWithString:@"white"];
            
            _rest = [[UILabel alloc]init];
            [self addSubview:_rest];
            _rest.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f];
            _rest.textColor = [UIColor colorWithString:@"#333333"];
            _rest.text = @"* 优惠券剩余数量 0/0";
            _originPrice.hidden = YES;
            _quanhoujia.hidden = YES;
            
            _takeYHQ = [[UIButton alloc]init];
            [self addSubview:_takeYHQ];
            [_takeYHQ setTitle:@"立即领取" forState:UIControlStateNormal];
            _takeYHQ.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
            [_takeYHQ setTitleColor:[UIColor colorWithString:@"white"] forState:UIControlStateNormal];
            [_takeYHQ addTarget:self.delegate action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
        }
        [self loadAutoLayout:frame.size.height];
    }
    return self;
}

-(void)loadAutoLayout:(CGFloat)height{
    
    [_topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.0f);
        make.top.equalTo(self).offset(0.0f);
        make.right.equalTo(self).offset(0.0f);
        make.height.equalTo(@311.0f);
	    }];

    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.0f);
        make.top.equalTo(self.topImage.mas_bottom).offset(0.0f);
        make.right.equalTo(self).offset(0.0f);
        make.height.equalTo(@104.0f);
	    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0f);
        make.top.equalTo(self.bgView).offset(15.0f);
        make.right.equalTo(self).offset(-15.0f);
	    }];

    [_platIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).offset(0.0f);
        make.top.equalTo(self.titleLabel).offset(0.0f);
	    }];

    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).offset(0.0f);
        make.bottom.equalTo(self.bgView).offset(-15.0f);
	    }];

    [_quanhoujia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.price.mas_right).offset(11.0f);
        make.centerY.equalTo(self.price).offset(0.0f);
	    }];

    [_originPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.quanhoujia.mas_right).offset(11.0f);
        make.centerY.equalTo(self.price).offset(0.0f);
	    }];

    [_saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel).offset(0.0f);
        make.centerY.equalTo(self.price).offset(0.0f);
	    }];
    
    if(height >= 567.0f){
        [_youhuiquanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-10.0f);
            make.left.equalTo(self).offset(0.0f);
            make.right.equalTo(self).offset(0.0f);
            make.height.equalTo(@132.0f);
        }];
        
        [_youhuiquan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.youhuiquanView).offset(16.0f);
            make.centerX.equalTo(self.youhuiquanView).offset(0.0f);
        }];
        
        [_youhuiquanTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.youhuiquan).offset(-10.0f);
            make.centerX.equalTo(self.youhuiquan).offset(-70.0f);
        }];
        
        [_youhuiquanTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.youhuiquanTitle).offset(0.0f);
            make.bottom.equalTo(self.youhuiquan).offset(-10.0f);
        }];
        
        [_rest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.youhuiquan).offset(0.0f);
            make.top.equalTo(self.youhuiquan.mas_bottom).offset(13.0f);
        }];
        
        [_takeYHQ mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.youhuiquan);
            make.right.equalTo(self.youhuiquan.mas_right).offset(-40.0f);
        }];
    }
}

-(void)setModel:(GoodsModel *)model{
    _model = model;
    if (model) {
        
        if (model.platformId == 1) {
            _platIcon.image = [UIImage imageNamed:@"taobao-share"];
        }else if(model.platformId == 2){
            _platIcon.image = [UIImage imageNamed:@"jingdong-share"];
        }
        
        [_topImage sd_setImageWithURL:[NSURL URLWithString:model.itemPic]];
        _titleLabel.text = [NSString stringWithFormat:@"         %@", model.itemTitle];
        if (model.itemSale.integerValue > 10000) {
            _saleNum.text = [NSString stringWithFormat:@"%.2f万人已买",model.itemSale.floatValue/10000];
        }else{
            _saleNum.text = [NSString stringWithFormat:@"%@人已买",model.itemSale];
        }
        
        if(model.couponPrice){
            NSString *text =  [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue - model.couponPrice.floatValue];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:17.0f] range:NSMakeRange(0, 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:23.0] range:NSMakeRange(1, text.length - 1)];
            _price.attributedText = str;
            
            NSString *oldPrice = [NSString stringWithFormat:@"原价 ￥%.2f",model.itemPrice.floatValue];
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
            [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                          range:NSMakeRange(0, oldPrice.length)];
            [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithString:@"#888888"]
                          range:NSMakeRange(0, oldPrice.length)];
            [_originPrice setAttributedText:attri];
            
            _originPrice.hidden = NO;
            _quanhoujia.hidden = NO;
            
            
            _youhuiquanTitle.text = [NSString stringWithFormat:@"%1.0f 元优惠券",model.couponPrice.floatValue];
            if(model.platformId == 1){
                _youhuiquanTime.text = [NSString stringWithFormat:@"有效期：%@-%@",[TimeTool formatTime:model.couponStartTime.integerValue formatWith:@"yyyy.MM.dd"],[TimeTool formatTime:model.couponEndTime.integerValue formatWith:@"yyyy.MM.dd"]];
            }else{
                _youhuiquanTime.text = [NSString stringWithFormat:@"有效期：%@-%@",[TimeTool formatTime:model.couponStartTime.integerValue/1000 formatWith:@"yyyy.MM.dd"],[TimeTool formatTime:model.couponEndTime.integerValue/1000 formatWith:@"yyyy.MM.dd"]];
            }

            if (model.couponSurplusl && model.couponNum) {
                _rest.text = [NSString stringWithFormat:@"* 优惠券剩余数量 %@/%@",model.couponSurplusl,model.couponNum];
            }else{
                _rest.text = @"";
            }
        }else{
            NSString *text =  [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:17.0f] range:NSMakeRange(0, 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:23.0] range:NSMakeRange(1, text.length - 1)];
            _price.attributedText = str;
            
            _originPrice.hidden = YES;
            _quanhoujia.hidden = YES;
        }
    }
}
@end
	
