//
//  NSFileManager+SMPaths.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/5/29.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSFileManager+SMPaths.h"
#include <sys/xattr.h>
#import "NSString+SMPaths.h"

#define kSMDefaultManager   [NSFileManager defaultManager]

@implementation NSFileManager (SMPaths)

+ (NSURL *)sm_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)sm_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)sm_documentsURL
{
    return [self sm_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)sm_documentsPath
{
    return [self sm_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)sm_libraryURL
{
    return [self sm_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)sm_libraryPath
{
    return [self sm_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)sm_cachesURL
{
    return [self sm_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)sm_cachesPath
{
    return [self sm_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)sm_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)sm_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.sm_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

+ (BOOL)sm_createFileAtPath:(NSString *)path
{
    BOOL res = NO;
    
    if ([NSFileManager sm_filesIsExist:path]) {
        NSLog(@"文件已存在");
        res = YES;
    } else {
        NSError *error = nil;
        res = [kSMDefaultManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"%@",error.userInfo);
        }
    }
    
    NSLog(@"path = %@",path);
    
    return res;
}

+ (BOOL)sm_createFileAtDocument:(NSString *)fileName
{
    BOOL res = NO;
    
    if ([fileName isSafeString]) {
        
        res = [NSFileManager sm_createFileAtPath:[fileName sm_filePathAtDocument]];
        
    }
    
    return res;
}

/**
 Create file at library
 
 @param fileName - fils's name.
 */
+ (BOOL)sm_createFileAtLibrary:(NSString *)fileName
{
    BOOL res = NO;
    
    if ([fileName isSafeString]) {
        
        res = [NSFileManager sm_createFileAtPath:[fileName sm_filePathAtLibrary]];
        
    }
    
    return res;
}

/**
 Create file at caches
 
 @param fileName - fils's name.
 */
+ (BOOL)sm_createFileAtCaches:(NSString *)fileName
{
    BOOL res = NO;
    
    if ([fileName isSafeString]) {
        
        res = [NSFileManager sm_createFileAtPath:[fileName sm_filePathAtCaches]];
        
    }
    
    return res;
}

/**
 *  To determine whether a file exists
 *
 *  @param filesPath: specified path
 *
 *  @return YES-there are; NO- not there is no
 */
+ (BOOL)sm_filesIsExist:(NSString *)filesPath
{
    BOOL res = NO;
    
    res = [kSMDefaultManager fileExistsAtPath:filesPath];
    
    return res;
}

/**
 *  Delete files at specified path
 *
 *  @param filesPath specified path
 *
 *  @return YES-success NO-failed
 */
+ (BOOL)sm_removeFiles:(NSString *)filesPath
{
    BOOL res = YES;
    
    if ([NSFileManager sm_filesIsExist:filesPath]) {
        NSError *error = nil;
        res = [kSMDefaultManager removeItemAtPath:filesPath error:&error];
        if (error) {
            NSLog(@"%@",error.userInfo);
        }
    } else {
        NSLog(@"fielsPath not exist");
    }
    
    return res;
}

@end
