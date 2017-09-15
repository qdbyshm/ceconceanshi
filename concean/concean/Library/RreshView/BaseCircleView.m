//
//  BaseCircleView.m
//  SMZDM
//
//  Created by 冯展波 on 16/7/15.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "BaseCircleView.h"

@implementation BaseCircleView
- (void)addCircleAnimal
{
    [self.layer removeAllAnimations];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10000;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}
@end
