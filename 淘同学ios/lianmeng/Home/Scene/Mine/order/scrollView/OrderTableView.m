//
//  OrderTableView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "OrderTableView.h"
#import <EasyIOS/EasyIOS.h>
#import "DetailScene.h"
#import "OrderCell.h"

@interface OrderTableView()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation OrderTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self= [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 210.0f;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[OrderCell class] forCellReuseIdentifier:@"OrderCell"];
        
        _sceneModel = [UserOrderListSceneModel SceneModel];

        @weakify(self);
        [[RACObserve(self.sceneModel, dataModel)
          filter:^BOOL(UserOrderListModel* value) {
              return value !=nil;
          }]
         subscribeNext:^(UserOrderListModel* value) {
             @strongify(self);
             if (value.currentPage == 1) {
                 [self.sceneModel.dataArray removeAllObjects];
                 self.sceneModel.dataArray = [NSMutableArray array];
             }
             if(value.list && [value.list count]>0){
                 [self.sceneModel.dataArray addObjectsFromArray:value.list];
             }
             self.sceneModel.request.page = @(value.currentPage);
             [self reloadData];
             [self endAllRefreshingWithIntEnd:value.totalPage <= value.currentPage];
         }];
        
        [[RACObserve(self.sceneModel.request, state)
          filter:^BOOL(NSNumber *state) {
              @strongify(self);
              return self.sceneModel.request.failed;
          }]
         subscribeNext:^(id x) {
             @strongify(self);
             self.sceneModel.request.page = self.sceneModel.dataModel?@(self.sceneModel.dataModel.currentPage):@(1);
             [self endAllRefreshingWithIntEnd:self.sceneModel.dataModel.currentPage >= self.sceneModel.dataModel.totalPage];
         }];
        
    }
    return self;
}

-(void)startRAC:(NSUInteger)index platformId:(NSUInteger)platformId{
    
    if (self.sceneModel.dataArray && self.sceneModel.dataArray.count >0 && platformId == _sceneModel.request.platformId.integerValue) {
        return;
    }
    @weakify(self);
    [self addPullToRefreshWithActionHandler:^{
        @strongify(self);
        self.sceneModel.request.page = @1;
        self.sceneModel.request.requestNeedActive = YES;
    }];
    [self addInfiniteScrollingWithActionHandler:^{
        @strongify(self);
        self.sceneModel.request.page = [self.sceneModel.request.page increase:@1];
        self.sceneModel.request.requestNeedActive = YES;
    }];
    _sceneModel.request.page = @1;
    
    _sceneModel.request.platformId = @(platformId);
    _sceneModel.request.orderId = @"";
    if (index == 0) {
        _sceneModel.request.payStatus = nil;
    }else if(index == 1){
        _sceneModel.request.payStatus = @12;
    }else if(index == 2){
        _sceneModel.request.payStatus = @3;
    }else if(index == 3){
        _sceneModel.request.payStatus = @1;
    }else if(index == 4){
        _sceneModel.request.payStatus = @13;
    }
    [self triggerPullToRefresh];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    [cell reloadData: [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sceneModel.dataArray.count;
}

@end
