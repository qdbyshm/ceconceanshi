//
//  UserInfoModel.m
//  SMZDM
//
//  Created by 法良涛 on 16/1/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "SMZDMUserModel.h"

@implementation SMZDMUserModel

+ (SMZDMUserModel*)currentUser
{
    static SMZDMUserModel *defaultUser = nil;
    @synchronized(self) {
        if (!defaultUser) {
            defaultUser = [[self alloc] init];
            [defaultUser updateUserInfo];
        }
    }
    
    return defaultUser;
}

+ (BOOL)isLogin;
{
    if ([[[AppDelegate getAppDelegate].dataController.userInfo valueForKey:@"token"] isSafeString]) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)updateUserInfo
{
    if ([[[AppDelegate getAppDelegate].dataController.userInfo valueForKey:@"token"] isSafeString]) {

        [SMZDMUserModel currentUser].user_smzdm_id = [CommUtls checkNullValueForString:[[AppDelegate getAppDelegate].dataController.userInfo objectForKey:@"uid"]];
        [SMZDMUserModel currentUser].user_token = [CommUtls checkNullValueForString:[[AppDelegate getAppDelegate].dataController.userInfo objectForKey:@"token"]];
        [SMZDMUserModel currentUser].user_login = [CommUtls checkNullValueForString:[[AppDelegate getAppDelegate].dataController.userInfo objectForKey:@"username"]];

   
        
    }
}

+ (void)refreshCurrentUser
{
    if ([[[AppDelegate getAppDelegate].dataController.userInfo valueForKey:@"token"] isSafeString]) {

        [SMZDMUserModel currentUser].user_smzdm_id = [CommUtls checkNullValueForString:[[AppDelegate getAppDelegate].dataController.userInfo objectForKey:@"uid"]];
        [SMZDMUserModel currentUser].user_token = [CommUtls checkNullValueForString:[[AppDelegate getAppDelegate].dataController.userInfo objectForKey:@"token"]];
        [SMZDMUserModel currentUser].user_login = [CommUtls checkNullValueForString:[[AppDelegate getAppDelegate].dataController.userInfo objectForKey:@"username"]];
    }
}

+ (void)insertUserInfo:(NSDictionary *)dict
{
    [SMZDMUserModel currentUser].user_email = [CommUtls checkNullValueForString:[dict objectForKey:@"user_email"]];
    [SMZDMUserModel currentUser].display_name = [CommUtls checkNullValueForString:[dict objectForKey:@"display_name"]];
    //
    [SMZDMUserModel currentUser].cpoints = [CommUtls checkNullValueForString:[[dict objectForKey:@"meta"] objectForKey:@"cpoints"]];
    [SMZDMUserModel currentUser].cexperience = [CommUtls checkNullValueForString:[[dict objectForKey:@"meta"] objectForKey:@"cexperience"]];
    [SMZDMUserModel currentUser].cgold = [CommUtls checkNullValueForString:[[dict objectForKey:@"meta"] objectForKey:@"cgold"]];
    [SMZDMUserModel currentUser].cprestige = [CommUtls checkNullValueForString:[[dict objectForKey:@"meta"] objectForKey:@"cprestige"]];
    [SMZDMUserModel currentUser].rank = [CommUtls checkNullValueForString:[[dict objectForKey:@"meta"] objectForKey:@"rank"]];
    [SMZDMUserModel currentUser].user_description = [CommUtls checkNullValueForString:[[dict objectForKey:@"meta"] objectForKey:@"description"]];
    [SMZDMUserModel currentUser].avatar = [CommUtls checkNullValueForString:[[dict objectForKey:@"meta"] objectForKey:@"avatar"]];
    //
    [SMZDMUserModel currentUser].has_checkin = [CommUtls checkNullValueForString:[[dict objectForKey:@"checkin"] objectForKey:@"has_checkin"]];
    [SMZDMUserModel currentUser].daily_attendance_number = [CommUtls checkNullValueForString:[[dict objectForKey:@"checkin"] objectForKey:@"daily_attendance_number"]];
    [SMZDMUserModel currentUser].client_has_checkin = [CommUtls checkNullValueForString:[[dict objectForKey:@"checkin"] objectForKey:@"client_has_checkin"]];
    [SMZDMUserModel currentUser].weixin_has_checkin = [CommUtls checkNullValueForString:[[dict objectForKey:@"checkin"] objectForKey:@"weixin_has_checkin"]];
    //
    [SMZDMUserModel currentUser].avatar_ornament = [CommUtls checkNullValueForString:[dict objectForKey:@"avatar_ornament"]];
    [SMZDMUserModel currentUser].avatar_ornament_yejian = [CommUtls checkNullValueForString:[dict objectForKey:@"avatar_ornament_yejian"]];
    //
    [SMZDMUserModel currentUser].banner = [CommUtls checkNullValueForString:[dict objectForKey:@"banner"]];
    [SMZDMUserModel currentUser].ban_comment = [CommUtls checkNullValueForString:[dict objectForKey:@"ban_comment"]];
    [SMZDMUserModel currentUser].ban_baoliao = [CommUtls checkNullValueForString:[dict objectForKey:@"ban_baoliao"]];
    
    //used for reward
    [SMZDMUserModel currentUser].remainingSilver = [CommUtls checkNullValueForString:[dict objectForKey:@"silver"]];
    [SMZDMUserModel currentUser].dayHasRewardGold = [CommUtls checkNullValueForString:[dict objectForKey:@"day_has_shang_gold"]];
    [SMZDMUserModel currentUser].dayRewardGoldLimit = [CommUtls checkNullValueForString:[dict objectForKey:@"day_shang_gold_limit"]];
    [SMZDMUserModel currentUser].singleRewardGoldLimit = [CommUtls checkNullValueForString:[dict objectForKey:@"every_shang_gold_limit"]];
    [SMZDMUserModel currentUser].is_set_safepass = [CommUtls checkNullValueForString:[dict objectForKey:@"is_set_safepass"]];

    
    //count
    [SMZDMUserModel currentUser].baoliao_count = [CommUtls checkNullValueForString:[dict objectForKey:@"baoliao_count"]];
    [SMZDMUserModel currentUser].yuanchuang_count = [CommUtls checkNullValueForString:[dict objectForKey:@"yuanchuang_count"]];
    [SMZDMUserModel currentUser].zhongce_count = [CommUtls checkNullValueForString:[dict objectForKey:@"zhongce_count"]];
    [SMZDMUserModel currentUser].second_count = [CommUtls checkNullValueForString:[dict objectForKey:@"second_count"]];
    [SMZDMUserModel currentUser].wiki_count = [CommUtls checkNullValueForString:[dict objectForKey:@"wiki_count"]];
    [SMZDMUserModel currentUser].favorite_count = [CommUtls checkNullValueForString:[dict objectForKey:@"favorite_count"]];
    [SMZDMUserModel currentUser].fans_num = [CommUtls checkNullValueForString:[dict objectForKey:@"fans_num"]];
    [SMZDMUserModel currentUser].follower_num = [CommUtls checkNullValueForString:[dict objectForKey:@"follower_num"]];
    [SMZDMUserModel currentUser].isOpenOneKeyOut = [CommUtls checkNullValueForString:[dict objectForKey:@"isOpenOneKeyOut"]];
    [SMZDMUserModel currentUser].is_show_my_medal = [CommUtls checkNullValueForString:[dict objectForKey:@"is_show_my_medal"]];
    [SMZDMUserModel currentUser].is_bind_visa = [CommUtls checkNullValueForString:[dict objectForKey:@"is_bind_visa"]];
    [SMZDMUserModel currentUser].video_is_show = [CommUtls checkNullValueForString:[dict objectForKey:@"video_is_show"]];
    [SMZDMUserModel currentUser].baoliao_comment_msg = [CommUtls checkNullValueForString:[dict objectForKey:@"baoliao_comment_msg"]];

    //
    [SMZDMUserModel currentUser].en_key = [CommUtls checkNullValueForString:[dict objectForKey:@"en_key"]];
    [SMZDMUserModel currentUser].server_time = [CommUtls checkNullValueForString:[dict objectForKey:@"server_time"]];
    
}

//登出后，删除当前用户信息
+ (void)ExitUserInfo:(NSDictionary *)dict
{
    [SMZDMUserModel currentUser].user_smzdm_id = nil;
    [SMZDMUserModel currentUser].user_token = nil;
    [SMZDMUserModel currentUser].user_login = nil;
    
    [SMZDMUserModel currentUser].user_email = nil;
    [SMZDMUserModel currentUser].display_name = nil;
    //
    [SMZDMUserModel currentUser].cpoints = nil;
    [SMZDMUserModel currentUser].cexperience = nil;
    [SMZDMUserModel currentUser].cgold = nil;
    [SMZDMUserModel currentUser].cprestige = nil;
    [SMZDMUserModel currentUser].rank = nil;
    [SMZDMUserModel currentUser].user_description = nil;
    [SMZDMUserModel currentUser].avatar = nil;
    //
    [SMZDMUserModel currentUser].has_checkin = nil;
    [SMZDMUserModel currentUser].daily_attendance_number = nil;
    [SMZDMUserModel currentUser].client_has_checkin = nil;
    [SMZDMUserModel currentUser].weixin_has_checkin = nil;
    //
    [SMZDMUserModel currentUser].avatar_ornament = nil;
    [SMZDMUserModel currentUser].avatar_ornament_yejian = nil;
    //
    [SMZDMUserModel currentUser].banner = nil;
    [SMZDMUserModel currentUser].ban_comment = nil;
    [SMZDMUserModel currentUser].ban_baoliao = nil;
    
    
    [SMZDMUserModel currentUser].remainingSilver = nil;
    [SMZDMUserModel currentUser].dayHasRewardGold = nil;
    [SMZDMUserModel currentUser].dayRewardGoldLimit = nil;
    [SMZDMUserModel currentUser].singleRewardGoldLimit = nil;

    [SMZDMUserModel currentUser].is_set_safepass = nil;
    //count
    [SMZDMUserModel currentUser].baoliao_count = nil;
    [SMZDMUserModel currentUser].yuanchuang_count = nil;
    [SMZDMUserModel currentUser].zhongce_count = nil;
    [SMZDMUserModel currentUser].second_count = nil;
    [SMZDMUserModel currentUser].wiki_count = nil;
    [SMZDMUserModel currentUser].favorite_count = nil;
    [SMZDMUserModel currentUser].fans_num = nil;
    [SMZDMUserModel currentUser].follower_num = nil;
    [SMZDMUserModel currentUser].isOpenOneKeyOut = nil;
    [SMZDMUserModel currentUser].is_show_my_medal = nil;
    [SMZDMUserModel currentUser].is_bind_visa = nil;
    [SMZDMUserModel currentUser].video_is_show = nil;
    [SMZDMUserModel currentUser].baoliao_comment_msg = nil;

//
    [SMZDMUserModel currentUser].en_key = nil;
    [SMZDMUserModel currentUser].server_time = nil;

}

+ (void)gotoTAHomepage:(NSDictionary*)dict
{
    if ([[dict objectForKey:@"is_anonymous"] integerValue]!=0) {
        return;
    }
    if (![dict valueForKey:@"user_smzdm_id"]) {
        return;
    }
    if ([[dict valueForKey:@"user_smzdm_id"]isEqualToString:@"0"]) {
        return;
    }
    if (![CommUtls checkConnectNet]) {
        [[HUDShare shareInstance] showFail:KNONETWORKMSG];
        return;
    }

}

@end
