//
//  SearchScene.m
//  lianmeng
//
//  Created by zhuchao on 2018/6/12.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "SearchScene.h"
#import <Masonry/Masonry.h>
#import "SearchNavBar.h"
#import "SearchContentView.h"
#import "SearchDropDownView.h"
#import "SearchListScene.h"

@interface SearchScene ()<UITextFieldDelegate,SearchContentViewDelegate>
@property(nonatomic,retain)SearchNavBar *searchBar;
@property(nonatomic,retain)SearchContentView *contentView;

@property(nonatomic,retain)SearchDropDownView *dropDownView;

@property(nonatomic,assign)NSUInteger platformId;
@end

@implementation SearchScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _searchBar = [[SearchNavBar alloc]init];
    [self.view addSubview:_searchBar];
    [_searchBar.leftButton addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar.dropDownButton addTarget:self action:@selector(showDropDownBox) forControlEvents:UIControlEventTouchUpInside];
    _searchBar.textField.delegate = self;
    _searchBar.textField.returnKeyType = UIReturnKeySearch;
    
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kStatusBarAndNavigationBarHeight));
    }];
    
    _contentView = [[SearchContentView alloc]init];
    _contentView.delegate = self;
    [self.view addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom);
    }];
    
    _dropDownView = [[SearchDropDownView alloc]init];
    _dropDownView.hidden = YES;
    [self.view addSubview:_dropDownView];
    [_dropDownView.button1 addTarget:self action:@selector(touchTaobao) forControlEvents:UIControlEventTouchUpInside];
    [_dropDownView.button2 addTarget:self action:@selector(touchJd) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_dropDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@65.0f);
        make.top.equalTo(self.searchBar.mas_bottom).offset(-8.0f);
        make.left.equalTo(self.searchBar.mas_left).offset(60.0f);
    }];
    
    
    if ([self.platform isEqualToString:@"淘宝"]) {
        self.platformId = 1;
        [_searchBar.dropDownButton setTitle:@"淘宝" forState:UIControlStateNormal];
    }else if([self.platform isEqualToString:@"京东"]){
        self.platformId = 2;
        [_searchBar.dropDownButton setTitle:@"京东" forState:UIControlStateNormal];
    }else{
        self.platformId = 1;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *keyWord = [textField.text copy];
    textField.text = @"";
    if(keyWord.length >0){
        [_contentView addKeyWord:keyWord];
        SearchListScene *scene = [[SearchListScene alloc]init];
        scene.platformId = self.platformId;
        scene.keyword = [keyWord copy];
        scene.isSort = NO;
        [self.navigationController pushViewController:scene animated:YES];
    }
    return YES;
}

-(void)kewordDidTouched:(NSString *)keyword{
    SearchListScene *scene = [[SearchListScene alloc]init];
    scene.platformId = self.platformId;
    scene.keyword = [keyword copy];
    scene.isSort = NO;
    [self.navigationController pushViewController:scene animated:YES];
}

-(void)touchTaobao{
     self.platformId = 1;
    _dropDownView.hidden = YES;
    [_searchBar.dropDownButton setTitle:@"淘宝" forState:UIControlStateNormal];
    _searchBar.pinkArrow.transform = CGAffineTransformMakeRotation(0);
}

-(void)touchJd{
     self.platformId = 2;
     _dropDownView.hidden = YES;
    [_searchBar.dropDownButton setTitle:@"京东" forState:UIControlStateNormal];
    _searchBar.pinkArrow.transform = CGAffineTransformMakeRotation(0);
}

-(void)showDropDownBox{
    if(_dropDownView.hidden){
        _searchBar.pinkArrow.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    }else{
        _searchBar.pinkArrow.transform = CGAffineTransformMakeRotation(0);
    }
    _dropDownView.hidden = !_dropDownView.hidden;
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
