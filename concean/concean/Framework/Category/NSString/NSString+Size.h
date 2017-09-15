//
//  NSString+Size.h
//  SMZDM
//
//  Created by ZhangWenhui on 15/8/31.
//  Copyright (c) 2015年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

/*!
 * @brief  求字符串宽度
 *
 * @param  font-字体大小
 *
 * @return 字符串宽度
 */
- (CGFloat)stringWidth:(UIFont *)font;

/*!
 * @brief  求字符串高度
 *
 * @param  font-字体大小
 *
 * @return 字符串高度
 */
- (CGFloat)stringHeight:(UIFont *)font;

/*!
 * @brief  固定高度，求字符串宽度
 *
 * @param  font-字体大小
 * @param  height-固定高度
 *
 * @return 字符串高度
 */
- (CGFloat)stringWidth:(UIFont *)font withHeight:(CGFloat)height;

/*!
 * @brief  固定宽度，求字符串高度
 *
 * @param  font-字体大小
 * @param  width-固定宽度
 *
 * @return 字符串宽度
 */
- (CGFloat)stringHeight:(UIFont *)font withWidth:(CGFloat)width;

/*!
 * @brief  求字符串size（单行）
 *
 * @param  font-字体大小
 *
 * @return 字符串size
 */
- (CGSize)stringSize:(UIFont *)font;

/*!
 * @brief  求字符串size（限制定宽或定高）
 *
 * @param  font-字体大小
 * @param  constraintSize-约束size
 *
 * @return 字符串size
 */
- (CGSize)stringSizeAttr:(NSMutableDictionary *)attr constraintSize:(CGSize)constraintSize;
- (CGSize)stringSize:(UIFont *)font constraintSize:(CGSize)constraintSize;

@end
