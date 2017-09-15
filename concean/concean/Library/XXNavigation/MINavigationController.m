//
//  MINavigationController.m
//  MINavigationControllerDemo
//
//  Created by WangLin on 11/14/13.
//  Copyright (c) 2013 im.codar. All rights reserved.
//

#import "MINavigationController.h"
#import <QuartzCore/QuartzCore.h>
#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    @interface MINavigationController () <UIGestureRecognizerDelegate, CALayerDelegate, CAAnimationDelegate> {
#else
    @interface MINavigationController () <UIGestureRecognizerDelegate> {
#endif
    CALayer *_animationLayer;
    
    CGPoint startPoint;
    NSDate  * startTime;
    
    UIImageView *lastScreenShotView;// view
//    int iii;

}
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong)  UIImageView*leftScreenShotView;

@property (nonatomic, strong) NSMutableArray *screenShotList;

@property (nonatomic, assign) BOOL isMoving;

@end

static CGFloat offset_float = 0.65;// 拉伸参数
static CGFloat min_distance = 100;// 最小回弹距离

@implementation MINavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationBar.hidden = YES;
    _animationLayer = [CALayer layer];
    _animationLayer.delegate = self;
    _animationLayer.frame = self.view.bounds;
    _animationLayer.masksToBounds = YES;
    [_animationLayer setContentsGravity:kCAGravityBottomLeft];
    [self.view.layer addSublayer:_animationLayer];

    _duration=_duration==0?0.4:_duration;
    _scale = _scale==0?0.9:_scale;
    
    
    _navRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    [_navRecognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:_navRecognizer];

}
- (void)removeRec:(BOOL)isRemove
{
    if (!isRemove) {
        if (_navRecognizer) {
            [self.view addGestureRecognizer:_navRecognizer];

        }else
        {
            _navRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
            [_navRecognizer delaysTouchesBegan];
            [self.view addGestureRecognizer:_navRecognizer];

        }
    }else
    {
        [self.view removeGestureRecognizer:_navRecognizer];

    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _animationLayer.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAnimationLayer {
   
    @try {
        UIGraphicsBeginImageContext(self.visibleViewController.view.bounds.size);
        [self.visibleViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [_animationLayer setContents:(id) viewImage.CGImage];
        [_animationLayer setHidden:NO];

    }
    @catch (NSException *exception) {
        NSLog(@"出错的位置%@    出错%@   %@",self, exception.name,exception.reason);
    }
    @finally {
    }
    }

- (void)xxPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [_animationLayer removeFromSuperlayer];
    [self.view.layer insertSublayer:_animationLayer atIndex:0];
    [UIView setAnimationsEnabled:YES];
    

    if (animated) {
        [self loadAnimationLayer];
        UIView *toView = [viewController view];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        [animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.view.bounds.size.width, 0, 0)]];
        [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
        [animation setDuration:0.3];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [toView.layer addAnimation:animation forKey:@"fromRight"];
        

        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform"];
        [animation1 setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 0.8)]];
        [animation1 setDuration:0.3];
        animation1.delegate = self;
        animation1.removedOnCompletion = NO;
        animation1.fillMode = kCAFillModeForwards;
        [_animationLayer addAnimation:animation1 forKey:@"scale"];
    }
    [super pushViewController:viewController animated:NO];
}

- (UIViewController *)xxPopViewControllerAnimated:(BOOL)animated {
    [_animationLayer removeFromSuperlayer];
    [self.view.layer insertSublayer:_animationLayer above:self.navigationBar.layer];
    [UIView setAnimationsEnabled:YES];

    if (animated) {
        [self loadAnimationLayer];
        UIView *toView = [[self.viewControllers objectAtIndex:[self.viewControllers indexOfObject:self.visibleViewController] - 1] view];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        [animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.view.bounds.size.width, 0, 0)]];
        [animation setDuration:0.3];
        animation.delegate = self;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeBoth;
        [_animationLayer addAnimation:animation forKey:@"fromLeft"];

        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform"];
        [animation1 setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 0.8)]];
        [animation1 setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [animation1 setDuration:0.3];
        animation1.delegate = self;
        animation1.removedOnCompletion = NO;
        animation1.fillMode = kCAFillModeBoth;
        [toView.layer addAnimation:animation1 forKey:@"scale"];
    }
    return [super popViewControllerAnimated:NO];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}
- (void)popViewControllerAnimated:(BOOL)animated
{
        [super popViewControllerAnimated:animated];
}
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    [_animationLayer setContents:nil];
    [_animationLayer removeAllAnimations];
    [self.visibleViewController.view.layer removeAllAnimations];
}

- (NSMutableArray *)screenShotList {
    if (!_screenShotList) {
        _screenShotList = [[NSMutableArray alloc] init];
    }
    return _screenShotList;
}
// override the pop method
- (UIViewController *)xPopViewControllerAnimated:(BOOL)animated {
    if (animated) {
        [self popAnimation:animated];
        return nil;
    } else {
        return [super popViewControllerAnimated:animated];
    }
}

- (UIViewController *)xPopViewControllerAndIndex:(int)num  Animated:(BOOL)animated{
    // 有动画用自己的动画
    if (animated || !animated) {
        for (int i = 0; i < num; i ++ ) {
            [self popAnimation:animated];
        }

        return nil;
    } else {
        return [super popViewControllerAnimated:animated];
    }
}

- (UIViewController *)xPopToController:(Class)viewControllerClass animated:(BOOL)animated
{
    // 有动画用自己的动画
    if (animated) {
        NSInteger destinationIndex = [self indexForViewController:viewControllerClass];
        NSInteger rangLength = self.viewControllers.count - destinationIndex - 1;
        
        if(rangLength <= 1) {
            return [self xPopViewControllerAnimated:animated];
        }
            UIViewController *destinationVc = self.viewControllers[destinationIndex];
        [self popToViewController:destinationVc animated:animated];
        NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
        for (NSInteger theIndex = self.screenShotList.count - rangLength; theIndex < self.screenShotList.count; theIndex++) {
            [set addIndex:theIndex];
        }
        [self.screenShotList removeObjectsAtIndexes:set];
        return destinationVc;
    }
    else {
        return [super popViewControllerAnimated:animated];
    }
}

- (NSInteger)indexForViewController:(Class)viewControllerClass {
    for (NSInteger index = 0;index < self.viewControllers.count;index++) {
        UIViewController *subVc = self.viewControllers[index];
        if([subVc isKindOfClass:viewControllerClass]) {
            return index;
        }
    }
    
    return 0;
}



- (void)popAnimation:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        return;
    }
    if (!self.backGroundView) {
        CGRect frame = self.view.frame;
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
    }
    
    [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];
    
    _backGroundView.hidden = NO;
    
    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
    
    UIImage *lastScreenShot = [self.screenShotList lastObject];
//    iii++;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_%d.png", iii]];
//    [UIImagePNGRepresentation(lastScreenShot)writeToFile: filePath    atomically:YES];
    lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
    
    lastScreenShotView.frame = (CGRect){-(MainScreenWidth*offset_float),0,MainScreenWidth,MainScreenHeight};
    
    [self.backGroundView addSubview:lastScreenShotView];
    
    NSTimeInterval duration = 0.0;
    if (animated) {
        duration = 0.4;
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        [self moveViewWithX:MainScreenWidth];
        
    } completion:^(BOOL finished) {
        [self gestureAnimation:NO];
        
        CGRect frame = self.view.frame;
        
        frame.origin.x = 0;
        
        self.view.frame = frame;
        
        _isMoving = NO;
        
        self.backGroundView.hidden = YES;
    }];
}

- (void)xPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotList addObject:[self newCapture]];
    [UIView setAnimationsEnabled:YES];

    [super pushViewController:viewController animated:animated];
}

//push by new capture method
- (void)smPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotList addObject:[self newCapture]];
    [UIView setAnimationsEnabled:YES];
    
    [super pushViewController:viewController animated:animated];
}


#pragma mark - Utility Methods -
// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

//fix bug of uipickerview getting dark
- (UIImage *)newCapture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    if([self.view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    }
    else {
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }

    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position when paning
- (void)moveViewWithX:(float)x
{
    x = x>MainScreenWidth?MainScreenWidth:x;
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    // TODO
    lastScreenShotView.frame = (CGRect){-(MainScreenWidth*offset_float)+x*offset_float,0,MainScreenWidth,MainScreenHeight};

}

- (void)gestureAnimation:(BOOL)animated {
    [UIView setAnimationsEnabled:YES];
    [self.screenShotList removeLastObject];
    _leftScreenShotView.hidden = YES;
    [super popViewControllerAnimated:animated];
}

#pragma mark - Gesture Recognizer -
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1) return;
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        
        startPoint = touchPoint;
        startTime = [NSDate date];
        
        if (!self.backGroundView) {
            CGRect frame = self.view.frame;
            
            _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            
            
        }
        
        [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];
        
        _backGroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotList lastObject];
        
        lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
        
        lastScreenShotView.frame = (CGRect){-(MainScreenWidth*offset_float),0,MainScreenWidth,MainScreenHeight};
        
        [self.backGroundView addSubview:lastScreenShotView];
        
        
        if (!self.leftScreenShotView) {
            CGRect frame = self.view.frame;
            
            _leftScreenShotView = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 0, 10 , frame.size.height)];
            _leftScreenShotView.image = [UIImage imageNamed:@"navigation"];
            _leftScreenShotView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:_leftScreenShotView];
        }
        _leftScreenShotView.hidden = NO;

        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startPoint.x > min_distance)
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                [self moveViewWithX:MainScreenWidth];
                
            } completion:^(BOOL finished) {
                [self gestureAnimation:NO];
                
                CGRect frame = self.view.frame;
                
                frame.origin.x = 0;
                
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            if (touchPoint.x - startPoint.x>0) {
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                NSTimeInterval interval = 0 - [startTime timeIntervalSinceNow];
                float rate_x =(touchPoint.x - startPoint.x)/interval;
//                CLog(@"abc....%f",rate_x);
                if (rate_x>500) {
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        [self moveViewWithX:MainScreenWidth];
                        
                    } completion:^(BOOL finished) {
                        [self gestureAnimation:NO];
                        
                        CGRect frame = self.view.frame;
                        
                        frame.origin.x = 0;
                        
                        self.view.frame = frame;
                        
                        _isMoving = NO;
                    }];
                    return;
                }

            }
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                
                self.backGroundView.hidden = YES;
                _leftScreenShotView.hidden = YES;

            }];
            
        }
        return;
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            
            self.backGroundView.hidden = YES;
            _leftScreenShotView.hidden = YES;

        }];
        
        return;
    }
    // it keeps move with touch
    if (_isMoving) {
        
        [self moveViewWithX:touchPoint.x - startPoint.x];
    }
}
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}

@end
