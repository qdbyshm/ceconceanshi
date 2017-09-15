//
//  NSDate+WeekDate.h
//  luckystar
//
//  Created by opda on 12-2-7.
//  Copyright (c) 2012年 opda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WeekDate)

//#星期#  #年月#
+ (NSString *)currentDateMonth;//返回＊＊年＊＊月
+ (NSString *)currentDateWeekStr;//返回  ＃****年**月**日 星期*＃
+ (NSString *)currentWeekStr;//返回  ＃星期＊＃
+ (NSString *)currentDateStr:(NSString *)time;//yyyy年MM月dd日
+ (NSString *)currentDateStyleStr:(NSString *)time;//yyyy-MM-dd hh:mm:ss
+ (NSString *)weekStr:(NSString*) time;
+ (NSInteger)weekStrInt:(NSString*) time;

+ (NSString *)currentDateWeekStr:(NSString *)time;////yyyy年MM月dd日 星期几

+ (NSString *)styleDateFrom:(NSString *)timeStr;//将 yyyy-MM-dd hh:mm:ss 转换为yyyy-MM-dd各式

+ (NSInteger)weekDateInt:(NSDate*) time;

+ (NSInteger)weekOfYear:(NSString*) time;
@end
