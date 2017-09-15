//
//  SMZDMKeychainIDFA.h
//  SMZDM
//
//  Created by ZhangWenhui on 2017/4/18.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

//设置你idfa的Keychain标示,该标示相当于key,而你的IDFA是value
#define SMZDM_IDFA_STRING @"com.smzdm.client.ios.idfa"

@interface SMZDMKeychainIDFA : NSObject

//获取IDFA
+ (NSString*)sm_IDFA;

//删除keychain的IDFA(一般不需要)
+ (void)sm_deleteIDFA;

@end
