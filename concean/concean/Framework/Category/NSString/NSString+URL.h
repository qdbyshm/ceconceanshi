//
//  NSString+URL.h
//  SMZDM
//
//  Created by sunhaoming on 15/7/14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

- (NSString *)URLEncodedString;

-(NSString *)URLDecodedString;

- (BOOL)sm_containsString:(NSString *)str;

@end
