//
//  HUDShare.h
//  HudDemo
//
//  Created by ncg ncg-2 on 12-5-24.
//  Copyright (c) 2012年 zhouyh@ifudi.com. All rights reserved.

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "UIWindowAdditions.h"
#define KEYWINDOW [[UIApplication sharedApplication] delegate].window

@interface HUDShare : NSObject<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}
@property(nonatomic,retain)    MBProgressHUD *HUD;

+(HUDShare*) shareInstance;
//显示完成消息
-(void)showComplete:(NSString*)str;
//显示失败消息
-(void)showFail:(NSString*)text;
//显示等待消息
-(void)showWait:(NSString*)text;
//挡不住键盘的时候用这个
-(void)showWaitToLastWindow:(NSString*)text;
//显示其它等待消息
-(void)showDetailWait:(NSString*)text andSuperV:(UIView *)view;
//隐藏等待
-(void)hideWait;
//显示文本消息
- (void)showText:(NSString*)text;
- (void)showText:(NSString*)text positionY:(CGFloat)y;
//feng  view  show
- (void)showTextAndHide:(NSString*)text;
//异步执行方法完成后自动隐藏消息
- (void)showWhileExecuted:(NSString*)text sel:(SEL)selecoter target:(id)t withObject:(id)w;
- (void)showText:(NSString *)text AndDetail:(NSString *)detailText;//扣除积分、金币
//
@end
