//
//  NSObject+SMDecimal.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/7/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSObject+SMDecimal.h"

@implementation NSObject (SMDecimal)

+ (NSString *)sm_StringPercentage:(NSString *)string,...
{
    if (![string isSafeString]) {
        return @"0";
    }
    
    //参数求和
    //NSMutableString *stringTotal = [NSMutableString string];
    
    //第一个参数所占百分比
    //NSMutableString *stringValue = [NSMutableString string];
    
    NSDecimalNumber *numeratorNumber = [NSDecimalNumber decimalNumberWithString:[string safeString]];
    NSDecimalNumber *totalNumber = [[NSDecimalNumber zero] decimalNumberByAdding:numeratorNumber];
    
    NSString *eachObject = nil;
    va_list varlist;
    va_start(varlist, string);
    while ((eachObject = va_arg(varlist, NSString *))) {
        NSLog(@"%@",eachObject);
        NSDecimalNumber *tempNumber = [NSDecimalNumber decimalNumberWithString:[eachObject safeString]];
        totalNumber = [totalNumber decimalNumberByAdding:tempNumber];
    }
    va_end(varlist);
    
    //stringTotal = totalNumber.stringValue;
    
    //保留小数点后两位
    NSDecimalNumberHandler *roundBankers = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *percentageNumber = [numeratorNumber decimalNumberByDividingBy:totalNumber withBehavior:roundBankers];
    
    if ([percentageNumber isEqualToNumber:[NSDecimalNumber notANumber]]) {
        return @"0";
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
    NSLog(@"%@",[numberFormatter stringFromNumber:percentageNumber]);
    
    return [numberFormatter stringFromNumber:percentageNumber];
}

@end
