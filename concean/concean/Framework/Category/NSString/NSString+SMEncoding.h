//
//  NSString+SMEncoding.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/7/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SMEncoding)

- (NSString *)sm_EncodedString;

#ifdef DEBUG

- (NSString *)yw_stringByReplaceUnicode;
- (NSString *)yw_stringByReplaceUnicode:(NSString *)unicodeString;

#else

#endif

@end
