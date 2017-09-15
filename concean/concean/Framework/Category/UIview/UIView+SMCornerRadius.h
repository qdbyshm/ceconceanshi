//
//  UIView+SMCornerRadius.h
//  SMZDM
//
//  Created by ZhangWenhui on 2017/4/19.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SMCornerRadius)

- (void)addCorner:(CGFloat)radius
          bgColor:(UIColor *)bgColor
      borderWidth:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor;

@end
