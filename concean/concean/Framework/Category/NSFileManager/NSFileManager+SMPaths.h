//
//  NSFileManager+SMPaths.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/5/29.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (SMPaths)

/**
 Get URL of Documents directory.
 
 @return Documents directory URL.
 */
+ (NSURL *)sm_documentsURL;

/**
 Get path of Documents directory.
 
 @return Documents directory path.
 */
+ (NSString *)sm_documentsPath;

/**
 Get URL of Library directory.
 
 @return Library directory URL.
 */
+ (NSURL *)sm_libraryURL;

/**
 Get path of Library directory.
 
 @return Library directory path.
 */
+ (NSString *)sm_libraryPath;

/**
 Get URL of Caches directory.
 
 @return Caches directory URL.
 */
+ (NSURL *)sm_cachesURL;

/**
 Get path of Caches directory.
 
 @return Caches directory path.
 */
+ (NSString *)sm_cachesPath;

/**
 Adds a special filesystem flag to a file to avoid iCloud backup it.
 
 @param path Path to a file to set an attribute.
 */
+ (BOOL)sm_addSkipBackupAttributeToFile:(NSString *)path;

/**
 Get available disk space.
 
 @return An amount of available disk space in Megabytes.
 */
+ (double)sm_availableDiskSpace;

/**
 Create file at document
 
 @param fileName - fils's name.
 */
+ (BOOL)sm_createFileAtDocument:(NSString *)fileName;

/**
 Create file at library
 
 @param fileName - fils's name.
 */
+ (BOOL)sm_createFileAtLibrary:(NSString *)fileName;

/**
 Create file at caches
 
 @param fileName - fils's name.
 */
+ (BOOL)sm_createFileAtCaches:(NSString *)fileName;

/**
 *  To determine whether a file exists
 *
 *
 *  @return YES-there are; NO- not there is no
 */
+ (BOOL)sm_filesIsExist:(NSString *)filesPath;

/**
 *  Delete files at specified path
 *
 
 *
 *  @return YES-success NO-failed
 */
+ (BOOL)sm_removeFiles:(NSString *)filesPath;

@end
