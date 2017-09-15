//
//  HUDShare.m
//  HudDemo
//
//  Created by ncg ncg-2 on 12-5-24.
//  Copyright (c) 2012年 zhouyh@ifudi.com. All rights reserved.

#import "HUDShare.h"
#define mainWindow  [UIApplication sharedApplication].keyWindow
#define HUD_DELAY 1.5f
@interface HUDShare(private)
-(void)showComplete:(NSString*)text imageName:(NSString*)imgname;
@end
@implementation HUDShare{
    
}
@synthesize HUD;
static HUDShare *hudShare;
+(HUDShare*) shareInstance {
    if (!hudShare) {
        @synchronized(self){
            hudShare = [HUDShare new];
        }
    }    
    return hudShare;
}

- (void)showText:(NSString*)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainWindow animated:NO];
	// Configure for text only and offset down
    hud.minShowTime=.7f;
	hud.mode = MBProgressHUDModeText;
	hud.labelText = text;
	hud.margin = 10.f;
    if (![CommUtls TTIsKeyboardVisible]) {
        hud.yOffset = 150.f;
    } else {
        hud.yOffset = -100.f;
    }
	hud.removeFromSuperViewOnHide = YES;
	hud.userInteractionEnabled = NO;
	[hud hide:NO afterDelay:HUD_DELAY];
}

- (void)showText:(NSString*)text positionY:(CGFloat)y{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainWindow animated:NO];
    // Configure for text only and offset down
    hud.minShowTime=.7f;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    if (![CommUtls TTIsKeyboardVisible]) {
        hud.yOffset = y;
    } else {
        hud.yOffset = -100.f;
    }
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud hide:NO afterDelay:HUD_DELAY];
}

- (void)showTextAndHide:(NSString*)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainWindow animated:NO];
    // Configure for text only and offset down
    hud.minShowTime=.7f;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
//    hud.yOffset = -100.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud hide:NO afterDelay:HUD_DELAY];
}

- (void)showText:(NSString *)text AndDetail:(NSString *)detailText
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainWindow animated:YES];
	// Configure for text only and offset down
    hud.minShowTime=2.0f;
	hud.mode = MBProgressHUDModeText;
	hud.labelText = text;
    hud.detailsLabelText = detailText;
    hud.detailsLabelFont = hud.labelFont;
	hud.margin = 10.f;
    
	hud.removeFromSuperViewOnHide = YES;
	hud.userInteractionEnabled = NO;
	[hud hide:YES afterDelay:HUD_DELAY];
}

-(void)showWait:(NSString*)text{
    if (HUD) {
        [HUD removeFromSuperview];
        HUD.delegate = nil;
        self.HUD = nil;
        //        HUD.removeFromSuperViewOnHide = YES;
    } 
    self.HUD = [MBProgressHUD showHUDAddedTo:mainWindow animated:NO];
    self.HUD.minShowTime=.5f;
    HUD.delegate = self;
    
    HUD.labelText = text;
//    [HUD show:YES];
    [[HUD superview] bringSubviewToFront:HUD];
}

-(void)showWaitToLastWindow:(NSString*)text{
    if (HUD) {
        [HUD removeFromSuperview];
        HUD.delegate = nil;
        self.HUD = nil;
        //        HUD.removeFromSuperViewOnHide = YES;
    }
    self.HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:NO];
    self.HUD.minShowTime=.5f;
    HUD.delegate = self;
    
    HUD.labelText = text;
    //    [HUD show:YES];
    [[HUD superview] bringSubviewToFront:HUD];
}

-(void)showDetailWait:(NSString*)text andSuperV:(UIView *)view
{
    if (HUD) {
        [HUD removeFromSuperview];
        HUD.delegate = nil;
        self.HUD = nil;
        //        HUD.removeFromSuperViewOnHide = YES;
    }
    self.HUD = [MBProgressHUD showHUDAddedTo:view animated:NO];
    self.HUD.minShowTime=.7f;

    HUD.delegate = self;
    
    HUD.labelText = text;
    //    [HUD show:YES];
    [[HUD superview] bringSubviewToFront:HUD];
}


-(void)hideWait{
    if (HUD) {
        [HUD hide:YES];
    }
}

-(void)showComplete:(NSString*)text{
    [self showComplete:text imageName:@"37x-Checkmark.png"];
}

-(void)showFail:(NSString*)text{
    [self showComplete:text imageName:@"37x-Error.png"];
}

-(void)showComplete:(NSString*)text imageName:(NSString*)imgname{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainWindow animated:YES];
    hud.minShowTime=1.7f;

	hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgname]];
	hud.labelText = text;
    //hud.square = YES;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:HUD_DELAY];
}

- (void)showWhileExecuted:(NSString*)text sel:(SEL)selecoter target:(id)t withObject:(id)w {
	HUD = [[MBProgressHUD alloc] initWithView:mainWindow];
    self.HUD.minShowTime=.7f;

	[mainWindow addSubview:HUD];
	HUD.delegate = self;
	HUD.labelText = text;
	HUD.square = YES;
	[HUD showWhileExecuting:selecoter onTarget:t withObject:w animated:YES];
}

#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
    NSLog(@"hidden");
}

#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone 
{
    @synchronized(self) 
    {
        if (!hudShare) 
        {
            hudShare = [super allocWithZone:zone];
        }
    }
    return hudShare;
}

+ (id)copyWithZone:(NSZone *)zone 
{
    return self;
}



@end
