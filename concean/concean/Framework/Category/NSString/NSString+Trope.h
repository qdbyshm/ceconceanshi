//
//  NSString+Trope.h
//  SMZDM
//
//  Created by ZhangWenhui on 15/9/14.
//  Copyright (c) 2015年 smzdm. All rights reserved.
//  转义

#import <Foundation/Foundation.h>

//article_channel_id	字符串-频道id        1：优惠、国内， 2：发现，3：晒物，4：经验，5：海淘，6：资讯，8：众测，11：原创

//article_channel       字符串-频道id        1：优惠、国内， 2：发现，5：海淘，6：资讯，7：众测，8：评测，10：专题，11：原创

//合并后   字符串-频道id    1：优惠、国内， 2：发现，3：晒物，4：经验，5：海淘，6：资讯，7,8：众测\评测，10：专题，11：原创,14：百科话题

typedef NS_ENUM(NSUInteger, NSArticleChannelType) {
    //默认：错误
    NSArticleChannelTypeDefault = -1,
    //1：优惠、国内
    NSArticleChannelTypeYouHui = 0,
    //2：发现
    NSArticleChannelTypeFaXian = 1,
    //3：晒物
    NSArticleChannelTypeShaiWu = 2,
    //4：经验
    NSArticleChannelTypeJingYan = 3,
    //5：海淘
    NSArticleChannelTypeHaiTao = 4,
    //6：资讯
    NSArticleChannelTypeZiXun = 5,
    //7,8：众测\评测
    NSArticleChannelTypeZhongCe = 6,
    //10：专题
    NSArticleChannelTypeZhuanTi = 7,
    //11：原创
    NSArticleChannelTypeYuanChuang = 8,
    //14：百科话题
    NSArticleChannelTypeBKTopic = 9
};

@interface NSString (Trope)

//使用时长  0:没用过,1:短暂体验,2:1-3个月,3:3个月-1年,4:1年-5年,5:5年及以上
- (NSString *)getUse_Time;

//产品评分  5:力荐,4:推荐,3:一般,2:较差,1:很差
- (NSString *)getPro_Score;

- (NSArticleChannelType)getChannelType;

- (NSString *)trim;

- (BOOL)isChannelYouHui;
- (BOOL)isChannelFaXian;
- (BOOL)isChannelShaiWu;
- (BOOL)isChannelJingYan;
- (BOOL)isChannelHaiTao;
- (BOOL)isChannelZiXun;
- (BOOL)isChannelZhongCe;
- (BOOL)isChannelZhuanTi;
- (BOOL)isChannelYuanChuang;
- (BOOL)isChannelBKTopic;

//Emoji表情转码
- (NSString *)encoding;
- (NSString *)decoding;

@end
