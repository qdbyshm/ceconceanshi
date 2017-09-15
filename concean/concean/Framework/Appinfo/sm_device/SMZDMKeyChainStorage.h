//
//  SMZDMKeyChainStorage.h
//  SMZDM
//
//  Created by ZhangWenhui on 2017/4/18.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMZDMKeyChainStorage : NSObject

+ (void)sm_save:(NSString *)service data:(id)data;
+ (id)sm_load:(NSString *)service;
+ (void)sm_deleteKeyData:(NSString *)service;

@end
