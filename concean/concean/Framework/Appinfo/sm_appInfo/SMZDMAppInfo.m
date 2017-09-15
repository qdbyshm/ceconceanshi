//
//  SMZDMAppInfo.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/2/2.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "SMZDMAppInfo.h"

@interface SMZDMAppInfo ()

@end

static SMZDMAppInfo *_instance = nil;

@implementation SMZDMAppInfo

+ (SMZDMAppInfo *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        _instance.landingStatusChange = NO;
        _instance.unread = @"0";
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

- (NSDictionary *)infoDictionary
{
    return [[NSBundle mainBundle] infoDictionary];
}

- (NSString *)CFBundleShortVersionString
{
    return [self infoDictionary][@"CFBundleShortVersionString"];
}

- (NSString *)CFBundleVersion
{
    return [self infoDictionary][@"CFBundleVersion"];
}

- (NSString *)CFBundleDisplayName
{
    return [self infoDictionary][@"CFBundleDisplayName"];
}

- (NSString *)CFBundleName
{
    return [self infoDictionary][@"CFBundleName"];
}

- (NSString *)appName
{
    if (![self CFBundleDisplayName]) {
        return [self CFBundleName];
    }
    
    return [self CFBundleDisplayName];
}

@end
