//  SortTypenextModel.m
//  lianmeng
//  Created by zhufeng on 2018/12/17.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "SortTypenextModel.h"
#import "SortInfoModel.h"
#import <MJExtension.h>
@implementation SortTypenextModel

-(void)setInfo:(NSArray *)info
{
    NSMutableArray *arry = [NSMutableArray array];
    for (NSDictionary *dict in info) {
        [arry addObject:[SortInfoModel mj_objectWithKeyValues:dict]];
    }
    _info = arry;
}

//-(void)setDetails:(NSArray *)details
//{
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSDictionary *dict in details) {
//        [array addObject:[ZFDetailModel mj_objectWithKeyValues:dict]];
//    }
//    _details = array;
//}


@end
