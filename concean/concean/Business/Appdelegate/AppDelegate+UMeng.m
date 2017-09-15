//
//  AppDelegate+UMeng.m
//  SMZDM
//
//  Created by chenshan on 2017/5/24.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "AppDelegate+UMeng.h"
#import "UIDevice+Additions.h"
//umeng  push 服务
#import "UMessage.h"

#define UMENG_APPKEY @"507d0fa95270157cf000005f"

@implementation AppDelegate (UMeng)
/**
 *  友盟初始化配置
 */
- (void)setupMobClick
{

}

/**
 *  友盟推送初始化配置
 */
- (void)setupUmengPush:(NSDictionary *)launchOptions
{
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:UMENG_APPKEY launchOptions:launchOptions httpsenable:NO];
    //注册通知
    self.isUmengPushOpen = YES;
    [UMessage setBadgeClear:NO];
//    [UMessage registerForRemoteNotifications];
    if (IsIOS8) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
    //for log
    [UMessage setLogEnabled:NO];
    [UMessage setAutoAlert:NO];
    
    [UMessage removeTag:@"smzdm-mrjx"
               response:^(id responseObject, NSInteger remain, NSError *error) {
                   //add your codes
               }];
}

@end
