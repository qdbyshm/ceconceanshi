//
//  PushRelateObject.m
//  SMZDM
//
//  Created by sunhaoming on 2017/6/18.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "PushRelateObject.h"
#import "PSTAlertController.h"

@implementation PushRelateObject

+ (void)checkAllPushStatus:(void (^ __nullable)(BOOL isAvailable))handler {
    
    if ([CommUtls checkConnectNet]) {
        [PushRelateObject checkUserFollowPushStatus:^(BOOL isAvailable) {
            if(!isAvailable) {
                if(handler) {
                    handler(NO);
                }
                [PushRelateObject showUserFollowPushAlert];
            } else {
                [PushRelateObject checkSystemPushStatus:handler];
            }
        }];
    } else {
        [PushRelateObject checkSystemPushStatus:handler];
    }
    
}

+ (void)checkUserFollowPushStatus:(void (^ __nullable)(BOOL isAvailable))handler {
    NSString *deviceTokenString = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    
    if (!isSafeString(deviceTokenString)) {
        if(handler) {
            handler(YES);
        }
        return;
    }
}

+ (BOOL)systemPushIsAvailable {
    NSUInteger notificationType; //UIUserNotificationType(>= iOS8) and UIRemoteNotificatioNType(< iOS8) use same value
    UIApplication *application = [UIApplication sharedApplication];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        notificationType = [[application currentUserNotificationSettings] types];
    } else {
        notificationType = [application enabledRemoteNotificationTypes];
    }
    
    if (notificationType == UIRemoteNotificationTypeNone) {
        return NO;
    }
    
    return YES;
}

+ (void)checkSystemPushStatus:(void (^ __nullable)(BOOL isAvailable))handler {
    if (![PushRelateObject systemPushIsAvailable]) { //判断用户是否打开通知开关
        if(handler) {
            handler(NO);
        }
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [PushRelateObject showSystemPushAlert];
        }
    } else {
        if(handler) {
            handler(YES);
        }
    }
}

+ (void)showUserFollowPushAlert {
    PSTAlertController *alert = [PSTAlertController alertWithTitle:@"检查到您关闭了个人设置里的关注推送总开关，请先打开" message:@""];
    [alert addAction:[PSTAlertAction actionWithTitle:@"去打开" style:PSTAlertActionStyleDefault handler:^(PSTAlertAction * _Nonnull action) {
  
    }]];
    [alert addAction:[PSTAlertAction actionWithTitle:@"取消" style:PSTAlertActionStyleCancel handler:nil]];
    [alert showWithSender:nil controller:kRootViewVC animated:YES completion:nil];
}

+ (void)showSystemPushAlert {
    PSTAlertController *alert = [PSTAlertController alertWithTitle:@"检查到您关闭了“什么值得买App”的系统推送通知权限，只有开启推送，才能收到即时的内容通知" message:@""];
    [alert addAction:[PSTAlertAction actionWithTitle:@"前往开启" style:PSTAlertActionStyleDefault handler:^(PSTAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }]];
    [alert addAction:[PSTAlertAction actionWithTitle:@"取消" style:PSTAlertActionStyleCancel handler:nil]];
    [alert showWithSender:nil controller:kRootViewVC animated:YES completion:nil];
}


+ (nonnull NSString *)pushSourceStr:(nonnull NSString *)sourceStr {
    if(isSafeString(sourceStr)){
        if ([sourceStr isEqualToString:@"sub"]) {
            return @"关注文章推送";
        }
        else if ([sourceStr isEqualToString:@"sale-w"]) {
            return @"商品降价推送";
        }
        else if ([sourceStr isEqualToString:@"sale-o"]) {
            return @"商品降价推送";
        }
        else if ([sourceStr isEqualToString:@"visa"]) {
            return @"其他";//VISA相关推送
        }
        else if ([sourceStr isEqualToString:@"opt"]) {
            return @"其他";//精细化运营推送
        }
        else if ([sourceStr isEqualToString:@"mrjx"]) {
            return @"每日精选推送";
        }
        else if ([sourceStr isEqualToString:@"qzts"]) {
            return @"其他";//强制推送
        }
    }
    return @"其他";
}

@end
