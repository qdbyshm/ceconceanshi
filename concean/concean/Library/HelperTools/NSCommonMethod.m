//
//  NSCommonMethod.m
//  
//
//  Created by ZhangWenhui on 15/7/24.
//  Copyright (c) 2015年 yijimu. All rights reserved.
//

#import "NSCommonMethod.h"

@interface NSCommonMethod ()

@end

@implementation NSCommonMethod

+ (CGFloat)geometricScalingWidth:(CGFloat)measure
{
    return ((measure / 375.0) * [[UIScreen mainScreen] bounds].size.width);
    return ceil((measure / 375.0) * [[UIScreen mainScreen] bounds].size.width);
}

+ (CGFloat)geometricScalingHeight:(CGFloat)measure
{
    if (DEVICESIX) {
        return measure;
    }
    return ((measure / 667.0) * [[UIScreen mainScreen] bounds].size.height);
    return ceil((measure / 667.0) * [[UIScreen mainScreen] bounds].size.height);
}

/*!
 * @brief  scale：宽/高
 */
+ (CGFloat)geometricScaling:(CGFloat)scale fixWidth:(CGFloat)width
{
    if (scale == 0) {
        return width;
    }
    CGFloat height = 0.0;
    height = width / scale;
    
    return height;
    return ceil(height);
}

+ (CGFloat)geometricScaling:(CGFloat)scale fixHeight:(CGFloat)height
{
    if (scale == 0) {
        return height;
    }
    CGFloat width = 0.0;
    width = height * scale;
    
    return width;
}

@end
