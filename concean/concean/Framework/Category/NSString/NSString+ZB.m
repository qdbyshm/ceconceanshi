//
//  NSString+ZB.m
//  SMZDM
//
//  Created by zhaobin on 2017/8/17.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "NSString+ZB.h"

@implementation NSString (ZB)

- (NSInteger)getByteLength {
    __block NSUInteger asciiLength = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                              if (substringRange.length == 1) {
                                  unichar uc = [substring characterAtIndex:0];
                                  if (isascii(uc)) {
                                      asciiLength += 1;
                                      return;
                                  }
                              }
                              asciiLength += 2;
                          }];
    NSUInteger unicodeLength = asciiLength;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}

- (NSString *)removeHTML {
    //  过滤html标签
    NSScanner *theScanner;
    NSString *text = @"";
    NSString *str = @"";
    theScanner = [NSScanner scannerWithString:self];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        str = [self stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //  过滤html中的\n\r\t换行空格等特殊符号
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        
        //  在这里添加要过滤的特殊符号
        if ( c == '\r' || c == '\n' || c == '\t' ) {
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    str  = [NSString stringWithString:str1];
    return str;
}

- (NSArray *)filterImage {
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [self substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
}

- (NSString *)subStringByByteWithIndex:(NSInteger)index {
    NSInteger sum = 0;
    NSString *subStr = [[NSString alloc] init];
    for (int i = 0; i < [self length]; i++){
        unichar strChar = [self characterAtIndex:i];
        if(strChar < 256){
            sum += 1;
        }
        else {
            sum += 2;
        }
        if (sum >= index) {
            subStr = [self substringToIndex:i + 1];
            return subStr;
        }
    }
    return subStr;
}

@end
