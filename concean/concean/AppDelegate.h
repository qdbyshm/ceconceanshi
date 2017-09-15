//
//  AppDelegate.h
//  SMZDM
//
//  Created by SMZDM on 12-11-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSMHeader.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSLock *lock;
    UIAlertView *alert;//========收到推送显示Alert
    
    Reachability *wifiReach;
    
    BOOL isback;
    
    BOOL isBecomebackBool;
    
@public
    BOOL wifiNet;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) MINavigationController *nav;
@property (nonatomic, retain) RootViewController *rootViewVC;
@property (nonatomic, retain) DataController *dataController;
@property (nonatomic, strong) HelpViewController  * helpVC;
@property (nonatomic, strong) UIAlertView * spikeAlertView;
@property(nonatomic, assign) BOOL isUmengPushOpen;
@property (nonatomic, retain) NSDictionary *post_Dic;//推送进来的内容dic
@property (nonatomic, strong) UIAlertShow *alertShow;//打分alert

@property (nonatomic, assign)BOOL isFull;
@property (nonatomic, assign)BOOL resignActiveBool;
@property (nonatomic, assign)BOOL umengchangeBool;

+ (AppDelegate *)getAppDelegate;


@end
