//  MomentTableView.m
//  lianmeng
//  Created by zhuchao on 2018/6/3.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "MomentTableView.h"
#import "MomentCell.h"
#import "MomentListSceneModel.h"
#import <EasyIOS/EasyIOS.h>
#import "MomentCell2.h"
@interface MomentTableView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)MomentListSceneModel *sceneModel;
@property(nonatomic,assign)NSUInteger goodsType;
@end
@implementation MomentTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.goodsType = 1;
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 100;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[MomentCell class] forCellReuseIdentifier:@"MomentCell"];
        //[self registerClass:[MomentCell2 class] forCellReuseIdentifier:@"MomentCell2"];
    }
    return self;
}
-(void)startRAC:(NSUInteger)goodsType{
    _goodsType = goodsType;
    _sceneModel = [MomentListSceneModel SceneModel];
    _sceneModel.request.page = @1;
    _sceneModel.request.goodsType = [NSNumber numberWithInteger:goodsType];

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
    
    
    [[RACObserve(self.sceneModel, dataModel)
      filter:^BOOL(MomentListModel* value) {
          return value !=nil;
      }]
     subscribeNext:^(MomentListModel* value) {
         @strongify(self);
         if (value.currentPage == 1) {
             [self.sceneModel.dataArray removeAllObjects];
             self.sceneModel.dataArray = [NSMutableArray array];
         }
         if([value.list count]>0){
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
        [self triggerPullToRefresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sceneModel.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*if (_goodsType == 1) {
        MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MomentCell" forIndexPath:indexPath];
        [cell setModel:[_sceneModel.dataArray safeObjectAtIndex:indexPath.row]];
        return cell;
    }else{
        MomentCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MomentCell2" forIndexPath:indexPath];
        [cell setModel:[_sceneModel.dataArray safeObjectAtIndex:indexPath.row]];
        return cell;
    }*/
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MomentCell" forIndexPath:indexPath];
    [cell setModel:[_sceneModel.dataArray safeObjectAtIndex:indexPath.row]];
    return cell;
}

@end
