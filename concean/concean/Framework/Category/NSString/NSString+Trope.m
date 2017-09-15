//
//  NSString+Trope.m
//  SMZDM
//
//  Created by ZhangWenhui on 15/9/14.
//  Copyright (c) 2015年 smzdm. All rights reserved.
//

#import "NSString+Trope.h"

@implementation NSString (Trope)

- (NSString *)getUse_Time
{
    NSMutableString *use_Time = [NSMutableString string];
    if (self && self.length) {
        [use_Time appendString:@"使用时长："];
        if ([self isEqualToString:@"0"]) {
            [use_Time appendString:@"没用过"];
        } else if ([self isEqualToString:@"1"]) {
            [use_Time appendString:@"短暂体验"];
        } else if ([self isEqualToString:@"2"]) {
            [use_Time appendString:@"1-3个月"];
        } else if ([self isEqualToString:@"3"]) {
            [use_Time appendString:@"3个月-1年"];
        } else if ([self isEqualToString:@"4"]) {
            [use_Time appendString:@"1年-5年"];
        } else if ([self isEqualToString:@"5"]) {
            [use_Time appendString:@"5年及以上"];
        }
    }
    
    return use_Time;
}

- (NSString *)getPro_Score
{
    NSString *pro_score = nil;
    if (self) {
        switch ([self integerValue]) {
            case 0:
            {
                pro_score = nil;
                break;
            }
            case 1:
            {
                pro_score = @"很差";
                break;
            }
            case 2:
            {
                pro_score = @"较差";
                break;
            }
            case 3:
            {
                pro_score = @"一般";
                break;
            }
            case 4:
            {
                pro_score = @"推荐";
                break;
            }
            case 5:
            {
                pro_score = @"力荐";
                break;
            }
            default:
            {
                pro_score = nil;
                break;
            }
        }
    }
    return pro_score;
}

- (NSArticleChannelType)getChannelType
{
    if (self && [self trim].length) {
        if ([self isEqualToString:@"1"]) {
            return NSArticleChannelTypeYouHui;
        } else if ([self isEqualToString:@"2"]) {
            return NSArticleChannelTypeFaXian;
        } else if ([self isEqualToString:@"3"]) {
            return NSArticleChannelTypeShaiWu;
        } else if ([self isEqualToString:@"4"]) {
            return NSArticleChannelTypeJingYan;
        } else if ([self isEqualToString:@"5"]) {
            return NSArticleChannelTypeHaiTao;
        } else if ([self isEqualToString:@"6"]) {
            return NSArticleChannelTypeZiXun;
        } else if ([self isEqualToString:@"7"] || [self isEqualToString:@"8"]) {
            return NSArticleChannelTypeZhongCe;
        } else if ([self isEqualToString:@"10"]) {
            return NSArticleChannelTypeZhuanTi;
        } else if ([self isEqualToString:@"11"]) {
            return NSArticleChannelTypeYuanChuang;
        } else if ([self isEqualToString:@"14"]) {
            return NSArticleChannelTypeBKTopic;
        }
    }
    return NSArticleChannelTypeDefault;
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isChannelYouHui
{
    return (NSArticleChannelTypeYouHui == [self getChannelType]);
}

- (BOOL)isChannelFaXian
{
    return (NSArticleChannelTypeFaXian == [self getChannelType]);
}

- (BOOL)isChannelShaiWu
{
    return (NSArticleChannelTypeShaiWu == [self getChannelType]);
}

- (BOOL)isChannelJingYan
{
    return (NSArticleChannelTypeJingYan == [self getChannelType]);
}

- (BOOL)isChannelHaiTao
{
    return (NSArticleChannelTypeHaiTao == [self getChannelType]);
}

- (BOOL)isChannelZiXun
{
    return (NSArticleChannelTypeZiXun == [self getChannelType]);
}

- (BOOL)isChannelZhongCe
{
    return (NSArticleChannelTypeZhongCe == [self getChannelType]);
}

- (BOOL)isChannelZhuanTi
{
    return (NSArticleChannelTypeZhuanTi == [self getChannelType]);
}

- (BOOL)isChannelYuanChuang
{
    return (NSArticleChannelTypeYuanChuang == [self getChannelType]);
}

- (BOOL)isChannelBKTopic{
    return (NSArticleChannelTypeBKTopic == [self getChannelType]);
}

- (NSString *)encoding
{
    return self;
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)decoding
{
    return self;
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
