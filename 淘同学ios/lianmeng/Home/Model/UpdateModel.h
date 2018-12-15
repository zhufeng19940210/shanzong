//
//  UpdateModel.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "JSONModel.h"

@interface UpdateModel : JSONModel
@property(nonatomic,retain)NSNumber *userLevel;
@property(nonatomic,copy)NSString *picUrl;
@property(nonatomic,copy)NSString *userUpLevelText;
@end
