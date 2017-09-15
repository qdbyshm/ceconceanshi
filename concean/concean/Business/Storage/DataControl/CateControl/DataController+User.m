//
//  DataController+User.m
//  concean
//
//  Created by sunhaoming on 2017/9/13.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "DataController+User.h"
#import "LocalData+User.h"
@implementation DataController (User)

- (void)userInfoData
{
    NSMutableDictionary * dics = [[NSMutableDictionary alloc]init];
    
    NSDictionary * dic = [localData lastUserData];
    if (dic) {
        
        if ([[dic valueForKey:@"username"]isSafeString]) {
            [dics setValue:[dic valueForKey:@"username"] forKey:@"username"];
        }
        if ([[dic valueForKey:@"password"]isSafeString]) {
            [dics setValue:[dic valueForKey:@"password"] forKey:@"password"];
        }
        if ([[dic valueForKey:@"token"]isSafeString]) {
            [dics setValue:[dic valueForKey:@"token"] forKey:@"token"];
        }
        if ([[dic valueForKey:@"uid"]isSafeString]) {
            [dics setValue:[dic valueForKey:@"uid"] forKey:@"uid"];
        }
        self.userInfo = dics;
        if ([[dic valueForKey:@"uid"] length]<1&&[[dic valueForKey:@"password"] length]>0) {
            [self exitLogin2:[dic valueForKey:@"username"]];
        }
    }
}

- (void)exitLogin2:(NSString *)userName
{
    [localData deletePassword2:userName];
    [self.userInfo removeAllObjects];
}

@end
