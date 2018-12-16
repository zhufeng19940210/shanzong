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
         NSLog(@"self.likeRequest.output:%@",self.likeRequest.output);
  //       NSError *error;
 //        NSLog(@"likeRequest.data:%@",self.likeRequest.output);
//         NSDictionary *categoryItemList1  = self.likeRequest.output[@"data"][@"categoryItemList1"];
//         NSDictionary *categoryItemList2 = self.likeRequest.output[@"data"][@"categoryItemList2"];
//         NSDictionary *categoryItemList3  = self.likeRequest.output[@"data"][@"categoryItemList3"];
//         NSDictionary *itemlistDic = self.likeRequest.output[@"data"][@"itemlist"];
//         NSLog(@"categoryItemList1:%@",categoryItemList1);
//         NSLog(@"categoryItemList2:%@",categoryItemList2);
//         NSLog(@"categoryItemList3:%@",categoryItemList3);
//         NSLog(@"itemlistDic:%@",itemlistDic);
         //self.dataModel = [[GoodsListModel alloc] initWithDictionary:[self.likeRequest.output objectForKey:@"data"][@"itemlist"] error:&error];//Model的ORM操作，dictionary to object
         self.dataModel = self.likeRequest.output[@"data"];
     }];
    
    
    _banaerModel = nil;
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
         //NSError *error;
         NSLog(@"self.bannerRequest.output:%@",self.bannerRequest.output);
         self.banaerModel = self.bannerRequest.output[@"data"];
         NSLog(@"self.banaerModel:%@",self.banaerModel);
//         self.bannerModel = [[BannerListModel alloc] initWithDictionary:@{@"list":[self.bannerRequest.output objectForKey:@"data"]} error:&error];//Model的ORM操作，dictionary to object
         
     }];
}
@end
