//
//  UserFansListSceneModel.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/28.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "UserFansListSceneModel.h"

@implementation UserFansListSceneModel
/**
 *   初始化加载SceneModel
 */
-(void)loadSceneModel{
    [super loadSceneModel];
    
    [self.action useCache];
    _dataModel = nil;
    @weakify(self);
    _request = [UserFansListRequest RequestWithBlock:^{
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
         
         self.dataModel = [[FansListModel alloc] initWithDictionary:@{@"list":[self.request.output objectForKey:@"data"]}
                                                              error:&error];//Model的ORM操作，dictionary to object
         
         if (error) {
             NSLog(@"%@",error);
         }
     }];
}
@end
