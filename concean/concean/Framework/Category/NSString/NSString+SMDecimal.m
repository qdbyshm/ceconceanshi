//
//  NSString+SMDecimal.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/7/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSString+SMDecimal.h"

@implementation NSString (SMDecimal)

- (NSString *)sm_percentageString:(NSString *)string,...
{
    if (![self isSafeString]) {
        return @"0";
    }
    
    NSDecimalNumber *numeratorNumber = [NSDecimalNumber decimalNumberWithString:[self safeString]];
    NSDecimalNumber *totalNumber = [[[NSDecimalNumber zero] decimalNumberByAdding:numeratorNumber] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[string safeString]]];
    
    NSString *eachObject = nil;
    va_list varlist;
    va_start(varlist, string);
    while ((eachObject = va_arg(varlist, NSString *))) {
        NSLog(@"%@",eachObject);
        NSDecimalNumber *tempNumber = [NSDecimalNumber decimalNumberWithString:[eachObject safeString]];
        totalNumber = [totalNumber decimalNumberByAdding:tempNumber];
    }
    va_end(varlist);
    
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
