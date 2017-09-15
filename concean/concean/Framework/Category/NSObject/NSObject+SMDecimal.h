//
//  NSObject+SMDecimal.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/7/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SMDecimal)

/**
 *  求百分比
 *
 *  @param string 第一个参数为分子，之后的 所有参数与第一string参数的 和 为分母，如果分子或分母为0，返回0
 *
 *  @return 百分比
 */
+ (NSString *)sm_StringPercentage:(NSString *)string,... NS_REQUIRES_NIL_TERMINATION;

@end
