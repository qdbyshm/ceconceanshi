//
//  UIView+CH.h
//  SMZDM
//
//  Created by 李春慧 on 16/7/4.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CH)

- (UIViewController*)viewController;


/**
 设置底部阴影
 */
- (void) showBottomShadow;
- (void) hideBottomShadow;
/**
 设置顶部阴影
 */
- (void) showTopShadow;
/**
 设置周围阴影
 */
- (void) showAroundShadow;

@end
