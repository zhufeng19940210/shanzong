//
//  FansSummaryView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/24.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FansSummaryView.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
#import "FansListScene.h"

@interface FansSummaryView()
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *detailBtn;
@property(nonatomic,retain)UIImageView *circleBgView1;
@property(nonatomic,retain)UIImageView *circleBgView2;
@property(nonatomic,retain)UILabel *circleLabel1;
@property(nonatomic,retain)UILabel *circleValueLabel1;
@property(nonatomic,retain)UILabel *circleLabel2;
@property(nonatomic,retain)UILabel *circleValueLabel2;

@property(nonatomic,retain)UILabel *bottomLabel1;
@property(nonatomic,retain)UILabel *bottomLabel2;
@property(nonatomic,retain)UILabel *bottomLabel3;
@property(nonatomic,retain)UILabel *bottomLabel4;
@end
@implementation FansSummaryView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"tuandui-tb"];
        [self addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:BoldFont size:16.0f];
        _titleLabel.textColor = [UIColor colorWithString:@"rgb(137,80,243)"];
        _titleLabel.text = @"我的团队";
        [self addSubview:_titleLabel];
        
        _detailBtn = [[UIButton alloc]init];
        [_detailBtn setImage:[UIImage imageNamed:@"xiangxixinxi"] forState:UIControlStateNormal];
        [self addSubview:_detailBtn];
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithString:@"#EEEEEE"];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(35.0f);
            make.height.equalTo(@1.0f);
        }];
        
        _circleBgView1 = [[UIImageView alloc]init];
        _circleBgView1.image = [UIImage imageNamed:@"zongreshu"];
        [self addSubview:_circleBgView1];
        
        _circleBgView2 = [[UIImageView alloc]init];
        _circleBgView2.image = [UIImage imageNamed:@"zhishuzongjian"];
        [self addSubview:_circleBgView2];

        
        
        _circleLabel1 = [[UILabel alloc]init];
        _circleLabel1.font = [UIFont fontWithName:BoldFont size:16.0f];
        _circleLabel1.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
        _circleLabel1.textAlignment = NSTextAlignmentCenter;
        _circleLabel1.text = @"总人数";
        [_circleBgView1 addSubview:_circleLabel1];
        
        _circleValueLabel1 = [[UILabel alloc]init];
        _circleValueLabel1.font = [UIFont fontWithName:BoldFont size:16.0f];
        _circleValueLabel1.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
        _circleValueLabel1.textAlignment = NSTextAlignmentCenter;
        _circleValueLabel1.text = @"0人";
        [_circleBgView1 addSubview:_circleValueLabel1];
        
        _circleLabel2 = [[UILabel alloc]init];
        _circleLabel2.font = [UIFont fontWithName:BoldFont size:16.0f];
        _circleLabel2.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
        _circleLabel2.textAlignment = NSTextAlignmentCenter;
        _circleLabel2.text = @"直属团队";
        [_circleBgView2 addSubview:_circleLabel2];
        
        
        _circleValueLabel2 = [[UILabel alloc]init];
        _circleValueLabel2.font = [UIFont fontWithName:BoldFont size:16.0f];
        _circleValueLabel2.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
        _circleValueLabel2.textAlignment = NSTextAlignmentCenter;
        _circleValueLabel2.text = @"0人";
        [_circleBgView2 addSubview:_circleValueLabel2];
        
        UIView *lineView2 = [[UIView alloc]init];
        lineView2.backgroundColor = [UIColor colorWithString:@"#EEEEEE"];
        [self addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.circleBgView1.mas_bottom).offset(18.0f);
            make.height.equalTo(@1.0f);
        }];
        
        _bottomLabel1 = [[UILabel alloc]init];
        _bottomLabel1.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
        _bottomLabel1.textAlignment = NSTextAlignmentCenter;
        _bottomLabel1.numberOfLines = 2;
        [self setLabelSpace:_bottomLabel1 withValue:@"0人\n今日" withFont:[UIFont fontWithName:BoldFont size:16.0f]];
        [self addSubview:_bottomLabel1];
        
        _bottomLabel2 = [[UILabel alloc]init];
        _bottomLabel2.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
        _bottomLabel2.textAlignment = NSTextAlignmentCenter;
        _bottomLabel2.numberOfLines = 2;
        [self setLabelSpace:_bottomLabel2 withValue:@"0人\n昨日" withFont:[UIFont fontWithName:BoldFont size:16.0f]];
        [self addSubview:_bottomLabel2];
        
        _bottomLabel3 = [[UILabel alloc]init];
        _bottomLabel3.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
        _bottomLabel3.textAlignment = NSTextAlignmentCenter;
        _bottomLabel3.numberOfLines = 2;
        [self setLabelSpace:_bottomLabel3 withValue:@"0人\n昨日升级" withFont:[UIFont fontWithName:BoldFont size:16.0f]];
        [self addSubview:_bottomLabel3];
        
        _bottomLabel4 = [[UILabel alloc]init];
        _bottomLabel4.textColor = [UIColor colorWithString:@"rgb(64,64,64)"];
        _bottomLabel4.textAlignment = NSTextAlignmentCenter;
        _bottomLabel4.numberOfLines = 3;
        [self setLabelSpace:_bottomLabel4 withValue:@"0人\n直属团队下级" withFont:[UIFont fontWithName:BoldFont size:16.0f]];
        [self addSubview:_bottomLabel4];
        
        
        UIView *mdLine1 = [[UIView alloc]init];
        mdLine1.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self addSubview:mdLine1];
        
        [mdLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1.0f);
            make.left.equalTo(self.bottomLabel1.mas_right);
            make.height.equalTo(@60.0f);
            make.top.equalTo(self.bottomLabel1);
        }];
        
        UIView *mdLine2 = [[UIView alloc]init];
        mdLine2.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self addSubview:mdLine2];
        
        [mdLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1.0f);
            make.left.equalTo(self.bottomLabel2.mas_right);
            make.height.equalTo(@60.0f);
             make.top.equalTo(self.bottomLabel2);
        }];
        
        UIView *mdLine3 = [[UIView alloc]init];
        mdLine3.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        [self addSubview:mdLine3];
        
        [mdLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1.0f);
            make.left.equalTo(self.bottomLabel3.mas_right);
            make.height.equalTo(@60.0f);
             make.top.equalTo(self.bottomLabel3);
        }];
        
        
        [self loadAutoLayout];
        
        _circleBgView1.userInteractionEnabled = YES;
        [_circleBgView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFansList0)]];
        
        _circleBgView2.userInteractionEnabled = YES;
        [_circleBgView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFansList5)]];
        
        _bottomLabel1.userInteractionEnabled = YES;
        _bottomLabel2.userInteractionEnabled = YES;
        _bottomLabel3.userInteractionEnabled = YES;
        _bottomLabel4.userInteractionEnabled = YES;
        [_bottomLabel1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFansList1)]];
        [_bottomLabel2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFansList2)]];
        [_bottomLabel3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFansList3)]];
        [_bottomLabel4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFansList4)]];
        
        
    }
    return self;
}


-(void)loadAutoLayout{
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12.0f);
        make.top.equalTo(self).offset(10.0f);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(16.0f);
    }];
    
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.iconImageView);
        make.right.equalTo(self).offset(-10.0f);
    }];
    
    [_circleBgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self).offset(40.0f);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20.0f);
    }];
    
    [_circleBgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-40.0f);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20.0f);
    }];
    
    [_circleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.circleBgView1);
        make.centerY.equalTo(self.circleBgView1).offset(-15.0f);
    }];
    [_circleValueLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.circleBgView1);
        make.centerY.equalTo(self.circleBgView1).offset(15.0f);
    }];
    
    [_circleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.circleBgView2);
        make.centerY.equalTo(self.circleBgView2).offset(-15.0f);
    }];
    [_circleValueLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.circleBgView2);
        make.centerY.equalTo(self.circleBgView2).offset(15.0f);
    }];
    
    NSArray *list= @[_bottomLabel1,_bottomLabel2,_bottomLabel3,_bottomLabel4];
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.circleBgView1.mas_bottom).offset(40.0f);
    }];
    
    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1.0f leadSpacing:0 tailSpacing:0];
    
}

-(void)reloadData:(UserFansNumModel *)model{
    _circleValueLabel1.text = [NSString stringWithFormat:@"%@人",model.fansNumSum];
    _circleValueLabel2.text = [NSString stringWithFormat:@"%@人",model.belongNum];
   
    [self setLabelSpace:_bottomLabel1 withValue:[NSString stringWithFormat:@"%@人\n今日",model.todayNum] withFont:[UIFont fontWithName:BoldFont size:16.0f]];
    [self setLabelSpace:_bottomLabel2 withValue:[NSString stringWithFormat:@"%@人\n昨日",model.yestodayNum] withFont:[UIFont fontWithName:BoldFont size:16.0f]];
    [self setLabelSpace:_bottomLabel3 withValue:[NSString stringWithFormat:@"%@人\n昨日升级",model.yestodayupgradeNum] withFont:[UIFont fontWithName:BoldFont size:16.0f]];
    [self setLabelSpace:_bottomLabel4 withValue:[NSString stringWithFormat:@"%@人\n直属团队下级",model.secondhandNum] withFont:[UIFont fontWithName:BoldFont size:16.0f]];
}

-(void)showFansList0{
    FansListScene *scene = [[FansListScene alloc]init];
    scene.type = @0;
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}

-(void)showFansList1{
    FansListScene *scene = [[FansListScene alloc]init];
    scene.type = @1;
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}

-(void)showFansList2{
    FansListScene *scene = [[FansListScene alloc]init];
    scene.type = @2;
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}

-(void)showFansList3{
    FansListScene *scene = [[FansListScene alloc]init];
    scene.type = @3;
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}
-(void)showFansList4{
    FansListScene *scene = [[FansListScene alloc]init];
    scene.type = @4;
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}
-(void)showFansList5{
    FansListScene *scene = [[FansListScene alloc]init];
    scene.type = @5;
    [[URLNavigation navigation].currentNavigationViewController pushViewController:scene animated:YES];
}




-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentCenter;
    
    paraStyle.lineSpacing = 20.0f; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    
    //设置字间距 NSKernAttributeName:@1.5f
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    label.attributedText = attributeStr;
    
}
@end
