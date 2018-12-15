//
//  FindTimeSegsRequest.h
//  lianmeng
//
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "Request.h"

@interface FindTimeSegsRequest : Request

@end
@interface TimeSegsListRequest : Request
@property(nonatomic,retain)NSNumber *buyDate;
@property(nonatomic,retain)NSNumber *userLevel;
@property(nonatomic,retain)NSNumber *page;
@end
