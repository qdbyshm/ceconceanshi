//
//  NSDate+Additons.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/1/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Additons)

+ (NSCalendar *)currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;

// Short string utilities
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;

@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

// Comparing dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;

- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;

- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;

- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)isThisMonth;
- (BOOL)isNextMonth;
- (BOOL)isLastMonth;

- (BOOL)isSameYearAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;

- (BOOL)isInFuture;
- (BOOL)isInPast;

// Date roles
- (BOOL)isTypicallyWorkday;
- (BOOL)isTypicallyWeekend;

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

// Adjusting dates
- (NSDate *)dateByAddingYears:(NSInteger)dYears;
- (NSDate *)dateBySubtractingYears:(NSInteger)dYears;
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths;
- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSTimeInterval)dHours;
- (NSDate *)dateBySubtractingHours:(NSTimeInterval)dHours;
- (NSDate *)dateByAddingMinutes:(NSTimeInterval)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSTimeInterval)dMinutes;
- (NSDate *)dateByAddingSeconds:(NSTimeInterval)dSeconds;
- (NSDate *)dateBySubtractingSeconds:(NSTimeInterval)dSeconds;

// Date extremes
- (NSDate *)dateAtStartOfDay;
- (NSDate *)dateAtEndOfDay;

// Retrieving intervals
- (NSTimeInterval)secondsAfterDate:(NSDate *)aDate;
- (NSTimeInterval)secondsBeforeDate:(NSDate *)aDate;
- (NSTimeInterval)minutesAfterDate:(NSDate *)aDate;
- (NSTimeInterval)minutesBeforeDate:(NSDate *)aDate;
- (NSTimeInterval)hoursAfterDate:(NSDate *)aDate;
- (NSTimeInterval)hoursBeforeDate:(NSDate *)aDate;
- (NSTimeInterval)daysAfterDate:(NSDate *)aDate;
- (NSTimeInterval)daysBeforeDate:(NSDate *)aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale ;
- (NSDate *)convertToUTCDate;
- (NSString *)convertToUTCString:(NSString *)format;

@end
