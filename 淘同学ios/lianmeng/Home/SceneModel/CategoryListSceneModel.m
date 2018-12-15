//
//  CategoryListSceneModel.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/18.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "CategoryListSceneModel.h"

@implementation CategoryListSceneModel
/**
 *   初始化加载SceneModel
 */
-(void)loadSceneModel{
    [super loadSceneModel];
    
    [self.action useCache];
    _dataModel = nil;
    @weakify(self);
    _request = [CategoryListRequest RequestWithBlock:^{
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
