//
//  DataController.m
//  SMZDMF
//
//  Created by 冯展波 on 14-8-5.
//  Copyright (c) 2014年 冯展波. All rights reserved.
//

#import "DataController.h"

@implementation DataController

- (id)init
{
    self = [super init];
    if(self)
    {
        _userInfo = [[NSMutableDictionary alloc]init];
        self.currentIndex = 0;
        localData  = [[LocalData alloc]init];
        [localData openSqlite];
    }
    return self;
}

- (void)deleteAllData
{
    //    [localData deleteIds];
}
- (BOOL)fistGuide
{
    NSString * str = [NSString stringWithFormat:@"GUIDE_%@",[SMZDMAppInfo shareInstance].CFBundleShortVersionString];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:str]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:str];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
    return NO;
}

#pragma mark - getter

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    switch (currentIndex) {
        case 0:
            break;
        case 1:
            break;
        default:
            break;
    }
}

- (void)clearLocalData
{
}

//删除没有用到的数据库************新用户充值数据
- (void)deleteSQL
{
}


@end
