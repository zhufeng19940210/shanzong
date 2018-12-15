//
//  UIView+MCExtension.h
//  MCBook
//
//  Created by Dariel on 16/3/28.
//  Copyright © 2016年 Dariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MCExtension)

+ (instancetype)MCviewFromXib;
- (BOOL)MCIntersectsWithView:(UIView *)view;

@property (nonatomic, assign) CGFloat MC_width;
@property (nonatomic, assign) CGFloat MC_height;

@property (nonatomic, assign) CGFloat MC_x;
@property (nonatomic, assign) CGFloat MC_y;

@property (nonatomic, assign) CGFloat MC_centerX;
@property (nonatomic, assign) CGFloat MC_centerY;


@property CGFloat top;


- (UIViewController *)viewController;


@end
