//
//  NSData+Base64.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/2/2.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

/**
 *  @brief  字符串base64后转data
 *
 *  @param string 传入字符串
 *
 *  @return 传入字符串 base64后的data
 */
+ (NSData *)base64_dataWithBase64EncodedString:(NSString *)string;

/**
 *  @brief  NSData转string
 *
 *  @param wrapWidth 换行长度  76  64
 *
 *  @return base64后的字符串
 */
- (NSString *)base64_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

/**
 *  @brief  NSData转string 换行长度默认64
 *
 *  @return base64后的字符串
 */
- (NSString *)base64_base64EncodedString;


+ (NSString *)base64_dataWithBase64DeEncodedString:(NSString *)string;


@end
