//
//  SMZDMKeyChainStorage.m
//  SMZDM
//
//  Created by ZhangWenhui on 2017/4/18.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "SMZDMKeyChainStorage.h"

@interface SMZDMKeyChainStorage ()

@end

@implementation SMZDMKeyChainStorage

+ (NSMutableDictionary *)sm_getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)sm_save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self sm_getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (id)sm_load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self sm_getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id<NSCopying>)(kSecReturnData)];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id<NSCopying>)(kSecMatchLimit)];
    
//    CFTypeRef result = NULL;
//    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, &result) == noErr)
//    {
//        ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)result];
//    }
//    return ret;
    
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)sm_deleteKeyData:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self sm_getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

@end
