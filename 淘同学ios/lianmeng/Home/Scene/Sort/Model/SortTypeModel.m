//  SortTypeModel.m
//  lianmeng
//  Created by zhufeng on 2018/12/17.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "SortTypeModel.h"
#import "SortTypenextModel.h"
#import <MJExtension.h>
@implementation SortTypeModel
-(void)setData:(NSArray *)data
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        [array addObject:[SortTypenextModel mj_objectWithKeyValues:dic]];
    }
    _data = array;
}
@end
