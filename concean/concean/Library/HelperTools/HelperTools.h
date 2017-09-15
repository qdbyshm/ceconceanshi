//
//  HelperTools.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/1/12.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelperTools : NSObject

+ (BOOL)writeFileDict:(NSDictionary *)dictionary fileName:(NSString *)fileName;
+ (BOOL)writeFileArray:(NSArray *)array fileName:(NSString *)fileName;

+ (BOOL)writeFileDict:(NSDictionary *)dictionary inFolder:(NSString *)folderName fileName:(NSString *)fileName;
+ (BOOL)writeFileArray:(NSArray *)array inFolder:(NSString *)folderName fileName:(NSString *)fileName;

+ (NSMutableDictionary *)readFileDict:(NSString *)fileName;
+ (NSMutableArray *)readFileArray:(NSString *)fileName;

+ (NSMutableDictionary *)readDictFileInFolder:(NSString *)folderName fileName:(NSString *)fileName;
+ (NSMutableArray *)readArrayInFolder:(NSString *)folderName fileName:(NSString *)fileName;

@end
