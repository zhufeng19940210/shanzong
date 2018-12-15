
#import "DetailBottomView.h"
#import <Masonry/Masonry.h>
#import "UserCenter.h"
#import "WechatLoginScene.h"
#import "LMNavigationController.h"



@interface DetailBottomView()
@property(nonatomic,strong)UIButton *fav;
@property(nonatomic,strong)UILabel *favLabel;
@property(nonatomic,strong)UIImageView *zimai;
@property(nonatomic,strong)UIImageView *fenxiang;
@property(nonatomic,strong)UILabel *zimaiLabel;
@property(nonatomic,strong)UILabel *zimaiMoney;
@property(nonatomic,strong)UILabel *fenxiangLabel;
@property(nonatomic,strong)UILabel *fenxiangMoney;
@end
@implementation DetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
                self.backgroundColor = [UIColor colorWithString:@"white"];

        _fav = [[UIButton alloc]init];
        [self addSubview:_fav];
        [_fav setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];

        _favLabel = [[UILabel alloc]init];
        [self addSubview:_favLabel];
        _favLabel.text = @"收藏";
        _favLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10.0f];

        _zimai = [[UIImageView alloc]init];
        _zimai.userInteractionEnabled = YES;
        [self addSubview:_zimai];
        _zimai.image = [UIImage imageNamed:@"zimai"];

        _fenxiang = [[UIImageView alloc]init];
        _fenxiang.userInteractionEnabled = YES;
        [self addSubview:_fenxiang];
        _fenxiang.image = [UIImage imageNamed:@"fenxiang"];

        _zimaiLabel = [[UILabel alloc]init];
        [self addSubview:_zimaiLabel];
        _zimaiLabel.text = @"自买省";
        _zimaiLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0f];
        _zimaiLabel.textColor = [UIColor colorWithString:@"white"];

        _zimaiMoney = [[UILabel alloc]init];
        [self addSubview:_zimaiMoney];
        _zimaiMoney.text = @"1.43";
        _zimaiMoney.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        _zimaiMoney.textColor = [UIColor colorWithString:@"white"];

        _fenxiangLabel = [[UILabel alloc]init];
        [self addSubview:_fenxiangLabel];
        _fenxiangLabel.text = @"分享";
        _fenxiangLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0f];
        _fenxiangLabel.textColor = [UIColor colorWithString:@"white"];

        _fenxiangMoney = [[UILabel alloc]init];
        [self addSubview:_fenxiangMoney];
        _fenxiangMoney.text = @"1.43";
        _fenxiangMoney.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        _fenxiangMoney.textColor = [UIColor colorWithString:@"white"];


        [self loadAutoLayout];
        
        [_fav addTarget:self action:@selector(favAction) forControlEvents:UIControlEventTouchUpInside];
        [_zimai addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zimaiAction)]];
        [_fenxiang addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareAction)]];
    }
    return self;
}

-(void)loadAutoLayout{
    
    [_fav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8.0f);
        make.left.equalTo(self).offset(30.0f);
	    }];

    [_favLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fav.mas_bottom).offset(4.0f);
        make.centerX.equalTo(self.fav).offset(0.0f);
	    }];

    [_zimai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.height.equalTo(@49.0f);
	    }];

    [_fenxiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.zimai.mas_left);
        make.top.equalTo(self);
        make.height.equalTo(@49.0f);
	    }];

    [_zimaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.zimai).offset(0.0f);
        make.bottom.equalTo(self.zimai).offset(-5.0f);
	    }];

    [_zimaiMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.zimai).offset(0.0f);
        make.top.equalTo(self.zimai).offset(5.0f);
	    }];

    [_fenxiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fenxiang).offset(0.0f);
        make.bottom.equalTo(self.fenxiang).offset(-5.0f);
	    }];

    [_fenxiangMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fenxiang).offset(0.0f);
        make.top.equalTo(self.fenxiang).offset(5.0f);
	    }];
}

-(void)favAction{
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
    _favLabel.text = @"已收藏";
}



-(void)zimaiAction{
    if(![[UserCenter sharedInstance] checkLogin]){
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"需要登录" message:@"此操作需要登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIViewController *vc = [[LMNavigationController alloc]initWithRootViewController:[[WechatLoginScene alloc]init]];
            [[URLNavigation navigation].currentViewController presentViewController:vc animated:YES completion:nil];
        }]];
        [[URLNavigation navigation].currentViewController presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (self.delegate) {
        [self.delegate buyAction];
    }
}

-(void)shareAction{
    if(![[UserCenter sharedInstance] checkLogin]){
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"需要登录" message:@"此操作需要登录，是否前往登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIViewController *vc = [[LMNavigationController alloc]initWithRootViewController:[[WechatLoginScene alloc]init]];
            [[URLNavigation navigation].currentViewController presentViewController:vc animated:YES completion:nil];
        }]];
        [[URLNavigation navigation].currentViewController presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (self.delegate) {
        [self.delegate shareAction];
    }
}
-(void)setModel:(GoodsModel *)model{
    _model = model;
    if (model) {
        if (_model.tkMoney.floatValue > 0) {
            NSString *text =[NSString stringWithFormat:@"￥%.2f",_model.tkMoney.floatValue];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:10.0f] range:NSMakeRange(0, 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:16.0] range:NSMakeRange(1, text.length - 1)];
            _fenxiangMoney.attributedText = str;
        }else{
            _fenxiangMoney.text = @"";
        }

        if(_model.couponPrice){
            NSString *text2 =[NSString stringWithFormat:@"￥%.2f",_model.couponPrice.floatValue];
            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:text2];
            [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:10.0f] range:NSMakeRange(0, 1)];
            [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:BoldFont size:16.0] range:NSMakeRange(1, text2.length - 1)];
            _zimaiMoney.attributedText = str2;
        }

    }
}

@end
	
