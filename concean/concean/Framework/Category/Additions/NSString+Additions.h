//
//  NSString+Additions.h
//  NetEaseMicroBlog
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Additions)
- (NSString *)URLEncodedString;

- (NSString *)URLDecodedString;

- (NSString *)DecodedEngSymbol;

/*!
 * @brief  无图模式返回图片name
 */
- (NSString *)imageSpecificName;
+ (NSString *)convertToTimeStamp:(NSDate *)date;
@end
