//
//  HelperTools.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/1/12.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "HelperTools.h"
#import "NSFileManager+SMPaths.h"
#import "NSString+SMPaths.h"

@interface HelperTools ()

@end

@implementation HelperTools

/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊写入NSDictionary文件
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+ (BOOL)writeFileDict:(NSDictionary *)dictionary fileName:(NSString *)fileName;
{
    NSMutableString *stringPath = [fileName sm_filePathAtDocument];
    if ([NSFileManager sm_filesIsExist:stringPath]) {
        [NSFileManager sm_removeFiles:stringPath];
    }
    return [dictionary writeToFile:stringPath atomically:YES];
}

+ (BOOL)writeFileArray:(NSArray *)array fileName:(NSString *)fileName
{
    NSMutableString *stringPath = [fileName sm_filePathAtDocument];
    if ([NSFileManager sm_filesIsExist:stringPath]) {
        [NSFileManager sm_removeFiles:stringPath];
    }
    return [array writeToFile:stringPath atomically:YES];
}

+ (BOOL)writeFileDict:(NSDictionary *)dictionary inFolder:(NSString *)folderName fileName:(NSString *)fileName;
{
    BOOL res = NO;
    
    if ([folderName isSafeString]) {
        
        BOOL resCreate = [NSFileManager sm_createFileAtDocument:folderName];
        
        if (resCreate) {
            NSMutableString *stringPath = [[NSString stringWithFormat:@"%@/%@",folderName,fileName] sm_filePathAtDocument].mutableCopy;
            if ([NSFileManager sm_filesIsExist:stringPath]) {
                [NSFileManager sm_removeFiles:stringPath];
            }
            res = [dictionary writeToFile:stringPath atomically:YES];
        }
        
    } else {
        res = [HelperTools writeFileDict:dictionary fileName:fileName];
    }
    
    return res;
}

+ (BOOL)writeFileArray:(NSArray *)array inFolder:(NSString *)folderName fileName:(NSString *)fileName;
{
    BOOL res = NO;
    
    if ([folderName isSafeString]) {
        
        BOOL resCreate = [NSFileManager sm_createFileAtDocument:folderName];
        
        if (resCreate) {
            NSMutableString *stringPath = [[NSString stringWithFormat:@"%@/%@",folderName,fileName] sm_filePathAtDocument].mutableCopy;
            if ([NSFileManager sm_filesIsExist:stringPath]) {
                [NSFileManager sm_removeFiles:stringPath];
            }
            res = [array writeToFile:stringPath atomically:YES];
        }
        
    } else {
        res = [HelperTools writeFileArray:array fileName:fileName];
    }
    
    return res;
}

+ (NSMutableDictionary *)readFileDict:(NSString *)fileName
{
    return [[NSMutableDictionary alloc] initWithContentsOfFile:[fileName sm_filePathAtDocument]];
}

+ (NSMutableArray *)readFileArray:(NSString *)fileName
{
    return [[NSMutableArray alloc] initWithContentsOfFile:[fileName sm_filePathAtDocument]];
}

+ (NSMutableDictionary *)readDictFileInFolder:(NSString *)folderName fileName:(NSString *)fileName;
{
    NSMutableDictionary *result = nil;
    
    if ([folderName isSafeString]) {
        result = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSString stringWithFormat:@"%@/%@",folderName,fileName] sm_filePathAtDocument]];
    } else {
        result = [HelperTools readFileDict:fileName];
    }
    
    return result;
}

+ (NSMutableArray *)readArrayInFolder:(NSString *)folderName fileName:(NSString *)fileName;
{
    NSMutableArray *result = nil;
    
    if ([folderName isSafeString]) {
        result = [[NSMutableArray alloc] initWithContentsOfFile:[[NSString stringWithFormat:@"%@/%@",folderName,fileName] sm_filePathAtDocument]];
    } else {
        result = [HelperTools readFileDict:fileName];
    }
    
    return result;
}

@end
