//
//  SMZDMDeviceInfo.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/2/1.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "SMZDMDeviceInfo.h"
#import "UIDevice+Additions.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


#import "SMZDMKeychainIDFA.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@interface SMZDMDeviceInfo ()

@end

@implementation SMZDMDeviceInfo

static SMZDMDeviceInfo *_instance = nil;

+ (SMZDMDeviceInfo *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)updateUniqueIdentifier
{
    NSDate *dateNow = [NSDate date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *stringDate=[dateFormatter stringFromDate:dateNow];
    
    NSString *stringValue = [NSString stringWithFormat:@"%@%@",self.IDFA,stringDate];
    
    NSString *stringEncryption = [Desencryption encryptUseDES:stringValue key:IDFAKEY];
    
    NSLog(@"%@",[stringEncryption URLEncodedString]);
    
    NSString *uniqueIdentifier = [stringEncryption stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    [kStandardUserDefaults setValue:uniqueIdentifier forKey:kDeviceIdKey];
    [kStandardUserDefaults setValue:uniqueIdentifier forKey:kDeviceUniqueIdentifier];
    [kStandardUserDefaults synchronize];
}

- (NSString *)deviceString
{

    return [UIDevice hardwareString];
    //return [UIDevice machineName];
}

- (NSString *)macAddress
{
    return [UIDevice macAddress];
}

- (NSString *)IDFA
{
    return [SMZDMKeychainIDFA sm_IDFA];
//    NSString *UUIDString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    
//    if ([UUIDString isSafeString] && [UUIDString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
//        UUIDString = [SimulateIDFA createSimulateIDFA];
//    }
////    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
////        return [SimulateIDFA createSimulateIDFA];
////    }
//    
//    return UUIDString;
}

- (NSString *)IDFA_AD
{
    NSString *sm_IDFAValue = nil;
    
    if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled) {
        sm_IDFAValue = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] lowercaseString];
        if ([sm_IDFAValue isSafeString] && [sm_IDFAValue isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
            sm_IDFAValue = [SimulateIDFA createSimulateIDFA];
        }
    } else {
        //2.如果取不到,就生成UUID,当成IDFA
        //sm_IDFAValue = [SMZDMKeychainIDFA sm_UUID];
        sm_IDFAValue = [SimulateIDFA createSimulateIDFA];
    }
    
    return sm_IDFAValue;
}

- (NSString *)IDFAencryptDES
{
    return [Desencryption encryptUseDES:self.IDFA key:IDFAKEY];
}

- (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)deviceId
{
    return [[kStandardUserDefaults stringForKey:kDeviceIdKey] isSafeString] ? [kStandardUserDefaults stringForKey:kDeviceIdKey] : @"";
}

- (NSString *)ASId
{
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    } else {
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        } else{
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            } else {
                
                if (asIM.advertisingTrackingEnabled) {
                    
                    NSString *UUIDString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                    
                    if ([UUIDString isSafeString] && [UUIDString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
                        UUIDString = [SimulateIDFA createSimulateIDFA];
                    }
                    return UUIDString;
                    //return [asIM.advertisingIdentifier UUIDString];
                } else {
                    NSString *UUIDString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                    
                    if ([UUIDString isSafeString] && [UUIDString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
                        UUIDString = [SimulateIDFA createSimulateIDFA];
                    }
                    return UUIDString;
                    //return [asIM.advertisingIdentifier UUIDString];
                }
                
            }
        }
    }
}

- (NSString *)IDFV
{
    if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}

- (NSString *)deviceType
{
    NSString *deviceType = nil;
    
    if (IS_IPHONE) {
        deviceType = @"iphone";
    } else if (IS_IPAD) {
        deviceType = @"ipad";
    }
    return deviceType;
}


- (NETWORK_TYPE)getNetworkTypeFromStatusBar
{
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *subviews = [[[application valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    NETWORK_TYPE netType = NETWORK_TYPE_NONE;
    
    NSNumber *num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    netType = [num intValue];
    
    return netType;
}

//用来辨别设备所使用网络的运营商
- (NSString*)mobileOperatorsName
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil)
    {
        return @"0";
    }
    NSString *code = [carrier mobileNetworkCode];
    NSLog(@"%@",code);
    switch (code.intValue) {
        case 00:
        case 02:
        case 07:
            return @"China Mobile 移动";
            break;
        case 01:
        case 06:
            return @"China Unicom 联通";
            break;
        case 03:
        case 05:
            return @"China Telecom d电信";
            break;
        case 20:
            return @"China Tietong 铁通";
            break;
        default:
            break;
    }
    return @"not in china";
}
- (NSString*)mobileOperatorsName_tanx
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil)
    {
        return @"0";
    }
    NSString *code = [carrier mobileNetworkCode];
    NSLog(@"%@",code);
    switch (code.intValue) {
        case 00:
        case 02:
        case 07:
            return @"1";
            break;
        case 01:
        case 06:
            return @"2";
            break;
        case 03:
        case 05:
            return @"3";
            break;
        case 20:
            return @"0";
            break;
        default:
            break;
    }
    return @"0";
}
- (CGFloat)devicePixel_Ratio
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat dpi = 0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        dpi = 132 * scale;
        
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        dpi = 163 * scale;
        
    } else {
        
        dpi = 160 * scale;
        
    }
    return dpi;
}
- (NSString *)devicePPI
{
    return nil;
}

- (long double)deviceDPI
{
    long double dpi = sqrtl(powl(SCREEN_WIDTH, 2) + powl(SCREEN_HEIGHT, 2));
    return dpi;
}

/**
 *  判断网络是否连接
 *
 *  @return 是否连接
 */
+ (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    
    
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    zeroAddress.sin_family = AF_INET6;
#else
    zeroAddress.sin_family = AF_INET;
#endif
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

- (NSString *)deviceNetType
{
    NSString *deviceNetType = nil;
    
    switch ([self getNetworkTypeFromStatusBar]) {
        case NETWORK_TYPE_NONE:
        {
            deviceNetType = @"noNet_type";
            break;
        }
        case NETWORK_TYPE_2G:
        {
            deviceNetType = @"2G_Net";
            break;
        }
        case NETWORK_TYPE_3G:
        {
            deviceNetType = @"3G_Net";
            break;
        }
        case NETWORK_TYPE_4G:
        {
            deviceNetType = @"4G_Net";
            break;
        }
        case NETWORK_TYPE_LET:
        {
            deviceNetType = @"4G_Net";
            break;
        }
        case NETWORK_TYPE_WIFI:
        {
            deviceNetType = @"WiFi_Net";
            break;
        }
            
        default:
            break;
    }
    
    return deviceNetType;
}
//tanx:
- (NSString*)deviceNetType_tanx
{
    NSString * network = @"0";
    
    switch ([self getNetworkTypeFromStatusBar]) {
        case NETWORK_TYPE_NONE:
        {
            network = @"0";
            break;
        }
        case NETWORK_TYPE_2G:
        {
            network = @"2";
            break;
        }
        case NETWORK_TYPE_3G:
        {
            network = @"3";
            break;
        }
        case NETWORK_TYPE_4G:
        {
            network = @"4";
            break;
        }
        case NETWORK_TYPE_LET:
        {
            network = @"4";
            break;
        }
        case NETWORK_TYPE_WIFI:
        {
            network = @"1";
            break;
        }
            
        default:
            break;
    }
    
    return network;
}
@end
