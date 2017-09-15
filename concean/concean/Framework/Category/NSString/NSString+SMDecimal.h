//
//  NSString+SMDecimal.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/7/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SMDecimal)

/**
 *  求百分比
 *
 *  @param string 如果分子或分母为0，返回'0'
 *
 *  @return 百分比
 */
- (NSString *)sm_percentageString:(NSString *)string,... NS_REQUIRES_NIL_TERMINATION;

@end
