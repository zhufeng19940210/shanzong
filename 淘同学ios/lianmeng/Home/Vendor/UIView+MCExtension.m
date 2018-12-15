//
//  UIView+MCExtension.m
//  MCBook
//
//  Created by Dariel on 16/3/28.
//  Copyright © 2016年 Dariel. All rights reserved.
//

#import "UIView+MCExtension.h"

@implementation UIView (MCExtension)


+ (instancetype)MCviewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (BOOL)MCIntersectsWithView:(UIView *)view
{
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}


- (CGFloat)MC_width
{
    return self.frame.size.width;
}

- (CGFloat)MC_height
{
    return self.frame.size.height;
}

- (void)setMC_height:(CGFloat)MC_height
{
    CGRect frame = self.frame;
    frame.size.height = MC_height;
    self.frame = frame;
}

- (void)setMC_width:(CGFloat)MC_width
{
    CGRect frame = self.frame;
    frame.size.width = MC_width;
    self.frame = frame;
}

- (CGFloat)MC_x
{
    return self.frame.origin.x;
}

- (CGFloat)MC_y
{
    return self.frame.origin.y;
}

- (void)setMC_x:(CGFloat)MC_x
{
    CGRect frame = self.frame;
    frame.origin.x = MC_x;
    self.frame = frame;
}

- (void)setMC_y:(CGFloat)MC_y
{
    CGRect frame = self.frame;
    frame.origin.y = MC_y;
    self.frame = frame;
    
}

- (void)setMC_centerX:(CGFloat)MC_centerX
{
    CGPoint center = self.center;
    center.x = MC_centerX;
    self.center = center;
}

- (CGFloat)MC_centerX
{
    return self.center.x;
}

- (void)setMC_centerY:(CGFloat)MC_centerY
{
    CGPoint center = self.center;
    center.y = MC_centerY;
    self.center = center;
}

- (CGFloat)MC_centerY
{
    return self.center.y;
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}




@end
