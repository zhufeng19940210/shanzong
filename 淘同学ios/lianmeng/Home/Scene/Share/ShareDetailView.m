
#import "ShareDetailView.h"
#import <Masonry/Masonry.h>

@interface ShareDetailView()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *sale;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UILabel *originPrice;
@property(nonatomic,strong)UIImageView *youhuiquanbg;
@property(nonatomic,strong)UILabel *youhuiquan;
@property(nonatomic,strong)UIImageView *yujizhuanbg;
@property(nonatomic,strong)UILabel *yujizhuan;
@property(nonatomic,strong)UIView *blackView;
@property(nonatomic,strong)UILabel *shareTextTitle;
@property(nonatomic,strong)UILabel *shareText;
@end
@implementation ShareDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _icon = [[UIImageView alloc]init];
        [self addSubview:_icon];
        _icon.image = [UIImage imageNamed:@"taobao-share"];
        
        _title = [[UILabel alloc]init];
        [self addSubview:_title];
        _title.text = @"夏季必备";
        _title.font = [UIFont fontWithName:RegularFont size:14.0f];
        _title.textColor = [UIColor colorWithString:@"rgb(2,2,2)"];
        
        _sale = [[UILabel alloc]init];
        [self addSubview:_sale];
        _sale.text = @"销量 0";
        _sale.font = [UIFont fontWithName:RegularFont size:13.0f];
        _sale.textColor = [UIColor colorWithString:@"rgb(157,157,157)"];
        
        _price = [[UILabel alloc]init];
        [self addSubview:_price];
        _price.text = @"￥2.9";
        _price.font =[UIFont fontWithName:MediumFont size:12.0f];
        _price.textColor = [UIColor colorWithString:@"#FB406D"];
        
        _originPrice = [[UILabel alloc]init];
        [self addSubview:_originPrice];
        
        _originPrice.font = [UIFont fontWithName:RegularFont size:10.0f];
        _originPrice.textColor = [UIColor colorWithString:@"rgb(157,157,157)"];
        
        NSString *price =@"￥5.9";
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:price];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, price.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:_originPrice.textColor range:NSMakeRange(0, price.length)];
        [_originPrice setAttributedText:attri];
        
        
        _youhuiquanbg = [[UIImageView alloc]init];
        [self addSubview:_youhuiquanbg];
        _youhuiquanbg.image = [UIImage imageNamed:@"youhuiquankuang"];
        
        _youhuiquan = [[UILabel alloc]init];
        [self addSubview:_youhuiquan];
        _youhuiquan.text = @"3元优惠券";
        _youhuiquan.textColor = [UIColor colorWithString:@"white"];
        _youhuiquan.font = [UIFont fontWithName:RegularFont size:12.0f];
        
        _yujizhuanbg = [[UIImageView alloc]init];
        [self addSubview:_yujizhuanbg];
        _yujizhuanbg.image = [UIImage imageNamed:@"yujizhuankuang"];
        
        _yujizhuan = [[UILabel alloc]init];
        [self addSubview:_yujizhuan];
        _yujizhuan.text = @"预计赚0.66元";
        _yujizhuan.textColor = [UIColor colorWithString:@"white"];
        _yujizhuan.font = [UIFont systemFontOfSize:12.0f];
        
        _blackView = [[UIView alloc]init];
        [self addSubview:_blackView];
        _blackView.backgroundColor = [UIColor colorWithString:@"black"];
        
        _shareTextTitle = [[UILabel alloc]init];
        [self addSubview:_shareTextTitle];
        _shareTextTitle.text = @"分享文案";
        _shareTextTitle.textColor = [UIColor colorWithString:@"rgb(2,2,2)"];
        _shareTextTitle.font = [UIFont systemFontOfSize:18.0f];
        
        _shareText = [[UILabel alloc]init];
        [self addSubview:_shareText];
        _shareText.numberOfLines = 0;
        _shareText.text = @"分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案分享文案";
        _shareText.font = [UIFont systemFontOfSize:14.0f];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30.0f);
        make.left.equalTo(self).offset(15.0f);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.icon).offset(0.0f);
        make.left.equalTo(self.icon.mas_right).offset(10.0f);
        make.right.equalTo(self).offset(-26.0f).priorityLow();
        make.width.greaterThanOrEqualTo(@100.0f);
    }];
    
    [_sale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon).offset(0.0f);
        make.top.equalTo(self.icon.mas_bottom).offset(12.5f);
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon).offset(0.0f);
        make.top.equalTo(self.sale.mas_bottom).offset(15.0f);
    }];
    
    [_originPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.price.mas_right).offset(2.0f);
        make.bottom.equalTo(self.price).offset(0.0f);
    }];
    
    [_youhuiquanbg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon).offset(0.0f);
        make.top.equalTo(self.price.mas_bottom).offset(7.5f);
        make.height.equalTo(@24.0f);
    }];
    
    [_youhuiquan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.youhuiquanbg).offset(5.0f);
        make.top.equalTo(self.youhuiquanbg).offset(5.0f);
        make.right.equalTo(self.youhuiquanbg).offset(-5.0f);
        make.bottom.equalTo(self.youhuiquanbg).offset(-5.0f);
    }];
    
    [_yujizhuanbg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.youhuiquanbg).offset(0.0f);
        make.right.equalTo(self).offset(-26.0f);
         make.height.equalTo(@24.0f);
    }];
    
    [_yujizhuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yujizhuanbg).offset(5.0f);
        make.top.equalTo(self.yujizhuanbg).offset(5.0f);
        make.right.equalTo(self.yujizhuanbg).offset(-5.0f);
        make.bottom.equalTo(self.yujizhuanbg).offset(-5.0f);
    }];
    
    [_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.0f);
        make.top.equalTo(self.price.mas_bottom).offset(50.0f);
        make.width.equalTo(@4.0f);
        make.height.equalTo(@20.0f);
    }];
    
    [_shareTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blackView.mas_right).offset(5.0f);
        make.centerY.equalTo(self.blackView).offset(0.0f);
    }];
    
    [_shareText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35.0f);
        make.top.equalTo(self.shareTextTitle.mas_bottom).offset(25.0f);
        make.bottom.equalTo(self).offset(0.0f);
        make.right.equalTo(self).offset(-35.0f);
    }];
}

-(void)reloadData:(GoodsModel *)model{
    if(!model) return;
    
    _title.text = model.itemShorTtitle;
    if(model.couponPrice){
        _youhuiquan.text = [NSString stringWithFormat:@"%.0f元优惠券",model.couponPrice.floatValue];
        
        NSString *price =[NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:price];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, price.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:_originPrice.textColor range:NSMakeRange(0, price.length)];
        [_originPrice setAttributedText:attri];
        
        _price.text = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue - model.couponPrice.floatValue];
    }else{
        _youhuiquanbg.hidden = YES;
        _youhuiquan.hidden = YES;
        _originPrice.hidden = YES;
        _price.text = [NSString stringWithFormat:@"￥%.2f",model.itemPrice.floatValue];
    }
    
    _shareText.text = model.itemDesc;
    
    if(model.tkMoney){
        _yujizhuan.text = [NSString stringWithFormat:@"预计赚%.2f元",model.tkMoney.floatValue];
    }else{
        _yujizhuan.text = @"预计赚0.66元";
        _yujizhuan.hidden = YES;
        _yujizhuanbg.hidden = YES;
    }
    
    _sale.text = [NSString stringWithFormat:@"销量 %ld",(long)model.itemSale.integerValue];
    
    if (model.platformId == 1) {
        _icon.image = [UIImage imageNamed:@"taobao-share"];
    }else{
        _icon.image = [UIImage imageNamed:@"jingdong-share"];
    }
}
@end

