//
//  NSString+Additions.m
//  NetEaseMicroBlog
//
//  Created by wuzhikun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Additions.h"


@implementation NSString (Additions)
- (NSString *)URLEncodedString 
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8);
    [result autorelease];
	return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
    [result autorelease];
	return result;	
}

//英文符号替换成中文符号
- (NSString*)DecodedEngSymbol{
    NSString *result = [self stringByReplacingOccurrencesOfString:@"'" withString:@"‘"];
    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"“"];
    result = [result stringByReplacingOccurrencesOfString:@"<" withString:@"《"];
    result = [result stringByReplacingOccurrencesOfString:@">" withString:@"》"];
    result = [result stringByReplacingOccurrencesOfString:@"," withString:@"，"];
    return result;
}

- (NSString *)imageSpecificName
{
    NSMutableString *stringImageName = [NSMutableString string];
    if ([self isSafeString]) {
        [stringImageName setString:self];
    }
    return stringImageName;
}

+ (NSString *)convertToTimeStamp:(NSDate *)date{
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    return timeSp;
}

@end
