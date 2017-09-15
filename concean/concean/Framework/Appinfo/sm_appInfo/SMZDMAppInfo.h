//
//  SMZDMAppInfo.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/2/2.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMZDMAppInfo : NSObject

@property (nonatomic, strong, readonly) NSDictionary *infoDictionary;

@property (nonatomic, strong, readonly) NSString *CFBundleShortVersionString;
@property (nonatomic, strong, readonly) NSString *CFBundleVersion;

@property (nonatomic, strong, readonly) NSString *CFBundleDisplayName;
@property (nonatomic, strong, readonly) NSString *CFBundleName;

@property (nonatomic, strong, readonly) NSString *appName;

+ (SMZDMAppInfo *)shareInstance;

/**
 包括：登陆等处、切换用户登陆；默认为NO
 */
@property (nonatomic, assign) BOOL landingStatusChange;

/**
 首页：我的关注小红点通知条数；默认为：0
 */
@property (nonatomic, strong) NSString *unread;

@end
