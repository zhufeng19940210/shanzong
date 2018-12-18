//  MomentScrollView.m
//  lianmeng
//  Created by zhuchao on 2018/6/3.
//  Copyright © 2018年 zhuchao. All rights reserved.
#import "MomentScrollView.h"
#import "MomentTableView.h"
#import "UserCenter.h"
@interface MomentScrollView()
@property(nonatomic,retain)MomentTableView *tableView1;
@property(nonatomic,retain)MomentTableView *tableView2;
//@property(nonatomic,retain)MomentTableView *tableView3;
@property(nonatomic,retain)UIWebView *webView;
@end
@implementation MomentScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
        self.pagingEnabled = YES;
        
        _tableView1 = [[MomentTableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        [self addSubview:_tableView1];
        
        _tableView2 = [[MomentTableView alloc]initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        [self addSubview:_tableView2];
    
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(2*frame.size.width, 0, frame.size.width, self.frame.size.height)];
        NSString *url = [NSString stringWithFormat:@"http://www.taotongxue.cn/mobile/notice/detail/%ld",(long)[UserCenter sharedInstance].loginModel.userId];
        _webView.backgroundColor = [UIColor clearColor];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        [self addSubview:_webView];
        
        self.contentSize = CGSizeMake(3*frame.size.width,  frame.size.height);
        [_tableView1 startRAC:1];
        [_tableView2 startRAC:4];
        //[_tableView3 startRAC:3];
    }
    return self;
}
@end
