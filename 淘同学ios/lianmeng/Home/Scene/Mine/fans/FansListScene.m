//
//  FansListScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/27.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "FansListScene.h"
#import "NavLeftView.h"
#import "Scene+NavBar.h"
#import <EasyIOS/EasyIOS.h>
#import <Masonry/Masonry.h>
#import "FansSearchView.h"
#import "FansCell.h"
#import "UserFansListSceneModel.h"
#import <RegExCategories/RegExCategories.h>

@interface FansListScene ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,retain)SceneTableView *tableView;
@property(nonatomic,retain)UserFansListSceneModel *sceneModel;
@end

@implementation FansListScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithString:@"#EEEDEE"];
    
    UIImageView *titleBgImage = [[UIImageView alloc]init];
    [titleBgImage setImage:[UIImage imageNamed:@"nav-bg"]];
    [self.view addSubview:titleBgImage];
    
    [titleBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    [self.navBar setLeftView:[[NavLeftView alloc]initWithTitle:@"粉丝列表"]];
    [self.navBar.leftView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftButtonTouch)]];
    
    FansSearchView *searchView = [[FansSearchView alloc]init];
    searchView.textField.delegate = self;
    [self.view addSubview:searchView];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
        make.height.equalTo(@50.0f);
    }];
    
    _tableView = [[SceneTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.rowHeight = 73.0f;
    [_tableView registerClass:[FansCell class] forCellReuseIdentifier:@"FansCell"];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(searchView.mas_bottom);
    }];
    
    _sceneModel = [UserFansListSceneModel SceneModel];
    _sceneModel.request.type = self.type;
    @weakify(self);
    [self.tableView addPullToRefreshWithActionHandler:^{
        @strongify(self);
        self.sceneModel.request.requestNeedActive = YES;
    }];
    
    [[RACObserve(self.sceneModel, dataModel)
      filter:^BOOL(FansListModel* value) {
          return value !=nil;
      }]
     subscribeNext:^(FansListModel* value) {
         @strongify(self);
         self.sceneModel.dataArray = [NSArray arrayWithArray:value.list];
         [self.tableView reloadData];
         [self.tableView.pullToRefreshView stopAnimating];
     }];
    
    [[RACObserve(self.sceneModel.request, state)
      filter:^BOOL(NSNumber *state) {
          @strongify(self);
          return self.sceneModel.request.failed;
      }]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.tableView.pullToRefreshView stopAnimating];
     }];
    [self.tableView triggerPullToRefresh];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *keyWord = [textField.text copy];
    textField.text = @"";
    
    if(keyWord.length >0){
        self.sceneModel.dataArray = [self.sceneModel.dataModel.list filter:^BOOL(FansModel* obj) {
            return (obj.username && [[Rx rx:keyWord] isMatch:obj.username]) || (obj.nickName && [[Rx rx:keyWord] isMatch:obj.nickName]);
        }];
    }else{
        self.sceneModel.dataArray = self.sceneModel.dataModel.list;
    }
    [self.tableView reloadData];
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sceneModel.dataArray?self.sceneModel.dataArray.count:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FansCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FansCell" forIndexPath:indexPath];
    [cell reloadData:[self.sceneModel.dataArray safeObjectAtIndex:indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
