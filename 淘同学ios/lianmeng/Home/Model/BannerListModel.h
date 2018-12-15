//
//  BannerLisModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/7.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"
@interface BannerModel : JSONModel
@property(nonatomic,copy)NSString *bannerUrl;
@property(nonatomic,copy)NSString *bannerId;
@property(nonatomic,copy)NSString<Optional> *refUrl;
@property(nonatomic,retain)NSNumber<Optional> *platformId;
@property(nonatomic,copy)NSString<Optional> *itemId;
@property(nonatomic,retain)NSNumber<Optional> *type;

@end

@protocol BannerModel
@end

@interface BannerListModel : JSONModel
@property(nonatomic,retain)NSArray<BannerModel> *list;
@end
