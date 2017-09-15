//
//  AppDelegate+AppInnerPush.h
//  SMZDM
//
//  Created by chenshan on 2017/5/24.
//  Copyright © 2017年 smzdm. All rights reserved.
//  监听本地通知

#import "AppDelegate.h"

@interface AppDelegate (Notification)<UNUserNotificationCenterDelegate>

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error;

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler;

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler;

- (void)resigisterPush;

- (void)setupSpikeNotification:(UILocalNotification *)notification on:(UIApplication *)application;

- (void)launchFromNotification:(NSDictionary *)launchOptions;

- (void)pushInfo:(NSDictionary *)postDic;

- (void)checkShowPushAlertOrNot;

- (void)iconClearApplication:(UIApplication *)application;

@end
