//
//  NSDate+WeekDate.m
//  luckystar
//
//  Created by opda on 12-2-7.
//  Copyright (c) 2012年 opda. All rights reserved.
//

#import "NSDate+WeekDate.h"
#import "CommUtls.h"
@implementation NSDate (WeekDate)

//yyyy年MM月dd日 星期三
+ (NSString *)currentDateWeekStr:(NSString *)time
{
    NSCalendar *_cal = [NSCalendar currentCalendar];
    NSDate *date = [CommUtls dencodeTime:time];
    
    //年月日
    NSString *str1 = @"";
    NSDateFormatter *_dateFormate = [[NSDateFormatter alloc] init];
    [_dateFormate setDateFormat:@"yyyy年MM月dd日"];
    str1 = [_dateFormate stringFromDate:date];
    
    //周
    NSDateComponents *_components = [_cal components:NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    NSString *str2 = @"";
    switch ([_components weekday]) 
    {
        case 1:
            str2 = @"星期日";
            break;
        case 2:
            str2 = @"星期一";
            break;
        case 3:
            str2 = @"星期二";
            break;
        case 4:
            str2 = @"星期三";
            break;
        case 5:
            str2 = @"星期四";
            break;
        case 6:
            str2 = @"星期五";
            break;
        case 7:
            str2 = @"星期六";
            break;
            
        default:
            break;
    }
    
    if ( str1.length >0 && str2.length>0 ) 
    {
        return  [NSString stringWithFormat:@"%@%@",str1,str2];
    }
    return @"";
}

//返回  #****年**月#
+ (NSString *)currentDateMonth
{
    NSDate *date = [NSDate date];
    NSDateFormatter *_dateFormate = [[NSDateFormatter alloc] init];
    [_dateFormate setDateFormat:@"yyyy年MM月"];
    NSString *str1 = [_dateFormate stringFromDate:date];
    return str1;
}

//返回  ＃****年**月**日 星期*＃
+ (NSString *)currentDateWeekStr
{
    NSCalendar *_cal = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    
    //年月日
    NSString *str1 = @"";
    NSDateFormatter *_dateFormate = [[NSDateFormatter alloc] init];
    [_dateFormate setDateFormat:@"yyyy年MM月dd日"];
    str1 = [_dateFormate stringFromDate:date];
    
    //周
    NSDateComponents *_components = [_cal components:NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    NSString *str2 = @"";
    switch ([_components weekday]) 
    {
        case 1:
            str2 = @"星期日";
            break;
        case 2:
            str2 = @"星期一";
            break;
        case 3:
            str2 = @"星期二";
            break;
        case 4:
            str2 = @"星期三";
            break;
        case 5:
            str2 = @"星期四";
            break;
        case 6:
            str2 = @"星期五";
            break;
        case 7:
            str2 = @"星期六";
            break;
            
        default:
            break;
    }
    
    if ( str1.length >0 && str2.length>0 ) 
    {
        return  [NSString stringWithFormat:@"%@%@",str1,str2];
    }
    return @"";
}


+ (NSString *)currentWeekStr
{
    NSCalendar *_cal = [NSCalendar currentCalendar];
    NSDate *_date = [NSDate date];
    NSDateComponents *_components = [_cal components:NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitMonth fromDate:_date];
    
    NSString *_weekStr = @"";
    switch ([_components weekday]) 
    {
        case 1:
            _weekStr = @"星期日";
            break;
        case 2:
            _weekStr = @"星期一";
            break;
        case 3:
            _weekStr = @"星期二";
            break;
        case 4:
            _weekStr = @"星期三";
            break;
        case 5:
            _weekStr = @"星期四";
            break;
        case 6:
            _weekStr = @"星期五";
            break;
        case 7:
            _weekStr = @"星期六";
            break;
            
        default:
            break;
    }
    
    return _weekStr;
}

+ (NSString *)currentDateStr:(NSString *)time
{
    NSDateFormatter *_dateFormate = [[NSDateFormatter alloc] init];
    [_dateFormate setDateFormat:@"yyyy年MM月dd日"];
    NSString *_dateStr = [_dateFormate stringFromDate:[CommUtls dencodeTime:time]];
    return _dateStr;
}

+ (NSString *)currentDateStyleStr:(NSString *)time
{
    NSDateFormatter *_dateFormate = [[NSDateFormatter alloc] init];
    [_dateFormate setDateFormat:@"yyyy-MM-dd hh:MM:ss"];
    NSString *_dateStr = [_dateFormate stringFromDate:[CommUtls dencodeTime:time]];
    return _dateStr;
}

+ (NSString *)weekStr:(NSString*) time
{
    NSCalendar *_cal = [NSCalendar currentCalendar];
    NSDate *_date = [CommUtls dencodeTime:time];
    NSDateComponents *_components = [_cal components:NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitMonth fromDate:_date];
    
    NSString *_weekStr = @"";
    switch ([_components weekday]) 
    {
        case 1:
            _weekStr = @"星期日";
            break;
        case 2:
            _weekStr = @"星期一";
            break;
        case 3:
            _weekStr = @"星期二";
            break;
        case 4:
            _weekStr = @"星期三";
            break;
        case 5:
            _weekStr = @"星期四";
            break;
        case 6:
            _weekStr = @"星期五";
            break;
        case 7:
            _weekStr = @"星期六";
            break;
            
        default:
            break;
    }
    
    return _weekStr;
    
}

+ (NSInteger)weekStrInt:(NSString*) time
{
    NSCalendar *_cal = [NSCalendar currentCalendar];
    NSDate *_date = [CommUtls dencodeTime:time];
    NSDateComponents *_components = [_cal components:NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitMonth fromDate:_date];
    if([_components weekday]==1) 
        return [_components weekday]+7;
    else
        return [_components weekday];
}

+(NSInteger)weekOfYear:(NSString*) time
{
    NSCalendar *_cal = [NSCalendar currentCalendar];
    NSDate *_date = [CommUtls dencodeTime:time];
    NSDateComponents *_components = [_cal components:NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitMonth fromDate:_date];
    return [_components weekOfYear];
}
+ (NSString *)styleDateFrom:(NSString *)timeStr
{
    NSDateFormatter *_dateFormate = [[NSDateFormatter alloc] init];
    [_dateFormate setDateFormat:@"yyyy-MM-dd"];
    NSString *_dateStr = [_dateFormate stringFromDate:[CommUtls dencodeTime:timeStr]];
    return _dateStr;
}

+ (NSInteger)weekDateInt:(NSDate*) time
{   
    NSCalendar *_cal = [NSCalendar currentCalendar];
    NSDateComponents *_components = [_cal components:NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitMonth fromDate:time];
    return [_components weekday]-1;
    
}
@end
