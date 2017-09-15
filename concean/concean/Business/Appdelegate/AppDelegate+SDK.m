//
//  AppDelegate+SDK.m
//  concean
//
//  Created by sunhaoming on 2017/9/14.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "AppDelegate+SDK.h"
#import <TencentOpenAPI/TencentOAuth.h>  //qq
#import "WXApi.h"                        //weixin
#import "WeiboSDK.h"                     //sina weibo
@implementation AppDelegate (SDK)
#pragma mark - 微信微博sdk

- (void)setupWXApi
{
    [WXApi registerApp:WEIXIN_AppID];
    
    
    //sina
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    
}
@end
