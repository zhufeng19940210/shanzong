//
//  ImageShowView.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageShowView : UICollectionView
-(void)reloadImages:(NSArray *)list;
-(NSString *)getSelectedImage;
@end
