//
//  SMConstant.h
//  SMZDM
//
//  Created by 冯展波 on 16/1/19.
//  Copyright © 2016年 smzdm. All rights reserved.
//高度

#ifndef SMConstant_h
#define SMConstant_h

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define kClearColor [UIColor clearColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]

#define NAVIGATION_COLOR @"#F04848"

#define KREDCOLOR [UIColor colorWithHexString:@"#f04848"]

// 图片全局透明度
#define IMGALPHA  ([AppDelegate getAppDelegate].dataController.isNight)?0.7f:1.0f

#define ALPHAIMG 0.3f



#define DETAIL_GXB_C @"DETAIL_GXB_C"

#define DEVICE6P [[CommUtls getDeviceBounds] isEqualToString:@"6p"]

#define DEVICESIX [[CommUtls getDeviceBounds] isEqualToString:@"6"]

#define DEVICEFIVE [[CommUtls getDeviceBounds] isEqualToString:@"5"]

#define DEVICEFOUR [[CommUtls getDeviceBounds] isEqualToString:@"4"]


#define SafeRelease(_v) if(_v != nil){  _v = nil;}

#define SafeReleaseFromSuper(_v) if(_v != nil){  if(_v.superview){[_v removeFromSuperview];} }


#define NodeExist(node) (node != nil && ![node isEqual:[NSNull null]])

#define IsIOS71 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.1? YES : NO)

#define IsIOS6 ([[[UIDevice currentDevice] systemVersion] doubleValue] < 7.0? YES : NO)
#define IsIOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0? YES : NO)
#define IsIOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0? YES : NO)
#define IsIOS9 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0? YES : NO)
#define IsIOS10 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0? YES : NO)
#define IsIOS11 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0? YES : NO)


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_HTTP_SUCCESS_CODE(aRequest) (aRequest.responseStatusCode == 200)

#define StatusbarSize ((IsIOS7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)
#define StatusbarHeight ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0?20.f:0.f)


#define APP_STATUSBAR_HEIGHT                (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))


// 沙河ducument
#define MAINDBPATH [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// 设备编号 S
#define DEVICE_SEVERID [SMZDMDeviceInfo shareInstance].deviceId

#define VIEWWIDTH self.view.frame.size.width
#define VIEWHEIGHT self.view.frame.size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define VIEWOF(view) (view.frame.origin.y+view.frame.size.height)
#define VIEWOF_W(view) (view.frame.origin.x+view.frame.size.width)
#define VIEWOF_L(view) view.frame.origin.x


#define CONVERTOWIDTH_6(h) (SCREEN_WIDTH * h)/320.0f //按比例转换后的宽度
#define CONVERTOHEIGHT_6(h) (SCREEN_HEIGHT * h)/568.0f //按比例转换后的高度
#define CONVERTOWIDTH_5(h)  (SCREEN_WIDTH * h)/375.0f //按比例转换后的宽度
#define CONVERTOHEIGHT_5(h)  (SCREEN_HEIGHT * h)/667.0f //按比例转换后的宽度

static CGFloat kLeftMargin = 10;//TagView中title距离按钮边框左边的像素
static CGFloat kRightMargin = 10;//TagView中title距离按钮边框右边的像素

#define KMAINTOOLBARHIGHT 50

#define YHDetailReoprtActionTag 10086

#define HEIGHT ([[UIScreen mainScreen] bounds].size.width < 480?[[UIScreen mainScreen] bounds].size.width:[[UIScreen mainScreen] bounds].size.height)

//三方sdk
//sina
#define kAppKey @"908111949"
#define kRedirectURI @"https://www.smzdm.com"

//微信
#define WEIXIN_AppID                         @"wxed08b6c4003b1fd5"
#define WEIXIN_AppSecret                     @"8269ed5aceca893987d47d59f134e205"
#define WEIXIN_MiniID                        @"gh_b2811085f416"

//qq
#define __TencentApiSdk_For_TencentApp_ 0
#define __Project_ARC__ 1
#define __TencentDemoAppid_  @"100261768"
#define nick_color  [CommUtls colorWithHexString:@"#333333"]
#define out_color   [CommUtls colorWithHexString:@"#5a5a5a"]
#define in_color    [CommUtls colorWithHexString:@"#666666"]
#define floor_color [CommUtls colorWithHexString:@"#cccccc"]
#define in_name_color    [CommUtls colorWithHexString:@"#5e5e5e"]
#define kStandardUserDefaults [NSUserDefaults standardUserDefaults]


#define kCommentEmojiRangexStr @"\\[([^\\[\\]]+)\\]"
#endif /* SMConstant_h */
