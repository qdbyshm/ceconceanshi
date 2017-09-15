//
//  NSString+Channel.h
//  SMZDM
//
//  Created by sunhaoming on 15/12/8.
//  Copyright © 2015年 smzdm. All rights reserved.
//
//1：优惠，2：发现，5：海淘，6：资讯，7：众测产品，8：评测报告，10：专题，11：原创，12：百科商品，13：百科点评，14：百科话题，15：优惠券
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, NSChannelType) {
    //默认：错误
    NSChannelTypeDefault = 0,
    //1：优惠、国内
    NSChannelTypeYouHui = 1,
    //2：发现
    NSChannelTypeFaXian = 2,
    //3：晒物
    NSChannelTypeShaiWu = 3,
    //4：经验
    NSChannelTypeJingYan = 4,
    //5：海淘
    NSChannelTypeHaiTao = 5,
    //6：资讯
    NSChannelTypeZiXun = 6,
    //7：众测产品（评测产品）
    NSChannelTypeZhongCe =7,
    //8：评测报告（众测报告）
    NSChannelTypePingce =8,
    //10：专题
    NSChannelTypeZhuanTi = 10,
    //11：原创
    NSChannelTypeYuanChuang = 11,
    //12：百科商品
    NSChannelTypeWikiGoods = 12,
    //13：百科点评
    NSChannelTypeWikiComments = 13,
    //14：百科话题
    NSChannelTypeWikiTopic = 14,

    NSChannelTypeCoupons = 15,
    //16：闲置
    NSChannelTypeSecond = 16,
    //17：好物
    NSChannelTypeGood = 17,
    //18：首页
    NSChannelTypeMenHu = 18,
    //19：好文
    NSChannelTypeHaoWen = 19,
    //20：专栏
    NSChannelTypeColumn = 20,
    //21：个人
    NSChannelTypePersonal = 21,
    //22：轻晒单
    NSChannelTypeShai = 22,
    //25：新优惠券
    NSChannelTypeCoupons_s = 25,
    //31：新锐品牌
    NSChannelTypeCuttingEdge = 31,
    //视频
    NSChannelTypeVideoList = 38,
    //选购指南
    NSChannelTypeSelectList = 39

};
@interface NSString (Channel)

- (NSChannelType)getNSChannelType;
- (NSChannelType)getChannelTypeAccordingText;

- (BOOL)isChannelTypeYouHui;
- (BOOL)isChannelTypeFaXian;
- (BOOL)isChannelTypeShaiWu;
- (BOOL)isChannelTypeJingYan;
- (BOOL)isChannelTypeHaiTao;
- (BOOL)isChannelTypeZiXun;
- (BOOL)isChannelTypeZhongCe;
- (BOOL)isChannelTypePingce;
- (BOOL)isChannelTypeZhuanTi;
- (BOOL)isChannelTypeYuanChuang;
- (BOOL)isChannelTypeWikiGoods;
- (BOOL)isChannelTypeWikiComments;
- (BOOL)isChannelTypeWikiTopic;
- (BOOL)isChannelTypeCoupons;
- (BOOL)isChannelTypeColumn;

@end
