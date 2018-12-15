//
//  TaoBaoTableView.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/16.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "TaoBaoTableView.h"
#import "TabBaoItemCell.h"
#import <EasyIOS/EasyIOS.h>
#import "DetailScene.h"

@interface TaoBaoTableView()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation TaoBaoTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self= [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 130.0f;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[TabBaoItemCell class] forCellReuseIdentifier:@"TabBaoItemCell"];
        
        _sceneModel = [TaoBaoItemListSceneModel SceneModel];
        
        @weakify(self);
        [[RACObserve(self.sceneModel, dataModel)
          filter:^BOOL(GoodsListModel* value) {
              return value !=nil;
          }]
         subscribeNext:^(GoodsListModel* value) {
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
        
    }
    return self;
}


-(void)startRAC:(NSUInteger)index{
    if (self.sceneModel.dataArray && self.sceneModel.dataArray.count >0) {
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
    _sceneModel.request.cid = index > 2?@(index+1):@(index);
    [self triggerPullToRefresh];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TabBaoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TabBaoItemCell" forIndexPath:indexPath];
    [cell setModel: [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sceneModel.dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailScene *detail = [[DetailScene alloc]init];
    detail.model = [self.sceneModel.dataArray safeObjectAtIndex:indexPath.row];
    [[URLNavigation navigation].currentNavigationViewController pushViewController:detail animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollingDelegate) {
        [self.scrollingDelegate viewIsScrolling:scrollView];
    }
}

@end
