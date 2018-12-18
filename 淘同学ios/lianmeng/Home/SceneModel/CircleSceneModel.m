//  CircleSceneModel.m
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.

#import "CircleSceneModel.h"

@implementation CircleSceneModel

/**
  初始化加载scenceModel
 */
-(void)loadSceneModel
{
    [super loadSceneModel];
    [self.action useCache];
    _dataModel = nil;
    @weakify(self);
    _request = [MomentListRequest RequestWithBlock:^{
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
         NSLog(@"data:%@",[self.request.output objectForKey:@"data"]);
         self.dataModel = [[CircleListModel alloc] initWithDictionary:[self.request.output objectForKey:@"data"] error:&error];//Model的ORM操作，dictionary to object
     }];
}
@end
