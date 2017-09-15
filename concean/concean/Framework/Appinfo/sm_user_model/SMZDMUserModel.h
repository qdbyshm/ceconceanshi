//
//  SMZDMUserModel.h
//  SMZDM
//
//  Created by 法良涛 on 16/1/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMZDMUserModel : NSObject

#pragma mark - 登录信息

//用户token
@property (nonatomic, copy) NSString * user_token; //使用token判断登录状态

//用户登陆名
@property (nonatomic, copy) NSString * user_login;

//用户smzdmid
@property (nonatomic, copy) NSString * user_smzdm_id;

#pragma mark - 个人信息
//用户邮箱
@property (nonatomic, copy) NSString * user_email;

//用户昵称
@property (nonatomic, copy) NSString * display_name;

//meta相关
@property (nonatomic, copy) NSString * cpoints;                        //积分
@property (nonatomic, copy) NSString * cexperience;                    //经验值
@property (nonatomic, copy) NSString * cgold;                          //金币
@property (nonatomic, copy) NSString * cprestige;                      //威望
@property (nonatomic, copy) NSString * rank;                           //等级
@property (nonatomic, copy) NSString * user_description;               //用户自我描述
@property (nonatomic, copy) NSString * avatar;                         //用户头像地址

//checkin相关
@property (nonatomic, copy) NSString * has_checkin;                    //今日是否已签到(网站)
@property (nonatomic, copy) NSString * daily_attendance_number;        //连续签到天数
@property (nonatomic, copy) NSString * client_has_checkin;             //客户端今日是否已签到
@property (nonatomic, copy) NSString * weixin_has_checkin;             //微信今日是否已签到

//个人中心头像装饰图url
@property (nonatomic, copy) NSString * avatar_ornament;

//个人中心头像装饰图url(夜间模式)
@property (nonatomic, copy) NSString * avatar_ornament_yejian;

//个人中心背景图
@property (nonatomic, copy) NSString * banner;

//禁止评论
@property (nonatomic, copy) NSString * ban_comment;

//禁止爆料
@property (nonatomic, copy) NSString * ban_baoliao;

//用户剩余碎银数
@property (nonatomic, copy) NSString * remainingSilver;

//用户当日已打赏的金币数
@property (nonatomic, copy) NSString * dayHasRewardGold;

//每日打赏超过此金币额度需安全验证
@property (nonatomic, copy) NSString * dayRewardGoldLimit;

//每次打赏超过此额度需安全验证
@property (nonatomic, copy) NSString * singleRewardGoldLimit;

//是否设置安全码
@property (nonatomic, copy) NSString * is_set_safepass;

//幸运屋文案
@property (nonatomic, copy) NSString * luckyHouseText;

//我的礼包文案
@property (nonatomic, copy) NSString * giftbagText;

//优惠券文案
@property (nonatomic, copy) NSString * couponText;

//礼品兑换文案
@property (nonatomic, copy) NSString * exchangeText;

//盛放徽章的数组
@property (nonatomic, copy) NSArray * medals;

//盛放收藏、爆料数目的数组
@property (nonatomic, copy) NSArray * detailNumbers;


//主页的各个Count
@property (nonatomic, copy) NSString * baoliao_count;
@property (nonatomic, copy) NSString * yuanchuang_count;
@property (nonatomic, copy) NSString * zhongce_count;
@property (nonatomic, copy) NSString * second_count;
@property (nonatomic, copy) NSString * wiki_count;
@property (nonatomic, copy) NSString * favorite_count;


//en_key
@property (nonatomic, copy) NSString * en_key;
@property (nonatomic, copy) NSString * server_time;

//fans、follower 粉丝、关注
@property (nonatomic, copy) NSString * fans_num;
@property (nonatomic, copy) NSString * follower_num;

//是否开启一键海淘
@property (nonatomic, copy) NSString * isOpenOneKeyOut;

//是否打开勋章功能
@property (nonatomic, copy) NSString * is_show_my_medal;

//是否绑定过visa
@property (nonatomic, copy) NSString * is_bind_visa;

//是否视频白名单用户
@property (nonatomic, copy) NSString * video_is_show;

//是否直播白名单用户
@property (nonatomic, copy) NSString * live_is_show;

//接收爆料评论的开关v8.2
@property (nonatomic, copy) NSString * baoliao_comment_msg;

//取出当前的用户
+ (SMZDMUserModel*)currentUser;

//是否登录
+ (BOOL)isLogin;

//登陆后刷新用户的数据
+ (void)refreshCurrentUser;

//保存信息
+ (void)insertUserInfo:(NSDictionary*)dict;

//退出登录 删除用户信息
+ (void)ExitUserInfo:(NSDictionary *)dict;

+ (void)gotoTAHomepage:(NSDictionary*)dict;

@end
