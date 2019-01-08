//
//  ShareDataModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/8/4.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"
#import "GoodsListModel.h"
#import <UIKit/UIKit.h>
#import "CircleListModel.h"
@interface ShareDataItemModel : JSONModel
@property(nonatomic,retain)CircleModel *model;
@property(nonatomic,retain)GoodsModel *itmeInfo;
@property(nonatomic,copy)NSString *shareUrl;
-(UIImage *)genImage;
-(UIImage *)genImage2;
@end

@protocol ShareDataItemModel
@end

@interface ShareDataModel : JSONModel
@property(nonatomic,retain)NSArray *picUrl;
@property(nonatomic,retain)NSArray<ShareDataItemModel> *item;
@end
