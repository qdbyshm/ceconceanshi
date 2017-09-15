//
//  UIView+CH.m
//  SMZDM
//
//  Created by 李春慧 on 16/7/4.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "UIView+CH.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (CH)

/** 获取当前控制器*/
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/**
 设置底部阴影
 */
- (void) showBottomShadow {
    
    UIImageView * shadowView = [self sm_getAssociatedValueForKey:@"sm_ShadowView"];
    if (!shadowView) {
        shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 7)];
        shadowView.image = [UIImage imageNamed:@"shadow"];
        [self addSubview:shadowView];
        [self sm_setAssociateValue:shadowView withKey:@"sm_ShadowView"];
    }
    shadowView.top = self.height;
    shadowView.width = self.width;
    shadowView.hidden = NO;

//    self.layer.shadowColor = HEXColor(@"333333").CGColor;//阴影颜色
//    self.layer.shadowOffset = CGSizeMake(0, 2);//偏移距离
//    self.layer.shadowOpacity = 0.08;//不透明度
//    //self.layer.shadowRadius = 4.0;//半径
    
    self.clipsToBounds = NO;

}

- (void)hideBottomShadow
{
    UIImageView * shadowView = [self sm_getAssociatedValueForKey:@"sm_ShadowView"];
    if (shadowView) {
        shadowView.hidden = YES;
    }
    self.clipsToBounds = YES;
}

/**
 设置顶部阴影
 */
- (void) showTopShadow {
    
    UIImageView * shadowView = [self sm_getAssociatedValueForKey:@"sm_ShadowView_top"];
    if (!shadowView) {
        shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -7, self.width, 7)];
        shadowView.image = [UIImage imageNamed:@"shadow_top"];
        [self addSubview:shadowView];
        [self sm_setAssociateValue:shadowView withKey:@"sm_ShadowView_top"];
    }
    
    
    //    self.layer.shadowColor = HEXColor(@"333333").CGColor;//阴影颜色
    //    self.layer.shadowOffset = CGSizeMake(0, 2);//偏移距离
    //    self.layer.shadowOpacity = 0.08;//不透明度
    //    //self.layer.shadowRadius = 4.0;//半径
    
    self.clipsToBounds = NO;
    
}

/**
 设置周围阴影
 */
- (void) showAroundShadow {
    self.layer.shadowColor = HEXColor(@"333333").CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.08;//阴影透明度，默认0
    self.layer.shadowRadius = 4;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = 4;
    
    CGPoint topLeft      = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];  
    //设置阴影路径  
    self.layer.shadowPath = path.CGPath;
    
    self.clipsToBounds = NO;
}

@end
