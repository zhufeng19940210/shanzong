//
//  TimeSegsListSceneModel.m
//  lianmeng
//
//  Created by zhuchao on 2018/7/31.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TimeSegsListSceneModel.h"

@implementation TimeSegsListSceneModel
/**
 *   初始化加载SceneModel
 */
-(void)loadSceneModel{
    [super loadSceneModel];
    
    [self.action useCache];
    
    _timeSegList = nil;
    @weakify(self);
    _timeSegsRequest = [FindTimeSegsRequest RequestWithBlock:^{
        @strongify(self);
        [self SEND_IQ_ACTION:self.timeSegsRequest];
    }];
    
    
    [[RACObserve(self.timeSegsRequest, state) //监控 网络请求的状态
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          return self.timeSegsRequest.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error;
         
         self.timeSegList = [[TimeSegListModel alloc] initWithDictionary:@{@"list":[self.timeSegsRequest.output objectForKey:@"data"]}
                                                               error:&error];//Model的ORM操作，dictionary to object
         
         if (error) {
             NSLog(@"%@",error);
         }
     }];
    
    
    _dataModel = nil;
    _request = [TimeSegsListRequest RequestWithBlock:^{
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
         
         self.dataModel = [[GoodsListModel alloc] initWithDictionary:[self.request.output objectForKey:@"data"]
                                                              error:&error];//Model的ORM操作，dictionary to object
         
         if (error) {
             NSLog(@"%@",error);
         }
     }];
}
@end
