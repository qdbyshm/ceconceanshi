//
//  UINavigationController+SMBackGesture.m
//  UINavigationControllerBackGesture
//
//  Created by ZhangWenhui on 16/8/30.
//  Copyright © 2016年 ZhangWenhui. All rights reserved.
//

#import "UINavigationController+SMBackGesture.h"
#import <objc/runtime.h>

static const char *associatedKeyPanGesture = "__associated_key_panGesture";
static const char *associatedKeyEnableGesture = "__associated_key_enableGesture";

@interface UINavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation UINavigationController (SMBackGesture)

- (void)setEnableBackGesture:(BOOL)enableBackGesture
{
    NSNumber *enableGestureNumber = @(enableBackGesture);
    objc_setAssociatedObject(self, associatedKeyEnableGesture, enableGestureNumber, OBJC_ASSOCIATION_RETAIN);
    if (enableBackGesture) {
        [self.view addGestureRecognizer:[self panGestureRecognizer]];
    } else {
        [self.view removeGestureRecognizer:[self panGestureRecognizer]];
    }
}

- (BOOL)enableBackGesture
{
    BOOL res = NO;
    NSNumber *enableGestureNumber = objc_getAssociatedObject(self, associatedKeyEnableGesture);
    if (enableGestureNumber) {
        res = [enableGestureNumber boolValue];
    }
    return res;
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, associatedKeyPanGesture);
    
    if (!panGestureRecognizer) {
        id target = self.interactivePopGestureRecognizer.delegate;
        SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handleTransition];
        panGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = NO;
        objc_setAssociatedObject(self, associatedKeyPanGesture, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN);
    }
    
    return panGestureRecognizer;
}

#pragma mark - 滑动开始会触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //手势相反时，返回NO
    CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    //只有导航的根控制器不需要右滑的返回的功能。
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
    return YES;
}

//- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan
//{
//    UIPanGestureRecognizer *gesture = pan;
//    CGPoint translation = [gesture translationInView:self.view];
//    
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"begin");
//    } else if (gesture.state == UIGestureRecognizerStateChanged /*&& direction == kCameraMoveDirectionNone*/) {
//        NSLog(@"移动");
//    } else if (gesture.state == UIGestureRecognizerStateEnded) {
//        NSLog (@"Stop" );
//    }
//    [self xPopViewControllerAnimated:YES];
//}

@end
