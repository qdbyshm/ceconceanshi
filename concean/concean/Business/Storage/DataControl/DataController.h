//
//  DataController.h
//  SMZDMF
//
//  Created by 冯展波 on 14-8-5.
//  Copyright (c) 2014年 冯展波. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LocalData.h"
@interface DataController : NSObject
{
    LocalData           *   localData;
}
@property (nonatomic,retain)NSMutableDictionary *userInfo;

@property (nonatomic,assign)NSInteger       currentIndex;//8.0
- (void)clearLocalData;
- (void)deleteSQL;
- (BOOL)fistGuide;
@end
