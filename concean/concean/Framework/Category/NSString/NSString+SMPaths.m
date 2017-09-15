//
//  NSString+SMPaths.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/5/30.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSString+SMPaths.h"
#import "NSFileManager+SMPaths.h"

@implementation NSString (SMPaths)

//文件、文件夹路径
- (NSString *)sm_filePathAtDocument
{
    if (![self isSafeString]) {
        return self;
    }
    
    NSString *documentPaths = [NSFileManager sm_documentsPath];
    
    NSMutableString *path = [NSMutableString string];
    
    [path appendString:[documentPaths stringByAppendingPathComponent:self]];
    
    return path;
}

//文件、文件夹路径
- (NSString *)sm_filePathAtLibrary
{
    if (![self isSafeString]) {
        return self;
    }
    
    NSString *libraryPaths = [NSFileManager sm_libraryPath];
    
    NSMutableString *path = [NSMutableString string];
    
    [path appendString:[libraryPaths stringByAppendingPathComponent:self]];
    
    return path;
}

//文件、文件夹路径
- (NSString *)sm_filePathAtCaches
{
    if (![self isSafeString]) {
        return self;
    }
    
    NSString *cachesPaths = [NSFileManager sm_cachesPath];
    
    NSMutableString *path = [NSMutableString string];
    
    [path appendString:[cachesPaths stringByAppendingPathComponent:self]];
    
    return path;
}

@end
