//
//  SMUserMacroHeader.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/8/9.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#ifndef SMUserMacroHeader_h
#define SMUserMacroHeader_h
#define kOnePixel_LINE  (1 / [UIScreen mainScreen].scale)
#define kOnePixel_LINE_ADJUST_OFFSET  (kOnePixel_LINE / 2)
#define kHaveAnyNetwork [CommUtls checkConnectNet]

#define kNoWifiPromptHud    if (![CommUtls checkConnectNet]) {\
[[HUDShare shareInstance] showFail:KNONETWORKMSG];\
return;\
}
#define kNavigationController   [AppDelegate getAppDelegate].nav

#define kDataController [AppDelegate getAppDelegate].dataController

#define kRootViewVC [AppDelegate getAppDelegate].rootViewVC

#define kShowNoNetworkMSG       [[HUDShare shareInstance] showFail:KNONETWORKMSG];
#define kShowMSG(text)                [[HUDShare shareInstance] showFail:text];

#define kWifiNet    [CommUtls isWiFiNet]

#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;
#define smWeak(object)      autoreleasepool {} __weak __typeof(object) weak##_##object = object;
#define smStrong(object)    autoreleasepool {} __strong __typeof(object) object = weak##_##object;

#endif /* SMUserMacroHeader_h */
