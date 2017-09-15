//
//  AppDelegate+AppInnerPush.m
//  SMZDM
//
//  Created by chenshan on 2017/5/24.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "AppDelegate+Notification.h"
#import "UMessage.h"

@implementation AppDelegate (Notification)

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    // [UMessage registerDeviceToken:deviceToken];
    [UMessage registerDeviceToken:deviceToken];
    NSString *deviceTokenString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUserDefaults *defaults = kStandardUserDefaults;
      [defaults setObject:deviceTokenString forKey:@"token"];
    NSLog(@"regisger success:%@", deviceTokenString);
    [defaults synchronize];

 
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
}


- (void)iconClearApplication:(UIApplication *)application{
    if (IsIOS11) {
        if (application.applicationIconBadgeNumber > 0) {
            application.applicationIconBadgeNumber = -1;
        }
    }
    else if(IsIOS10){
        UNTimeIntervalNotificationTrigger *triger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
        UNMutableNotificationContent *content = [UNMutableNotificationContent new];
        content.badge = @(-1);
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"localClearBadge" content:content trigger:triger];
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
    else if(IsIOS9){
        UILocalNotification *localNotifcation = [[UILocalNotification alloc]init];
        localNotifcation.fireDate = [NSDate dateWithTimeIntervalSinceNow:(1*1)];
        localNotifcation.timeZone = [NSTimeZone defaultTimeZone];
        localNotifcation.applicationIconBadgeNumber = -1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotifcation];
    }
    else{
        UILocalNotification *localNotifcation = [[UILocalNotification alloc]init];
        localNotifcation.fireDate = [NSDate dateWithTimeIntervalSinceNow:(1*1)];
        localNotifcation.timeZone = [NSTimeZone defaultTimeZone];
        localNotifcation.applicationIconBadgeNumber = -1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotifcation];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (!isBecomebackBool) {

//        [self iconClearApplication:application];
        
        if (self.resignActiveBool&&isBecomebackBool == NO) {
            isback = YES;
        }
        self.resignActiveBool = NO;

        [self setUserInfoFromNotificationRemote:userInfo];
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
        [UMessage sendClickReportForRemoteNotification:userInfo];
    }
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get token, error: %@" , error);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    NSLog(@"phone:remoteNotification");
    completionHandler();
    if([identifier isEqualToString:@"com.apple.UNNotificationDismissActionIdentifier"]) {
    }
    else if([identifier isEqualToString:@"accept"]){
        isback = YES;
        [self setUserInfoFromNotificationRemote:userInfo];
        
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
        [UMessage sendClickReportForRemoteNotification:userInfo];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];

}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    
}

//iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    //应用在前台收到通知
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    NSDictionary * userInfo = notification.request.content.userInfo;
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
    // completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        if (!isBecomebackBool) {
            [self setUserInfoFromNotificationRemote:userInfo];
            //应用处于前台时的远程推送接受
            //必须加这句代码
                [UMessage didReceiveRemoteNotification:userInfo];
                [UMessage sendClickReportForRemoteNotification:userInfo];
        }
        
     
    } else{
        //应用处于前台时的本地推送接受
        [self setUserInfoFromNotificationRemote:notification.request.content.userInfo];
    }
}

//iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    //点击通知进入应用
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    completionHandler();
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [self setUserInfoFromNotificationRemote:userInfo];
        //应用处于后台时的远程推送接受
        //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            [UMessage sendClickReportForRemoteNotification:userInfo];
    } else {
        //应用处于后台时的本地推送接受
        [self setUserInfoFromNotificationRemote:response.notification.request.content.userInfo];
    }
}

#pragma mark - Privates
- (void)resigisterPush {

    [self grantNotificationAuthorization];

}


- (void)grantNotificationAuthorization {
    
    if (IsIOS10) {
        //watch:
        UNNotificationAction *doneAction = [UNNotificationAction actionWithIdentifier:@"accept" title:@"查看" options:UNNotificationActionOptionForeground];
        UNNotificationCategory *doneCategory = [UNNotificationCategory categoryWithIdentifier:@"apsns" actions:@[doneAction] intentIdentifiers:@[@"accept"] options:UNNotificationCategoryOptionCustomDismissAction];
        
        //watch done
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        center.delegate = self;
        [center setNotificationCategories:[NSSet setWithObject:doneCategory]];//watch
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                
//                UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
//                
//                UIUserNotificationType  types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
//                
//                [UMessage registerForRemoteNotifications:[NSSet setWithObject:doneCategory] withTypesForIos7:types7 withTypesForIos8:types8];

                // 点击允许
                NSLog(@"注册通知成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
//                UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
//                
//                UIUserNotificationType  types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
//                
//                [UMessage registerForRemoteNotifications:[NSSet setWithObject:doneCategory] withTypesForIos7:types7 withTypesForIos8:types8];
                // 点击不允许
                NSLog(@"注册通知失败");
            }
        }];
        
        NSUserDefaults *defaults = kStandardUserDefaults;
        if (!(isSafeString([defaults valueForKey:@"token"]))) {
            UIUserNotificationSettings*settings = [UIUserNotificationSettings
                                                   
                                                   settingsForTypes:(UIUserNotificationTypeBadge|
                                                                     
                                                                     UIUserNotificationTypeSound|
                                                                     
                                                                     UIUserNotificationTypeAlert)
                                                   
                                                   categories:[NSSet setWithObject:doneCategory]];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
        else{
            UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;

            UIUserNotificationType  types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;

            [UMessage registerForRemoteNotifications:[NSSet setWithObject:doneCategory] withTypesForIos7:types7 withTypesForIos8:types8];
        }
//        [UMessage registerForRemoteNotifications];
    }
    else if (IsIOS8) {
        UIMutableUserNotificationAction *doneAction = [[UIMutableUserNotificationAction alloc] init];
        doneAction.title = @"查看";
        doneAction.identifier = @"accept";
        doneAction.activationMode = UIUserNotificationActivationModeForeground;
        doneAction.authenticationRequired = NO; // 在Action相应之前时候需要解锁设备
        
        UIMutableUserNotificationCategory *doneCategory = [[UIMutableUserNotificationCategory alloc] init];
        [doneCategory setActions:@[doneAction] forContext:UIUserNotificationActionContextDefault];
        doneCategory.identifier = @"apsns";
        
        NSMutableSet* categories = [NSMutableSet set];
        [categories addObject:doneCategory];
        
        UIUserNotificationSettings*settings = [UIUserNotificationSettings
                                               
                                               settingsForTypes:(UIUserNotificationTypeBadge|
                                                                 
                                                                 UIUserNotificationTypeSound|
                                                                 
                                                                 UIUserNotificationTypeAlert)
                                               
                                               categories:categories];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
      
        
        UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        
        UIUserNotificationType  types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
        
        [UMessage registerForRemoteNotifications:categories withTypesForIos7:types7 withTypesForIos8:types8];

    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
        
        [UMessage registerForRemoteNotifications];
    }
}

/**
 *  推送进入
 */
- (void)launchFromNotification:(NSDictionary *)launchOptions {
    NSMutableDictionary *temp = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
 
    
    if ([temp valueForKey:@"msg_id"]) {
        NSLog(@"%@",temp);
            [UMessage setAutoAlert:NO];
            [UMessage sendClickReportForRemoteNotification:temp];
        self.post_Dic = [[NSDictionary alloc] initWithDictionary:temp];
        NSMutableDictionary *pushDic = [[NSMutableDictionary alloc]initWithDictionary:self.post_Dic];
        [pushDic setValue:@"推送唤醒" forKey:@"yddOpenType"];
        [self pushInfo:pushDic];
    }

}
#pragma mark - 秒杀推送
- (void)setupSpikeNotification:(UILocalNotification *)notification on:(UIApplication *)application {
  
}

- (void)monitorLocalNotificaiton:(NSDictionary *)dict {
    if (![dict[@"key"] isEqualToString:@"miaosha"]) return;
    
    [[AppDelegate getAppDelegate].nav xPushViewController:[[NSClassFromString(@"SMSpikeRemindVC") alloc] init] animated:YES];
}

#pragma mark - app内推送弹窗
- (void)setUserInfoFromNotificationRemote:(NSDictionary *)userInfo {
    

    
//    self.post_Dic = [NSDictionary dictionaryWithDictionary:userInfo];
//    NSLog(@"%@",userInfo);
//    
//    if (!isback) {
//
//        if(kNavigationController.topViewController == self.rootViewVC
//           && self.rootViewVC.seletedN == 1
//           && self.rootViewVC.homePageViewController.sm_currentItemIndex == 1) {
//            return;
//        }
//        
//        [lock lock];
//        WS(weakSelf)
//        
//        NSString *pushSource = [PushRelateObject pushSourceStr:self.post_Dic[@"push_source"]];
//        [GTMObject pushEventName:@"trackEvent" andCategory:@"关注" andAction:@"APP内推送展现数" andEventLabel:pushSource];
//        
//        [SMAppInnerPushFloat show:self.post_Dic clicked:^(SMAppInnerPushFloat *pushFloat) {
//            NSLog(@"SMAppInnerPushFloat clicked");
//            
//            [GTMObject pushEventName:@"trackEvent" andCategory:@"关注" andAction:@"APP内推送点击数" andEventLabel:pushSource];
//            
//            [SMZDMShareInstance shareInstance].GTMPiCiID = [weakSelf.post_Dic valueForKey:@"batch_id"];
//            
//            NSMutableDictionary *pushDic = [[NSMutableDictionary alloc]initWithDictionary:weakSelf.post_Dic];
//            [pushDic setValue:@"推送唤醒" forKey:@"yddOpenType"];
//            
//            [weakSelf pushInfo:pushDic];
//        } disappeared:^(SMAppInnerPushFloat *pushFloat) {
//            NSLog(@"SMAppInnerPushFloat disappeared");
//        }];
//        
//        [lock unlock];
//    } else {
//        isback = NO;
//        if ([userInfo valueForKey:@"batch_id"]) {
//            if ([[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"batch_id"]] isLegalString] ) {
//                [SMZDMShareInstance shareInstance].GTMPiCiID = [NSString stringWithFormat:@"%@",[userInfo valueForKey:@"batch_id"]];
//            }
//        }
//        NSMutableDictionary *pushDic = [[NSMutableDictionary alloc]initWithDictionary:self.post_Dic];
//        [pushDic setValue:@"推送唤醒" forKey:@"yddOpenType"];
//        [self pushInfo:pushDic];
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (IsIOS8) {
        [kStandardUserDefaults setBool:NO forKey:@"AlertIsIOSShow"];
    }
    
    if (alertView.tag == 'push' && buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
    
    if (alertView.tag == 111) {
        
        if (buttonIndex == 1) {
   
            NSMutableDictionary *pushDic = [[NSMutableDictionary alloc]initWithDictionary:self.post_Dic];
            [pushDic setValue:@"推送唤醒" forKey:@"yddOpenType"];
            
            [self pushInfo:pushDic];
        }
    }
    
    if(alertView.tag==100) {
        //更新的
        if (buttonIndex==1) {
            
            NSLog(@"%@",[kStandardUserDefaults valueForKey:@"appUrl"]);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[kStandardUserDefaults valueForKey:@"appUrl"]]];
        }
    }
    
    if ([[alertView sm_getAssociatedValueForKey:@"spikeRemind"] isEqualToString:@"秒杀提醒"]) {
        if (buttonIndex == 1) {
            
            [[AppDelegate getAppDelegate].nav xPushViewController:[[NSClassFromString(@"SMSpikeRemindVC") alloc] init] animated:YES];
        }
    }
}
#pragma mark - 推送跳转
- (void)pushInfo:(NSDictionary *)postDic {
    
}

- (void)get_push_configCallBack:(id)responder {
    if([CommUtls correctData:responder]) {
        
        NSDate *senddate = [NSDate date];
        NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        NSString *locationString = [dateformatter stringFromDate:senddate];
        
        [kStandardUserDefaults setObject:locationString forKey:@"updatePushDate"];
    }
}

- (void)get_push_configLogCallBack:(id)responder {
    if([CommUtls correctData:responder]){
    }
}

- (void)checkShowPushAlertOrNot {
    
}

@end
