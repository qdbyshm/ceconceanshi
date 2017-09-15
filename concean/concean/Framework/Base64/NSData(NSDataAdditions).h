//
//  NSData(NSDataAdditions).h
//  CheckUp
//
//  Created by xl xia on 12-4-5.
//  Copyright (c) 2012年 beyondsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (NSDataAdditions)

+ (id) base64DataFromString:(NSString *)string;
- (NSString *)base64Encoding;
@end
