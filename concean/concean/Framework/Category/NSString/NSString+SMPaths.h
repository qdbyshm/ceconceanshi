//
//  NSString+SMPaths.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/5/30.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SMPaths)

//文件、文件夹路径
- (NSString *)sm_filePathAtDocument;
//文件、文件夹路径
- (NSString *)sm_filePathAtLibrary;
//文件、文件夹路径
- (NSString *)sm_filePathAtCaches;

@end
