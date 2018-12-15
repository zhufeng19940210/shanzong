//
//  MCScrollView.h
//  MCBook
//
//  Created by Dariel on 16/3/31.
//  Copyright © 2016年 Dariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCScrollView;
@protocol MCScrollViewDelegate <NSObject>

- (void)MCScrollView:(MCScrollView *)MCScrollView touchImageAtIndex:(int)index;

@end

@interface MCScrollView : UIView <UIScrollViewDelegate>

/*!
 *  代理方法
 */
@property (nonatomic, assign) id<MCScrollViewDelegate> delegate;

/*!
 *  初始化
 *
 *  @param frameSize  显示的大小
 *  @param imageArray 存放图片的数组
 *
 *  @return 当前对象
 */
-(instancetype)initWIthFrame:(CGRect)frameSize ;

-(void)reloadImages:(NSArray *)imageArray;

/*!
 *   开启定时器，循环滚动
 */
-(void)start;


/*!
 *  停止定时器
 */
- (void)stop;



@end

