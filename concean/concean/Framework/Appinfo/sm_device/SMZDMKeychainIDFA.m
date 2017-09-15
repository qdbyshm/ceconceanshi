//
//  SMZDMKeychainIDFA.m
//  SMZDM
//
//  Created by ZhangWenhui on 2017/4/18.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "SMZDMKeychainIDFA.h"
#import "SMZDMKeyChainStorage.h"

@import AdSupport;

@interface SMZDMKeychainIDFA ()

@end

@implementation SMZDMKeychainIDFA

+ (void)sm_deleteIDFA
{
    [SMZDMKeyChainStorage sm_deleteKeyData:SMZDM_IDFA_STRING];
}

+ (NSString *)sm_IDFA
{
    //0、读取keyChain中的IDFA
    NSString *sm_IDFAValue = [SMZDMKeyChainStorage sm_load:SMZDM_IDFA_STRING];
    
    if (![sm_IDFAValue isSafeString]) {
        //1.取IDFA,可能会取不到,如用户关闭IDFA
        if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled) {
            sm_IDFAValue = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] lowercaseString];
            if ([sm_IDFAValue isSafeString] && [sm_IDFAValue isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
                sm_IDFAValue = [SimulateIDFA createSimulateIDFA];
            }
            [SMZDMKeychainIDFA sm_saveIDFA:sm_IDFAValue];
        } else {
            //2.如果取不到,就生成UUID,当成IDFA
            //sm_IDFAValue = [SMZDMKeychainIDFA sm_UUID];
            sm_IDFAValue = [SimulateIDFA createSimulateIDFA];
            [SMZDMKeychainIDFA sm_saveIDFA:sm_IDFAValue];
        }
    }
    
    return sm_IDFAValue;
}

+ (BOOL)sm_saveIDFA:(NSString *)sm_IDFAValue
{
    BOOL res = NO;
    
    if ([sm_IDFAValue isSafeString]) {
        [SMZDMKeyChainStorage sm_save:SMZDM_IDFA_STRING data:sm_IDFAValue];
        res = YES;
    }
    
    return res;
}

+ (NSString *)sm_UUID
{
    CFUUIDRef uuid_ref = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuid_string_ref= CFUUIDCreateString(kCFAllocatorDefault, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    if (![uuid isSafeString]) {
        uuid = @"";
    }
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

@end
