//  CircleTableView.m
//  lianmeng
//  Created by zhufeng on 2018/12/18.
//  Copyright © 2018 zhuchao. All rights reserved.
#import "CircleTableView.h"
#import "CircleCell.h"
#import "CircleSceneModel.h"
#import <EasyIOS/EasyIOS.h>
@interface CircleTableView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)CircleSceneModel *circlesceneModel;
@property(nonatomic,assign)NSUInteger goodsType;
@end

@implementation CircleTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {

        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 100;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[CircleCell class] forCellReuseIdentifier:@"CircleCell"];
        //[self registerClass:[MomentCell2 class] forCellReuseIdentifier:@"MomentCell2"];
    }
    return self;
}
-(void)startRAC:(NSUInteger)goodsType{
    _goodsType = goodsType;
    _circlesceneModel = [CircleSceneModel SceneModel];
    _circlesceneModel.request.page = @1;
    _circlesceneModel.request.goodsType = [NSNumber numberWithInteger:goodsType];
    
    @weakify(self);
    [self addPullToRefreshWithActionHandler:^{
        @strongify(self);
        self.circlesceneModel.request.page = @1;
        self.circlesceneModel.request.requestNeedActive = YES;
    }];
    [self addInfiniteScrollingWithActionHandler:^{
        @strongify(self);
        self.circlesceneModel.request.page = [self.circlesceneModel.request.page increase:@1];
        self.circlesceneModel.request.requestNeedActive = YES;
    }];
    
    [[RACObserve(self.circlesceneModel, dataModel)
      filter:^BOOL(CircleListModel* value) {
          return value !=nil;
      }]
     subscribeNext:^(CircleListModel* value) {
         @strongify(self);
         if (value.currentPage == 1) {
             [self.circlesceneModel.dataArray removeAllObjects];
             self.circlesceneModel.dataArray = [NSMutableArray array];
         }
         if([value.list count]>0){
             [self.circlesceneModel.dataArray addObjectsFromArray:value.list];
         }
         self.circlesceneModel.request.page = @(value.currentPage);
         [self reloadData];
         [self endAllRefreshingWithIntEnd:value.totalPage <= value.currentPage];
     }];
    
    [[RACObserve(self.circlesceneModel.request, state)
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          return self.circlesceneModel.request.failed;
      }]
     subscribeNext:^(id x) {
         @strongify(self);
         self.circlesceneModel.request.page = self.circlesceneModel.dataModel?@(self.circlesceneModel.dataModel.currentPage):@(1);
         [self endAllRefreshingWithIntEnd:self.circlesceneModel.dataModel.currentPage >= self.circlesceneModel.dataModel.totalPage];
     }];
    [self triggerPullToRefresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.circlesceneModel.dataArray.count;
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
    CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircleCell" forIndexPath:indexPath];
    [cell setModel:[self.circlesceneModel.dataArray safeObjectAtIndex:indexPath.row]];
    return cell;
}

@end
