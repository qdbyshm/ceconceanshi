//
//  UIDevice+Additions.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/2/2.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Additions)

/** This method retruns the hardware type */
+ (NSString *)hardwareString;

/** This method retruns the hardware type */
+ (NSString *)machineName;


+ (NSString *)macAddress;

//Return the current device CPU frequency
+ (NSUInteger)cpuFrequency;

// Return the current device BUS frequency
+ (NSUInteger)busFrequency;

//current device RAM size
+ (NSUInteger)ramSize;

//Return the current device CPU number
+ (NSUInteger)cpuNumber;

/// 获取iOS系统的版本号
+ (NSString *)systemVersion;

/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)totalMemoryBytes;

/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)freeDiskSpaceBytes;

/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)totalDiskSpaceBytes;

+ (NSString *)machineModel;

+ (NSString *)machineModelName;
@end
