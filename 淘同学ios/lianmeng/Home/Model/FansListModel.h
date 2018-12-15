//
//  FansList.h
//  lianmeng
//
//  Created by zhuchao on 2018/6/28.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface FansModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *username;
@property(nonatomic,copy)NSString<Optional> *nickName;
@property(nonatomic,retain)NSNumber *userId;
@property(nonatomic,retain)NSNumber *fansNum;
@property(nonatomic,copy)NSString<Optional> *headimgUrl;
@property(nonatomic,retain)NSNumber *createTime;

@end

@protocol FansModel
@end

@interface FansListModel : JSONModel
@property(nonatomic,strong)NSArray<FansModel> *list;
@end
