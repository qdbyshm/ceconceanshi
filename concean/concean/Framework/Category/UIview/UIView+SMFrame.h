//
//  UIView+SMFrame.h
//  SMZDM
//
//  Created by chenshan on 16/6/27.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+FrameUtils.h"

@interface UIView (SMFrame)

- (UIView * (^)(UIView *uptterView, CGFloat distance))smTopTo;
- (UIView * (^)(UIView *uptterView, CGFloat distance))smBottomTo;
- (UIView * (^)(UIView *uptterView, CGFloat distance))smLeftTo;
- (UIView * (^)(UIView *uptterView, CGFloat distance))smRightTo;

- (UIView * (^)(CGFloat distance))smTop;
- (UIView * (^)(CGFloat distance))smBottom;
- (UIView * (^)(CGFloat distance))smLeft;
- (UIView * (^)(CGFloat distance))smRigth;

- (UIView * (^)(CGFloat width))smWidth;
- (UIView * (^)(CGFloat height))smHeight;

- (UIView * (^)(UIView *uptterView))smTopEqualsTo;
- (UIView * (^)(UIView *uptterView))smBottomEqualsTo;
- (UIView * (^)(UIView *uptterView))smWidthEqualsTo;
- (UIView * (^)(UIView *uptterView))smHeightEqualsTo;

@end
