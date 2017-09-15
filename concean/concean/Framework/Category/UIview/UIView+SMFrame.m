//
//  UIView+SMFrame.m
//  SMZDM
//
//  Created by chenshan on 16/6/27.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "UIView+SMFrame.h"

@implementation UIView (SMFrame)

- (UIView * (^)(UIView *uptterView, CGFloat distance))smTopTo {
    return ^UIView *(UIView *uptterView, CGFloat distance) {
        
        self.top = uptterView.bottom + distance;
        
        return self;
    };
}

- (UIView * (^)(UIView *uptterView, CGFloat distance))smBottomTo {
    return ^UIView *(UIView *uptterView, CGFloat distance) {
        
        self.bottom = uptterView.top - distance;
        
        return self;
    };
}

- (UIView * (^)(UIView *uptterView, CGFloat distance))smLeftTo {
    return ^UIView *(UIView *uptterView, CGFloat distance) {
        
        self.left = uptterView.left + distance;
        
        return self;
    };
}

- (UIView * (^)(UIView *uptterView, CGFloat distance))smRightTo {
    return ^UIView *(UIView *uptterView, CGFloat distance) {
        
        self.right = uptterView.right + distance;
        
        return self;
    };
}

- (UIView * (^)(CGFloat distance))smTop {
    return ^UIView *(CGFloat distance) {
        
        self.top = distance;
        
        return self;
    };
}
- (UIView * (^)(CGFloat distance))smBottom{
    return ^UIView *(CGFloat distance) {
        
        self.bottom = distance;
        
        return self;
    };
}
- (UIView * (^)(CGFloat distance))smLeft{
    return ^UIView *(CGFloat distance) {
        
        self.left = distance;
        
        return self;
    };
}
- (UIView * (^)(CGFloat distance))smRigth{
    return ^UIView *(CGFloat distance) {
        
        self.right = distance;
        
        return self;
    };
}

- (UIView * (^)(CGFloat width))smWidth {
    return ^UIView *(CGFloat width) {
        
        self.width = width;
        
        return self;
    };
}

- (UIView * (^)(CGFloat height))smHeight {
    return ^UIView *(CGFloat height) {
        
        self.height = height;
        
        return self;
    };
}


- (UIView * (^)(UIView *uptterView))smTopEqualsTo {
    return ^UIView *(UIView *uptterView) {
        
        self.top = uptterView.top;
        
        return self;
    };
}
- (UIView * (^)(UIView *uptterView))smBottomEqualsTo {
    return ^UIView *(UIView *uptterView) {
        
        self.bottom = uptterView.bottom;
        
        return self;
    };
}


- (UIView * (^)(UIView *uptterView))smWidthEqualsTo {
    return ^UIView *(UIView *uptterView) {
        
        self.width = uptterView.width;
        
        return self;
    };
}

- (UIView * (^)(UIView *uptterView))smHeightEqualsTo {
    return ^UIView *(UIView *uptterView) {
        
        self.height = uptterView.height;
        
        return self;
    };
}

@end
