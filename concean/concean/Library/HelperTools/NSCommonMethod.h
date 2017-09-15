//
//  NSCommonMethod.h
//  
//
//  Created by ZhangWenhui on 15/7/24.
//  Copyright (c) 2015年 yijimu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScalingWidth(measure)  [NSCommonMethod geometricScalingWidth:(measure)]
#define kScalingHeight(measure) [NSCommonMethod geometricScalingHeight:(measure)]

#define kEqualRatioZoomHeight(scale,width)  [NSCommonMethod geometricScaling:scale fixWidth:width]
#define kEqualRatioZoomWidth(scale,height)  [NSCommonMethod geometricScaling:scale fixHeight:height]

@interface NSCommonMethod : NSObject

+ (CGFloat)geometricScalingWidth:(CGFloat)measure;
+ (CGFloat)geometricScalingHeight:(CGFloat)measure;

/**
 *  等比求高
 *
 *  @param scale 宽/高，（浮点型）
 *  @param width 已知宽度
 *
 *  @return 等比求高
 */
+ (CGFloat)geometricScaling:(CGFloat)scale fixWidth:(CGFloat)width;

/**
 *  等比求宽
 *
 *  @param scale  宽/高，（浮点型）
 *  @param height 已知高度
 *
 *  @return 等比求宽
 */
+ (CGFloat)geometricScaling:(CGFloat)scale fixHeight:(CGFloat)height;

@end
