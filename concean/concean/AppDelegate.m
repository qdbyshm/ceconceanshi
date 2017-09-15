//
//  AppDelegate.m
//  SMZDM
//
//  Created by SMZDM on 12-11-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AppSMHeader.h"
#import "AppDelegate+SDK.h"
#import "AppDelegate+Notification.h"
#import "AppDelegate+UMeng.h"
@interface AppDelegate ()<HelpVCDeletage>{
}
@end

@implementation AppDelegate

@synthesize window = _window;

//==============================================================================
#pragma mark - UIApplication -
//==============================================================================
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //全局数据储存，用户x
    [self setupDataController];
    //网络监测
    [self setupNetworkNotification];
    
    //微信sdk
    [self setupWXApi];
    //打分
    [self setupScore];
    
    //Umeng push
    [self setupUmengPush:launchOptions];


    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    [self setupViewControllers];

    self.window.rootViewController = _nav;
    [self.window makeKeyAndVisible];
    
    [self resigisterPush];
    
    //推送进入
    if (dictionaryHasData(launchOptions)) {
        [self launchFromNotification:launchOptions];
    }
    
    return YES;
}
#pragma mark - 初始化数据类信息 -

/**
 *  初始化数据类信息
 */
- (void)setupDataController
{
    //数据逻辑中间层
    _dataController = [[DataController alloc]init];
    //判断用户登录
    [_dataController userInfoData];

}
#pragma mark - vc -

- (void)setupViewControllers
{
    if (![[AppDelegate getAppDelegate].dataController fistGuide]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"help81" forKey:@"OldUserVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _rootViewVC =[[RootViewController alloc] init];
        _nav = [[MINavigationController alloc] initWithRootViewController:_rootViewVC];
        
    } else {
        
        _helpVC = [[HelpViewController alloc] init];
        _helpVC.deletage = self;
        _nav = [[MINavigationController alloc] initWithRootViewController:_helpVC];
    }
    [_nav setNavigationBarHidden:YES];
}

#pragma mark - 网络监测 -
//==============================================================================
- (void)setupNetworkNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object: nil];
    
    wifiReach = [Reachability reachabilityForLocalWiFi] ;
    [wifiReach startNotifier];
    [self updateInterfaceWithReachability:wifiReach];
}
//Called by Reachability whenever status changes.
- (void)reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

-(void)updateInterfaceWithReachability:(Reachability *)curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus==ReachableViaWiFi) {
        wifiNet=YES;
    } else {
        wifiNet=NO;
    }
}

#pragma mark - 打分-
- (void)setupScore
{
    _alertShow = [[UIAlertShow alloc] init];
    _alertShow.s_appleID = [CommUtls appleId];
    self.alertShow.btnClicked = ^ (MakeScoreOptionsType optionType, NSUInteger index) {
        if (optionType == MakeScoreOptionsTypeDefault) {
        } else {
            if (optionType == MakeScoreOptionsTypeNoLongerPrompt) {
                
            }
        }
    };
}

//==============================================================================
#pragma mark - 移除帮助图 -
//==============================================================================
- (void)roadOver
{
    if (!_rootViewVC) {
        _rootViewVC =[[RootViewController alloc] init];
        
    }
    _nav.viewControllers = @[_rootViewVC];
    [_nav setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
@end
