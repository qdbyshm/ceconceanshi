//
//  NSString+ZB.h
//  SMZDM
//
//  Created by zhaobin on 2017/8/17.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZB)

/**
 获取字节数（英文字母1个字节，汉字2个字节）

 @return 字节数
 */
- (NSInteger)getByteLength;

/**
 删除字符串中的HTML（包含换行空格等特殊符号）

 @return 过滤后的字符串
 */
- (NSString *)removeHTML;

/**
 获取html中img的地址

 @return 地址集合
 */
- (NSArray *)filterImage;

/**
 按字节数截取字符串

 @param index 字节数
 @return 截取后的字符串
 */
- (NSString *)subStringByByteWithIndex:(NSInteger)index;

@end
