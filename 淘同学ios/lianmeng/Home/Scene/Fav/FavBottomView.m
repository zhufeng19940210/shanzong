//
//  FavBottomView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/20.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FavBottomView.h"
#import <Masonry/Masonry.h>

@interface FavBottomView()
@property(nonatomic,retain)UIButton *selectButton;
@property(nonatomic,retain)UILabel *qxLabel;
@property(nonatomic,retain)UIButton *shareWx;
@property(nonatomic,retain)UIButton *shareTimeLine;

@end
@implementation FavBottomView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _selectButton = [[UIButton alloc]init];
        [_selectButton setImage:[UIImage imageNamed:@"bugouxuan"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"gouxuan"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(touchSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectButton];
        
        _qxLabel = [[UILabel alloc]init];
        _qxLabel.text = @"全选";
        _qxLabel.font = [UIFont fontWithName:RegularFont size:14.0f];
        [self addSubview:_qxLabel];
        
        _shareWx = [[UIButton alloc]init];
        [_shareWx setImage:[UIImage imageNamed:@"share-wx"] forState:UIControlStateNormal];
        [self addSubview:_shareWx];
        [_shareWx addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
        
        _shareTimeLine = [[UIButton alloc]init];
        [_shareTimeLine setImage:[UIImage imageNamed:@"share-timeline"] forState:UIControlStateNormal];
        [self addSubview:_shareTimeLine];
        [_shareTimeLine addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)doShare{
    if (self.delegate) {
        [self.delegate share];
    }
}
-(void)loadAutoLayout{
    [_shareTimeLine mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.right.equalTo(self);
    }];
    
    [_shareWx mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self);
       make.right.equalTo(self.shareTimeLine.mas_left);
    }];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.shareTimeLine);
        make.left.equalTo(self).offset(15.0f);
    }];
    
    [_qxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.selectButton);
        make.left.equalTo(self.selectButton.mas_right).offset(8.0f);
    }];
}

-(void)touchSelect:(UIButton *)btn{
    btn.selected = !btn.selected;
    if(self.delegate){
        [self.delegate selectAll:btn.selected];
    }
}

@end
