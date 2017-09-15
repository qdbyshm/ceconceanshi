//
//  NSString+Size.m
//  SMZDM
//
//  Created by ZhangWenhui on 15/8/31.
//  Copyright (c) 2015年 smzdm. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

/*!
 * @brief  求字符串宽度
 *
 * @param  font-字体大小
 *
 * @return 字符串宽度
 */
- (CGFloat)stringWidth:(UIFont *)font
{
    return ceil([self stringSize:font].width);
}

/*!
 * @brief  求字符串高度
 *
 * @param  font-字体大小
 *
 * @return 字符串高度
 */
- (CGFloat)stringHeight:(UIFont *)font
{
    return ceil([self stringSize:font].height);
}

/*!
 * @brief  固定高度，求字符串宽度
 *
 * @param  font-字体大小
 * @param  height-固定高度
 *
 * @return 字符串高度
 */
- (CGFloat)stringWidth:(UIFont *)font withHeight:(CGFloat)height
{
    return ceil([self stringSize:font constraintSize:CGSizeMake(CGFLOAT_MAX, height)].width);
}

/*!
 * @brief  固定宽度，求字符串高度
 *
 * @param  font-字体大小
 * @param  width-固定宽度
 *
 * @return 字符串宽度
 */
- (CGFloat)stringHeight:(UIFont *)font withWidth:(CGFloat)width
{
    return ceil([self stringSize:font constraintSize:CGSizeMake(width, CGFLOAT_MAX)].height);
}

#pragma mark - private method -
/*!
 * @brief  求字符串size（单行）
 *
 * @param  font-字体大小
 *
 * @return 字符串size
 */
- (CGSize)stringSize:(UIFont *)font
{
    CGSize size = CGSizeZero;
    
    if (IsIOS6) {
        size = [self sizeWithFont:font];
    } else {
        size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    
    return size;
}

/*!
 * @brief  求字符串size（限制定宽或定高）
 *
 * @param  font-字体大小
 * @param  constraintSize-约束size
 *
 * @return 字符串size
 */
- (CGSize)stringSize:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    CGSize size = CGSizeZero;
    
    if (IsIOS6) {
        size = [self sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByClipping];
    } else {
        size = [self boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    
    return size;
}

- (CGSize)stringSizeAttr:(NSMutableDictionary *)attr constraintSize:(CGSize)constraintSize
{
    CGSize size = CGSizeZero;
    
    size = [self boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
    return size;
}

@end
