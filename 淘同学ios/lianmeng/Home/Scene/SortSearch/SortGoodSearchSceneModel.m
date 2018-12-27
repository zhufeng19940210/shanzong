//  SortGoodSearchSceneModel.m
//  lianmeng
//  Created by zhufeng on 2018/12/27.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "SortGoodSearchSceneModel.h"

@implementation SortGoodSearchSceneModel

/**
  * 初始化加载ScenenModel
 */
-(void)loadSceneModel
{
    [super loadSceneModel];
    [self.action useCache];
    
    _dataModel = nil;
    @weakify(self);
    _request = [SortGoodSearchRequest RequestWithBlock:^{
        @strongify(self);
        [self SEND_IQ_ACTION:self.request];
    }];
    
    [[RACObserve(self.request, state) //监控 网络请求的状态
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          return self.request.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error;
         
         self.dataModel = [[GoodsListModel alloc] initWithDictionary:[self.request.output objectForKey:@"data"] error:&error];//Model的ORM操作，dictionary to object
         
         if (error) {
             NSLog(@"%@",error);
         }
     }];
}
@end
