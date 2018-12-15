//
//  TimeSelectView.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TimeSelectView.h"
#import <Masonry/Masonry.h>


@interface TimeSelectItem()
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *statusLabel;

@end
@implementation TimeSelectItem

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont fontWithName:MediumFont size:17.0f];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.text = @"14:00";
        [self addSubview:_timeLabel];
        
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = [UIFont fontWithName:MediumFont size:12.0f];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.text = @"已开始";
        [self addSubview:_statusLabel];
        
        [self loadAutoLayout];
        
    }
    return self;
}

-(void)loadAutoLayout{
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(8.0f);
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(2.0f);
    }];
}

-(void)setTime:(NSString *)time setStatus:(NSNumber *)status{
    _timeLabel.text = time;
    if (status.intValue == -1) {
        _statusLabel.text = @"已开抢";
    }else if (status.intValue == 0) {
        _statusLabel.text = @"抢购进行中";
    }else if (status.intValue == 1) {
        _statusLabel.text = @"即将开场";
    }
}
@end



@interface TimeSelectView()
@property(nonatomic,retain)UIImageView *bgView;
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIImageView *selectedView;
@end
@implementation TimeSelectView

-(instancetype)init{
    self = [super init];
    if (self) {
        _bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shijianbeijing"]];
        [self addSubview:_bgView];
        

        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _selectedView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qianggouingK"]];
        _selectedView.frame = CGRectMake(0, 0, 75.0f, 55.0f);
        [_scrollView addSubview:_selectedView];
        
        [self loadAutoLayout];
    }
    return self;
}

-(void)loadAutoLayout{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-5.0f);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self);
    }];
}

-(void)loadData:(NSArray *)list{
    for (UIView *view in _scrollView.subviews) {
        if ([view isKindOfClass:[TimeSelectItem class]]) {
            [view removeFromSuperview];
        }
    }
    for (int i=0; i<list.count; i++) {
        TimeSegModel *model = list[i];
        TimeSelectItem * item = [[TimeSelectItem alloc]initWithFrame:CGRectMake(i*75.0f, 0, 75.0f, 55.0f)];
        item.tag = i;
        [item setTime:model.buyTimeSeg setStatus: model.rushBuyStatus];
        if(model.selected.intValue == 1){
            [self setItemSelectedAtIndex:i];
            if (self.delegate) {
                [self.delegate didSelectItemAtIndex:i];
            }
        }
        [_scrollView addSubview:item];
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTime:)]];
    }
    _scrollView.contentSize = CGSizeMake(list.count*75.0f, 55.0f);
}

-(void)setItemSelectedAtIndex:(NSUInteger)idx{
    _selectedView.frame = CGRectMake(idx*75.0f, 0, 75.0f, 55.0f);
    [_scrollView scrollRectToVisible:_selectedView.frame animated:YES];
}

-(void)touchTime:(UITapGestureRecognizer *)gesture{
    NSUInteger idx = gesture.view.tag;
    [self setItemSelectedAtIndex:idx];
    if (self.delegate) {
        [self.delegate didSelectItemAtIndex:idx];
    }
}
@end

