//
//  NSString+Channel.m
//  SMZDM
//
//  Created by sunhaoming on 15/12/8.
//  Copyright © 2015年 smzdm. All rights reserved.
//

#import "NSString+Channel.h"

@implementation NSString (Channel)

- (NSChannelType)getNSChannelType
{
    if (self && [self trim].length && [self isSafeString]) {
        if ([self isEqualToString:@"1"]) {
            return NSChannelTypeYouHui;
        } else if ([self isEqualToString:@"2"]) {
            return NSChannelTypeFaXian;
        } else if ([self isEqualToString:@"3"]) {
            return NSChannelTypeShaiWu;
        } else if ([self isEqualToString:@"4"]) {
            return NSChannelTypeJingYan;
        } else if ([self isEqualToString:@"5"]) {
            return NSChannelTypeHaiTao;
        } else if ([self isEqualToString:@"6"]) {
            return NSChannelTypeZiXun;
        } else if ([self isEqualToString:@"7"] ) {
            return NSChannelTypeZhongCe;
        } else if ([self isEqualToString:@"8"]) {
            return NSChannelTypePingce;
        } else if ([self isEqualToString:@"10"]) {
            return NSChannelTypeZhuanTi;
        } else if ([self isEqualToString:@"11"]) {
            return NSChannelTypeYuanChuang;
        } else if ([self isEqualToString:@"12"]) {
            return NSChannelTypeWikiGoods;
        } else if ([self isEqualToString:@"13"]) {
            return NSChannelTypeWikiComments;
        } else if ([self isEqualToString:@"14"]) {
            return NSChannelTypeWikiTopic;
        } else if ([self isEqualToString:@"15"]) {
            return NSChannelTypeCoupons;
        } else if ([self isEqualToString:@"16"]) {
            return NSChannelTypeSecond;
        } else if ([self isEqualToString:@"17"]) {
            return NSChannelTypeGood;
        } else if ([self isEqualToString:@"18"]) {
            return NSChannelTypeMenHu;
        } else if ([self isEqualToString:@"19"]) {
            return NSChannelTypeHaoWen;
        } else if ([self isEqualToString:@"20"]) {
            return NSChannelTypeColumn;
        } else if ([self isEqualToString:@"21"]) {
            return NSChannelTypePersonal;
        } else if ([self isEqualToString:@"22"]) {
            return NSChannelTypeShai;
        } else if ([self isEqualToString:@"25"]) {
            return NSChannelTypeCoupons_s;
        } else if ([self isEqualToString:@"31"]) {
            return NSChannelTypeCuttingEdge;
        }else if ([self isEqualToString:@"38"]) {
            return NSChannelTypeVideoList;
        }else if ([self isEqualToString:@"39"]) {
            return NSChannelTypeSelectList;
        }
    }
    return NSChannelTypeDefault;
}

- (NSChannelType)getChannelTypeAccordingText{
    if (self && [self trim].length && [self isSafeString]){
        //可能不全
        if ([self isEqualToString:@"youhui"]) {
            return NSChannelTypeYouHui;
        } else if ([self isEqualToString:@"haitao"]) {
            return NSChannelTypeHaiTao;
        } else if ([self isEqualToString:@"faxian"]) {
            return NSChannelTypeFaXian;
        } else if ([self isEqualToString:@"second_hand"]) {
            return NSChannelTypeSecond;
        } else if ([self isEqualToString:@"yuanchuang"]) {
            return NSChannelTypeYuanChuang;
        } else if ([self isEqualToString:@"shai"]) {
            return NSChannelTypeShai;
        } else if ([self isEqualToString:@"news"]) {
            return NSChannelTypeZiXun;
        } else if ([self isEqualToString:@"zhongce"]) {
            return NSChannelTypePingce;
        } else {
            return NSChannelTypeDefault;
        }
    }
    return NSChannelTypeDefault;
}

- (BOOL)isChannelTypeYouHui
{
    return (NSChannelTypeDefault == [self getNSChannelType]);
}

- (BOOL)isChannelTypeFaXian
{
    return (NSChannelTypeFaXian == [self getNSChannelType]);
}

- (BOOL)isChannelTypeShaiWu
{
    return (NSChannelTypeShaiWu == [self getNSChannelType]);
}

- (BOOL)isChannelTypeJingYan
{
    return (NSChannelTypeJingYan == [self getNSChannelType]);
}

- (BOOL)isChannelTypeHaiTao
{
    return (NSChannelTypeHaiTao == [self getNSChannelType]);
}
- (BOOL)isChannelTypeZiXun
{
    return (NSChannelTypeZiXun == [self getNSChannelType]);
}

- (BOOL)isChannelTypeZhongCe
{
    return (NSChannelTypeZhongCe == [self getNSChannelType]);
}

- (BOOL)isChannelTypePingce
{
    return (NSChannelTypePingce == [self getNSChannelType]);
}

- (BOOL)isChannelTypeZhuanTi
{
    return (NSChannelTypeZhuanTi == [self getNSChannelType]);
}

- (BOOL)isChannelTypeYuanChuang
{
    return (NSChannelTypeYuanChuang == [self getNSChannelType]);
}

- (BOOL)isChannelTypeWikiGoods
{
    return (NSChannelTypeWikiGoods == [self getNSChannelType]);
}

- (BOOL)isChannelTypeWikiComments
{
    return (NSChannelTypeWikiComments == [self getNSChannelType]);
}

- (BOOL)isChannelTypeWikiTopic
{
    return (NSChannelTypeWikiTopic == [self getNSChannelType]);
}

- (BOOL)isChannelTypeCoupons
{
    return (NSChannelTypeCoupons == [self getNSChannelType]);
}

- (BOOL)isChannelTypeColumn
{
    return (NSChannelTypeColumn == [self getNSChannelType]);
}

@end
