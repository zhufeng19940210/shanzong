//  HeaderView.h
//  lianmeng
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import <UIKit/UIKit.h>

@interface HeaderView : UICollectionReusableView
-(void)reloadBannerData:(NSArray *)bannerList;
-(void)reloadFirstView:(NSString *)imgUrl;
@end
