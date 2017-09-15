//
//  LocalData+User.h
//  SMZDM
//
//  Created by 冯展波 on 14-9-3.
//
//

#import "LocalData.h"

@interface LocalData (User)

- (void)insertUserInfo:(NSDictionary *)dic UserDic:(NSDictionary *)uDic;

- (void)deletePassword:(NSDictionary *)dic;
- (void)deletePassword2:(NSString *)username;
- (NSDictionary *)lastUserData;

- (NSMutableDictionary *)getUserData:(NSString *)name;

- (BOOL)isBindMobile:(NSString *)uid;
- (void)insertMobile:(NSString *)mobileId withUid:(NSString *)uid;
@end
