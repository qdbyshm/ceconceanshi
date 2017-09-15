//
//  NSString+SMEncoding.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/7/11.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSString+SMEncoding.h"

@implementation NSString (SMEncoding)

- (NSString *)sm_EncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                    kCFStringEncodingUTF8));
    //encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", kCFStringEncodingUTF8));
    //CFSTR("!$&'()*+,-./:;=?@_~%#[]");
    return encodedString;
}

#ifdef DEBUG
- (NSString *)yw_stringByReplaceUnicode
{
    return [self yw_stringByReplaceUnicode:self];
}

- (NSString *)yw_stringByReplaceUnicode:(NSString *)unicodeString
{
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}
#else

#endif

@end
