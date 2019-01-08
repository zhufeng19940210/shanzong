//  ZFProductDetail.m
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
#import "ZFProductDetail.h"
#import "ProdcutRequest.h"
#import "ActionSceneModel.h"
#import "ProductDetailScrollView.h"
#import "Scene+NavBar.h"
#import <Masonry.h>
@interface ZFProductDetail ()
@property (nonatomic,strong)ProductDetailScrollView *collectionview;
@end
@implementation ZFProductDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_LEFT button:leftButton];
    
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setImage:[UIImage imageNamed:@"xihuan"] forState:UIControlStateNormal];
    [self nav_showBarButton:NAV_RIGHT button:rightButton];
    //创建collectionview的视图
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = 1;//行间距
    flow.minimumInteritemSpacing = 1;//列间距
    _collectionview = [[ProductDetailScrollView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    [self.view addSubview:_collectionview];
    [_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    if (@available(iOS 11.0, *)) {
        _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    ProdcutRequest *request = [ProdcutRequest Request];
    request.itemId = _itemId;
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSError *error; 
        NSDictionary *responsedic = request.output;
        if ([[responsedic valueForKey:@"status"] intValue] == 200) {
           // [self.collectionview reloadDetailWithDic:responsedic];
        }
    } error:^{
        NSLog(@"暂无数据");
    }];
}
@end
