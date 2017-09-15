//
//  SMZDMDeviceInfo.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/2/1.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

//@"DeviceUniqueIdentifier"
#define kDeviceIdKey    @"SEVERID"
#define kDeviceUniqueIdentifier @"localS"

////  网络类型
typedef NS_ENUM(NSUInteger, NETWORK_TYPE) {
    //没有联网
    NETWORK_TYPE_NONE = 0,
    //2G
    NETWORK_TYPE_2G = 1,
    //3G
    NETWORK_TYPE_3G = 2,
    //4G
    NETWORK_TYPE_4G = 3,
    //LTE
    NETWORK_TYPE_LET = 4,
    //WiFi
    NETWORK_TYPE_WIFI = 5
};

@interface SMZDMDeviceInfo : NSObject

@property (nonatomic, strong, readonly) NSString *deviceString;
@property (nonatomic, strong, readonly) NSString *macAddress;
@property (nonatomic, strong, readonly) NSString *IDFA;
@property (nonatomic, strong, readonly) NSString *IDFA_AD;
@property (nonatomic, strong, readonly) NSString *IDFAencryptDES;
@property (nonatomic, strong, readonly) NSString *systemVersion;
@property (nonatomic, strong, readonly) NSString *deviceId;
@property (nonatomic, strong, readonly) NSString *ASId;
@property (nonatomic, strong, readonly) NSString *IDFV;
@property (nonatomic, strong, readonly) NSString *mobileOperatorsName;


/**
 dpi和ppi这两个是密度单位，不是度量单位
 */
//ppi (pixels per inch)：像素密度、每英寸像素数
@property (nonatomic, strong, readonly) NSString *devicePPI;
//dpi (dots per inch)： 打印分辨率 （每英寸所能打印的点数，即打印精度）
@property (nonatomic, assign, readonly) long double deviceDPI;

//设备类型：iphone or ipad
@property (nonatomic, strong) NSString *deviceType;
//网络类型
@property (nonatomic, strong) NSString *deviceNetType;
@property (nonatomic, strong) NSString * deviceNetType_tanx;
@property (nonatomic, strong) NSString * mobileOperatorsName_tanx;
//密度
@property (nonatomic, assign) CGFloat  devicePixel_Ratio;


+ (SMZDMDeviceInfo *)shareInstance;
- (void)updateUniqueIdentifier;

@end
