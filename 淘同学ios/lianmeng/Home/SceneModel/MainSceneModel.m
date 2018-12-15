//
//  MainSceneModel.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/6.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "MainSceneModel.h"

@implementation MainSceneModel
/**
 *   初始化加载SceneModel
 */
-(void)loadSceneModel{
    [super loadSceneModel];
    
    [self.action useCache];
    _dataModel = nil;
    @weakify(self);
    _likeRequest = [LikeItemListRequest RequestWithBlock:^{
        @strongify(self);
        [self SEND_IQ_ACTION:self.likeRequest];
    }];
    
    [[RACObserve(self.likeRequest, state) //监控 网络请求的状态
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          return self.likeRequest.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error;
         NSLog(@"likeRequest.data:%@",self.likeRequest.output);
         self.dataModel = [[GoodsListModel alloc] initWithDictionary:[self.likeRequest.output objectForKey:@"data"] error:&error];//Model的ORM操作，dictionary to object
     }];
    
    
    _bannerModel = nil;
    _bannerRequest = [BannerRequest RequestWithBlock:^{
        @strongify(self);
        [self SEND_IQ_ACTION:self.bannerRequest];
    }];
    
    [[RACObserve(self.bannerRequest, state) //监控 网络请求的状态
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          return self.bannerRequest.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error;
         NSLog(@"self.bannerRequest.output:%@",self.bannerRequest.output);
         self.bannerModel = [[BannerListModel alloc] initWithDictionary:@{@"list":[self.bannerRequest.output objectForKey:@"data"]} error:&error];//Model的ORM操作，dictionary to object
     }];
}
@end
