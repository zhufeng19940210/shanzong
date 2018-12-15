//
//  ImageShowView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "ImageShowView.h"
#import "ImageShowCell.h"
@interface ImageShowView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,retain)NSArray *array;
@property(nonatomic,retain)NSIndexPath *selectedIndex;
@end
@implementation ImageShowView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _selectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        _array = [NSArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[ImageShowCell class] forCellWithReuseIdentifier:@"ImageShowCell"];
    }
    return self;
}

-(void)reloadImages:(NSArray *)list{
    if(!list) return;
    _array = list;
    [self reloadData];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageShowCell" forIndexPath:indexPath];
    [cell setImageURL:[_array objectAtIndex:indexPath.row]];
    if (_selectedIndex.row == indexPath.row) {
        [cell selectImage];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = indexPath;
    [collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return _array.count;
}

-(NSString *)getSelectedImage{
    if(_array.count == 0) return @"";
    return [_array objectAtIndex:_selectedIndex.row];
}




@end
