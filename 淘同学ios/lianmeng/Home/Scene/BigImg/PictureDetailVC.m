//  PictureDetailVC.m
//  YDXZ
//  Created by bailing on 2018/7/16.
//  Copyright © 2018年 niecong. All rights reserved.
#import "PictureDetailVC.h"
#import <UIImageView+WebCache.h>
@interface PictureDetailVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *number_lab;
@end
@implementation PictureDetailVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
/**
 关闭视图
 @param sender 关闭视图
 */
- (IBAction)acitonCloseBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger count = self.imageArray.count;
   // UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageGestureClick:)];
    //[self.scrollview addGestureRecognizer:tapGesture];
    for (int i = 0; i < count; i++) {
        UIImageView *iv = [[UIImageView alloc] init];
        iv.frame = CGRectMake( ScreenW * i , 20, ScreenW, ScreenH-64);
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [iv sd_setImageWithURL:[NSURL URLWithString:self.imageArray[i]] placeholderImage:[UIImage imageNamed:@"zf_alter"]];
        [self.scrollview addSubview:iv];
    }
    self.scrollview.showsVerticalScrollIndicator = NO;
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.pagingEnabled = YES;
    self.scrollview.delegate = self;
    self.scrollview.bounces = NO;
    self.scrollview.contentSize = CGSizeMake(ScreenW * count, ScreenH-64);
    //滚动到指定位置.
    CGPoint position = CGPointMake(ScreenW *self.position, 0);
    [self.scrollview setContentOffset:position animated:YES];
    self.number_lab.text = [NSString stringWithFormat:@"%d/%lu",self.position+1,(unsigned long)self.imageArray.count];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    long int page = lroundf(scrollView.contentOffset.x/scrollView.frame.size.width);
    self.number_lab.text = [NSString stringWithFormat:@"%ld/%lu",page+1,(unsigned long)self.imageArray.count];
}
#pragma mark -- UITapGestureRecognizer
//-(void)imageGestureClick:(UITapGestureRecognizer *)gesture{
//    NSLog(@"手势有用吗?");
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
