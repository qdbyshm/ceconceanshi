//
//  NSString+CH.h
//  SMZDM
//
//  Created by 李春慧 on 16/6/27.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CH)


/**
 * 返回加间距文本
 */
- (NSMutableAttributedString *) attributedStringWithLineSpacing:(CGFloat) space  font:(UIFont *) font;

/**
 * 返回V1url
 */
- (NSString *) createUrl;

/**
 * 返回V2url
 */
- (NSString *) createV2Url;

/**
 *  返回多行带间距文本的size
 *
 *  @param font      字体
 *  @param maxW      最大宽度
 *  @param lineSpace 行间距
 *
 *  @return 文本 size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW lineSpaceing:(CGFloat) lineSpace;

/**
 *  返回文本size
 *
 *  @param font 字体
 *
 *  @return 文本 size
 */
- (CGSize)sizeWithFont:(UIFont *)font;


/**
 *  图片转换成字符串
 *
 *  @param image 要转换的图片
 *
 *  @return 字符串
 */
+ (NSString *)sm_base64StringFromImage:(UIImage *)image;



///**
// 获取安全字符串 若为非安全字符串返回@“”
//
// @return 安全字符串
// */
//- (NSString *)getSafeString;



/**
  判断是否为浮点形：

 @return YES or NO
 */
- (BOOL)isPureFloat;


/**
 返回当前屏幕对应的图片名称
 
 @return 图片名称
 */
- (NSString *) currentScreenImageName;


@end

