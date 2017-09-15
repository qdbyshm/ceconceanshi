//
//  PushRelateObject.h
//  SMZDM
//
//  Created by sunhaoming on 2017/6/18.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushRelateObject : NSObject

+ (void)checkAllPushStatus:(void (^ __nullable)(BOOL isAvailable))handler;

+ (void)checkUserFollowPushStatus:(void (^ __nullable)(BOOL isAvailable))handler;
+ (void)checkSystemPushStatus:(void (^ __nullable)(BOOL isAvailable))handler;

+ (void)showUserFollowPushAlert;
+ (BOOL)systemPushIsAvailable;

//推送来源
+ (nonnull NSString *)pushSourceStr:(nonnull NSString *)sourceStr;

@end
