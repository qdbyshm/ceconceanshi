//
//  MINavigationController.h
//  MINavigationControllerDemo
//
//  Created by WangLin on 11/14/13.
//  Copyright (c) 2013 im.codar. All rights reserved.
//



@interface MINavigationController : UINavigationController

@property (assign, nonatomic) CGFloat duration,scale;
@property (nonatomic,strong) UIPanGestureRecognizer *navRecognizer;
- (void)xxPushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)xxPopViewControllerAnimated:(BOOL)animated;
- (UIViewController *)xPopViewControllerAnimated:(BOOL)animated;
- (UIViewController *)xPopToController:(Class)viewControllerClass animated:(BOOL)animated;
- (void)xPushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)removeRec:(BOOL)isRemove;
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer;
- (UIViewController *)xPopViewControllerAndIndex:(int )num  Animated:(BOOL)animated;
- (void)moveViewWithX:(float)x;

- (void)smPushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;

- (NSInteger)indexForViewController:(Class)viewControllerClass;

@end
