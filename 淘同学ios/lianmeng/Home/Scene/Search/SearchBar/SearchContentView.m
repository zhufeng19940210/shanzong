//
//  SearchContentView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/12.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SearchContentView.h"
#import <Masonry/Masonry.h>
#import <EasyIOS/EasyIOS.h>
#import "SearchItemCell.h"
#import "SearchListScene.h"

@interface SearchContentView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *deleteButton;
@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *list;
@end
@implementation SearchContentView

-(instancetype)init{
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithString:@"#323232"];
        _titleLabel.text = @"搜索记录";
        _titleLabel.font = [UIFont fontWithName:RegularFont size:18.0f];
        [self addSubview:_titleLabel];
        
        _deleteButton = [[UIButton alloc]init];
        [_deleteButton setImage:[UIImage imageNamed:@"Garbage"] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
        [_deleteButton addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
        
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.minimumLineSpacing = 10;//行间距
        flow.minimumInteritemSpacing = 10;//列间距
        flow.itemSize = CGSizeMake(58.0f, 27.0f);
        flow.sectionInset = UIEdgeInsetsZero;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
        [self addSubview:_collectionView];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[SearchItemCell class] forCellWithReuseIdentifier:@"SearchItemCell"];
        
        [self loadAutoLayout];
        
        @weakify(self);
        [[TMCache sharedCache] objectForKey:@"keywords" block:^(TMCache *cache, NSString *key, NSArray * object) {
            @strongify(self);
            if (object) {
                self.list = [NSMutableArray arrayWithArray:object];
                [self.collectionView reloadData];
            }
        }];
        
    }
    return self;
}


-(void)loadAutoLayout{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0f);
        make.top.equalTo(self).offset(15.0f);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self).offset(-15.0f);
       make.centerY.equalTo(self.titleLabel);
       make.height.width.equalTo(@26.0f);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15.0f);
        make.left.equalTo(self).offset(15.0f);
        make.right.equalTo(self).offset(-15.0f);
        make.bottom.equalTo(self);
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchItemCell" forIndexPath:indexPath];
   [cell setTitle:[ self.list safeObjectAtIndex:indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate kewordDidTouched:[[ self.list safeObjectAtIndex:indexPath.row] copy]];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.list?self.list.count:0;
}

-(void)addKeyWord:(NSString *)keyword{
    if (self.list) {
        if (![self.list containsObject:keyword]) {
            [self.list pushHead:keyword];
            [[TMCache sharedCache] setObject:self.list forKey:@"keywords"];
            [self.collectionView reloadData];
        }
    }else{
        self.list = [NSMutableArray arrayWithObject:keyword];
        [[TMCache sharedCache] setObject:self.list forKey:@"keywords"];
        [self.collectionView reloadData];
    }
}

-(void)clearAll{
    [[TMCache sharedCache] removeObjectForKey:@"keywords"];
    self.list = [NSMutableArray array];
    [self.collectionView reloadData];
}
@end
