//
//  LocalData+User.m
//  SMZDM
//
//  Created by 冯展波 on 14-9-3.
//
//

#import "LocalData+User.h"
#import "FMDatabaseAdditions.h"
#import "HelperTools.h"

@implementation LocalData (User)

- (void)insertUserInfo:(NSDictionary *)dic UserDic:(NSDictionary *)uDic
{
}
- (BOOL)isExistUser:(NSString *)uid andName:(NSString *)name
{
    if([self.fmDatabase open])
    {
        FMResultSet *rs = [self.fmDatabase executeQuery:@"SELECT * FROM USER WHERE id = ? AND  UserName = ?",uid,name];
        if ( rs != nil )
        {
            if([rs next])
            {
                [rs close];
                return  YES;
            }
        }
    }
    return  NO;
}
- (BOOL)isExistUser:(NSString *)uid
{
    if([self.fmDatabase open])
    {
        FMResultSet *rs = [self.fmDatabase executeQuery:@"SELECT * FROM USER WHERE id = ? ",uid];
        if ( rs != nil )
        {
            if([rs next])
            {
                [rs close];
                return  YES;
            }
        }
    }
    return  NO;
}

- (void)deletePassword:(NSDictionary *)dic
{
    NSString *uid = [dic valueForKey:@"uid"];
    NSString *userName = [dic valueForKey:@"username"];

    if ([userName length]>0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userName forKey:LAST_USER];
        [defaults synchronize];
    }

  
    if([self.fmDatabase open])
    {
        [self.fmDatabase executeUpdate:@"DELETE FROM USER WHERE id = ? AND UserName = ?",uid,userName];
    }

}
- (void)deletePassword2:(NSString *)username
{
    
    if ([username length]>0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:username forKey:LAST_USER];
        [defaults synchronize];
    }
    
    
    if([self.fmDatabase open])
    {
        [self.fmDatabase executeUpdate:@"DELETE FROM USER WHERE UserName = ?",username];
    }
    
}
/**
 *  上次登录信息
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)lastUserData
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:LAST_USER]) {
        NSString * name = [[NSUserDefaults standardUserDefaults] valueForKey:LAST_USER];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:10];
        [dic setValue:name forKey:@"username"];
        if([self.fmDatabase open])
        {
            FMResultSet *rs = [self.fmDatabase executeQuery:@"SELECT * FROM USER  WHERE UserName = ? ",name];
            if ( rs != nil )
            {
                if([rs next])
                {
                    NSString *UserName = [rs stringForColumn:@"UserName"];
                    NSString *passwd = [rs stringForColumn:@"UserPsw"];
                    NSString *token = [rs stringForColumn:@"token"];
                    NSString *uid = [rs stringForColumn:@"id"];

                    [dic setValue:UserName forKey:@"username"];
                    if(passwd != nil)
                    {
                        NSString *AES_passwd = [CommUtls AES256Decrypt:passwd andKey:PWDAES];
                        [dic setValue:AES_passwd forKey:@"password"];
                    }
                    [dic setValue:token forKey:@"token"];
                    [dic setValue:uid forKey:@"uid"];
                    [rs close];
                    return dic;
                }
                
            }
        }
        return dic;

    }
    return nil;
}
/**
 *  个人信息
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableDictionary *)getUserData:(NSString *)name
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
   

    if([self.fmDatabase open])
    {
        FMResultSet *rs = [self.fmDatabase executeQuery:@"SELECT * FROM USER  WHERE id = ? ",name];
        if ( rs != nil )
        {
            while([rs next])
            {
                
                NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]init];
                NSMutableDictionary * dic2 = [[NSMutableDictionary alloc]init];
                
                NSString * daily_num = [rs stringForColumn:@"daily_num"];
                NSString * checkin = [rs stringForColumn:@"checkin"];
                
                [dic1 setValue:daily_num forKey:@"daily_attendance_number"];
                [dic1 setValue:checkin forKey:@"client_has_checkin"];
                
                NSString * avatar = [rs stringForColumn:@"avatar"];
                NSString * cexperience = [rs stringForColumn:@"cexperience"];
                NSString * cgold = [rs stringForColumn:@"cgold"];
                NSString * cpoints = [rs stringForColumn:@"cpoints"];
                NSString * cprestige = [rs stringForColumn:@"cprestige"];
                NSString * rank = [rs stringForColumn:@"rank"];
                NSString * description = [rs stringForColumn:@"description"];
                NSString * bindmobile = [rs stringForColumn:@"bindmobile"];

                NSString * ban_baoliao = [rs stringForColumn:@"ban_baoliao"];
                NSString * ban_comment = [rs stringForColumn:@"ban_comment"];
                //    ban_baoliao varchar(10),ban_comment varchar(10)

                NSString *  silver = [rs stringForColumn:@"silver"];
                NSString *  day_has_shang_gold = [rs stringForColumn:@"day_has_shang_gold"];
                NSString *  day_shang_gold_limit = [rs stringForColumn:@"day_shang_gold_limit"];
                NSString *  every_shang_gold_limit = [rs stringForColumn:@"every_shang_gold_limit"];
                NSString *  is_set_safepass = [rs stringForColumn:@"is_set_safepass"];

                [dic setValue:silver forKey:@"silver"];
                [dic setValue:day_has_shang_gold forKey:@"day_has_shang_gold"];
                [dic setValue:day_shang_gold_limit forKey:@"day_shang_gold_limit"];
                [dic setValue:every_shang_gold_limit forKey:@"every_shang_gold_limit"];
                [dic setValue:is_set_safepass forKey:@"is_set_safepass"];

                
                [dic2 setValue:avatar forKey:@"avatar"];
                [dic2 setValue:cexperience forKey:@"cexperience"];
                [dic2 setValue:cgold forKey:@"cgold"];
                [dic2 setValue:cpoints forKey:@"cpoints"];
                [dic2 setValue:cprestige forKey:@"cprestige"];
                [dic2 setValue:rank forKey:@"rank"];
                [dic2 setValue:description forKey:@"description"];

                
                NSString * nickname = [rs stringForColumn:@"nickname"];
                NSString * user_email = [rs stringForColumn:@"email"];

                [dic setValue:dic1 forKey:@"checkin"];
                [dic setValue:dic2 forKey:@"meta"];
                [dic setValue:nickname forKey:@"display_name"];
                [dic setValue:bindmobile forKey:@"is_bind_mobile"];

                [dic setValue:user_email forKey:@"user_email"];
                [dic setValue:ban_baoliao forKey:@"ban_baoliao"];
                [dic setValue:ban_comment forKey:@"ban_comment"];

                NSString *  baoliao_count = [rs stringForColumn:@"baoliao_count"];
                NSString *  yuanchuang_count = [rs stringForColumn:@"yuanchuang_count"];
                NSString *  zhongce_count = [rs stringForColumn:@"zhongce_count"];
                NSString *  second_count = [rs stringForColumn:@"second_count"];
                NSString *  wiki_count = [rs stringForColumn:@"wiki_count"];
                NSString *  favorite_count = [rs stringForColumn:@"favorite_count"];
                NSString *  fans_num = [rs stringForColumn:@"fans_num"];
                NSString *  follower_num = [rs stringForColumn:@"follower_num"];
                NSString *  isOpenOneKeyOut = [rs stringForColumn:@"isOpenOneKeyOut"];
                NSString *  is_show_my_medal = [rs stringForColumn:@"is_show_my_medal"];
                NSString *  is_bind_visa = [rs stringForColumn:@"is_bind_visa"];
                NSString *  video_is_show = [rs stringForColumn:@"video_is_show"];
                NSString *  baoliao_comment_msg = [rs stringForColumn:@"baoliao_comment_msg"];



                [dic setValue:baoliao_count forKey:@"baoliao_count"];
                [dic setValue:yuanchuang_count forKey:@"yuanchuang_count"];
                [dic setValue:zhongce_count forKey:@"zhongce_count"];
                [dic setValue:second_count forKey:@"second_count"];
                [dic setValue:wiki_count forKey:@"wiki_count"];
                [dic setValue:favorite_count forKey:@"favorite_count"];
                [dic setValue:fans_num forKey:@"fans_num"];
                [dic setValue:follower_num forKey:@"follower_num"];
                [dic setValue:isOpenOneKeyOut forKey:@"isOpenOneKeyOut"];
                [dic setValue:is_show_my_medal forKey:@"is_show_my_medal"];
                [dic setValue:is_bind_visa forKey:@"is_bind_visa"];
                [dic setValue:video_is_show forKey:@"video_is_show"];
                [dic setValue:baoliao_comment_msg forKey:@"baoliao_comment_msg"];

                NSString *  en_key = [rs stringForColumn:@"en_key"];
                NSString *  server_time = [rs stringForColumn:@"server_time"];
                [dic setValue:en_key forKey:@"en_key"];
                [dic setValue:server_time forKey:@"server_time"];


            }
            [rs close];

        }
    }
    return dic;
}
- (BOOL)isBindMobile:(NSString *)uid
{
    BOOL isBind = NO;
    if([self.fmDatabase open])
    {
        FMResultSet *rs = [self.fmDatabase executeQuery:@"SELECT bindmobile FROM USER WHERE id = ? ",uid];
        if ( rs != nil )
        {
            while([rs next])
            {
                NSString * bindmobile = [rs stringForColumn:@"bindmobile"];
                if ([bindmobile integerValue]==1) {
                    isBind = YES;
                }else
                {
                    isBind = NO;
                }

            }
            
            [rs close];
        
        }
    }
    return  isBind;

}
- (void)insertMobile:(NSString *)mobileId withUid:(NSString *)uid
{
    if([self.fmDatabase open])
    {
        if([self isExistUser:uid])
        {
            [self.fmDatabase executeUpdate:@"UPDATE USER SET bindmobile=? WHERE id = ?",mobileId,uid];
        }
    }

}
@end
