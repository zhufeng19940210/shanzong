//  ZFProductDetail.m
//  lianmeng
//  Created by zhufeng on 2019/1/3.
//  Copyright © 2019 zhuchao. All rights reserved.
//

#import "ZFProductDetail.h"
#import "ProdcutRequest.h"
#import "ActionSceneModel.h"
@interface ZFProductDetail ()

@end

@implementation ZFProductDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ProdcutRequest *request = [ProdcutRequest Request];
    NSLog(@"_itemId:%@",_itemId);
    request.itemId = _itemId;
    @weakify(self);
    [[ActionSceneModel sharedInstance] doRequest:request success:^{
        @strongify(self);
        NSError *error;
        NSLog(@"FFFFFrequest.output:%@",request.output);
    } error:^{
        
    }];
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
