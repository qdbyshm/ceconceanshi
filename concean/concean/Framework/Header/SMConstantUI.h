//
//  SMConstantUI.h
//  SMZDM
//
//  Created by 冯展波 on 16/1/19.
//  Copyright © 2016年 smzdm. All rights reserved.
//文案

#ifndef SMConstantUI_h
#define SMConstantUI_h

//导航栏UI设置
#define LOCALTION 44.0
#define NAVIGATIONBAR_HEIGHT (IsIOS7 ? 64 : 44)
#define NAVIGATIONBAR_INTERVAL 0
#define NAVIGATIONBAR_BUTTON_WIDTH 70
#define NAVIGATIONBAR_TITLE_WIDTH 220
#define NAVIGATIONBAR_FRONT_SIZE 18
#define NAVIGATIONBAR_BUTTON_HEIGHT 36
#define NAVIGATIONBAR_CENTER_FONT_SIZE  16
#define NAVIGATIONBAR_BUTTON_FONT_SIZE  12
#define SECSCOLLHIGHT 36
#define NAVANDSECHIGHT 0
#define OFFSETYBYV  -(NAVIGATIONBAR_HEIGHT+SECSCOLLHIGHT)
#define MAIN_HEIGHT_N (NAVIGATIONBAR_HEIGHT+SECSCOLLHIGHT)
#define SECTION_HEIGHT  85

#define SMALL_WID (DEVICE6P?7.0f:0.0f)
#define CELL_ZAN_LEFT 5//搜索cell地下图标距离
//订阅红点tag
#define DingyueDot_tag  201


#define THETIME .7f
#define TIMEINTVAL 8
#define outTimers 20


//string:
#define KNONETWORKMSG @"貌似网络不太稳定，稍后重试。"
#pragma mark - 商品百科列表
static NSString* uniqueIdentifier = @"com.smzdm.client.ios";
static NSString*domainIdentifier = @"searchapis";

#define LastUserAccount @"LastUserAccount"

#define wxLoginSuccess @"weixinLoginSuccess"

#define KNODATASEARCHVC @"KNODATASEARCHVC"
#define NSNOTIFICATION_CHANGESPBKTOTALCOUNT @"NSNOTIFICATION_CHANGESPBKTOTALCOUNT"//当商品百科搜索的时候，修改header总数的值
//#define NSNOTIFICATION_TONGBUSEARCHTEXT @"NSNOTIFICATION_TONGBUSEARCHTEXT"//同步商品百科主要列表和搜索结果页的搜索内容，如果更改搜索结果页搜索内容 返回的时候发出该通知
#define NSNOTIFICATION_DELETEKEYWORD_DINGYUE @"NSNOTIFICATION_DELETEKEYWORD_DINGYUE"
#define NSNOTIFICATION_REGISTERSUCCESS @"NSNOTIFICATION_REGISTERSUCCESS"//关注成功的时候给订阅发个通知
#define NSNOTIFICATION_BROKESUCCESS @"NSNOTIFICATION_BROKESUCCESS"
#define NSNOTIFICATION_SELECTPHOTOCANCEL @"NSNOTIFICATION_SELECTPHOTOCANCEL"//选择相册取消的时候刷新回原来的位置

#pragma mark - 订阅
#define SUBSCRIPTION @"SUBSCRIPTION"//订阅说明链接的key值
//首页轮播图banner高度
#define kBannerHeight kEqualRatioZoomHeight((750.0 / (306.0)), SCREEN_WIDTH)

#pragma mark - 爆料
#define BROKEINFOKEY @"BROKEINFOKEY"//爆料好物文案key值
#define kBrokeClassification @"BrokeClassification" // 爆料已选分类Key
#define MonitorPasteBoardLastKey @"MonitorPasteBoardLastKey"
#define UM_BrokeType_MyBroke @"UM_BrokeType_MyBroke"//我的爆料
#define UM_BrokeType_PasteBroke @"UM_BrokeType_PasteBroke"//剪贴板
#define UM_BrokeType_Touch @"UM_BrokeType_Touch"//3dtouch
//避免扫描返回没有网络的提示
#define QRCodeBack @"QRCodeBack"
#define FirstLaunchingKey @"FirstLaunchingKey"

#define PWDAES          @"smzdmVic"
#define IDFAKEY         @"smzdmidfa18911150977"
#define SIGNINKEY       @"geZm53XAspb02exN"

#define LAST_USER       @"lastUserName"

#define YHTHMSGFIRST @"继续拖动，查看相关推荐"

#define YHTHMSGSECOND @"下拉，返回文章详情"

#define BKTHMSGFIRST @"继续拖动，查看相关推荐"

#define BKTHMSGSECOND @"下拉，返回百科词条"

//热门标签
#define HOT_TAGS @"hot_tags"
#define HOT_VIDEO_TAGS @"hot_video_tags"

// 图片模式
#define IMG_MODE @"image_mode"
#define IMG_HD 0 //高清图
#define IMG_THUMBNAILS 1 //缩略图
#define IMG_NULL 2 //无图
#define SAFAIRISTR @"applink_openmode=1"
#define WXTZSTR @"AA/wx"

// table 的 alpha
#define kTableViewCellAlpha @"tableViewCellBackViewAlpha"

#define kPushToCommentVC @"pushToCommentVC"

#define NIGHT_MAIN @"NIGHT_MAIN_VIEW"

#define NIGHTNOTIFICATION @"NIGHTSTYLESWITCH"

#define REFRESHZCDETAIL @"RefreshZCDetail"
#define REFRESHDINGYUELIST @"RefreshDingyueList"
#define KSTATUSBAERCHANGE @"KSTATUSBAERCHANGE"

//好文

//卡片间距
#define SEPARATE_HEIGHT 10.0

//颜色
#define GOOD_ARTICLE_BG_COLOR [UIColor color_background]
#define GOOD_ARTICLE_TITLE_COLOR [UIColor color_title]
#define GOOD_ARTICLE_YET_BROWSE_COLOR [UIColor color_yetBrowse]
#define GOOD_ARTICLE_ACCESSORY_COLOR [UIColor color_accessory]
#define GOOD_ARTICLE_COMPANY_COLOR [UIColor color_company]
#define GOOD_ARTICLE_SUBTITLE_COLOR [UIColor color_subtitle]
#define GOOD_ARTICLE_SEPARATOR_COLOR [UIColor color_separator]
#define GOOD_ARTICLE_DARKGRAY_COLOR [UIColor color_darkgray]

//字体
#define GOOD_ARTICLE_BOLD_FONT_WITH_SIZE(fontSize) [UIFont boldFontWithSize:fontSize]
#define GOOD_ARTICLE_FONT_WITH_SIZE(fontSize) [UIFont fontWithSize:fontSize]

#define SEARCH_VIEW_HEIGHT  34.0

#define kGoodArticleDraft @"GoodArticleDraft"

#endif /* SMConstantUI_h */
