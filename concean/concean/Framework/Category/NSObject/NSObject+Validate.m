//
//  NSObject+Validate.m
//  SMZDM
//
//  Created by chenshan on 16/3/8.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSObject+Validate.h"

@implementation NSObject (Validate)

- (BOOL)safeDictWithKey:(NSString * _Nonnull)key
{
    BOOL res = NO;
    
    if ([self isSafeDictionary]) {
        NSDictionary *dictTemp = (NSDictionary *)self;
        if (dictTemp.count && dictTemp[key]) {
            res = YES;
        }
    }
    
    return res;
}

- (BOOL)hasArrayForKey:(NSString *_Nonnull)key
{
    if (![self isSafeDictionary]) return NO;
    
    NSDictionary *dic = (NSDictionary *)self;
    
    if(![dic[key] isSafeObj]) return NO;
    
    if(![dic[key] isKindOfClass:[NSArray class]]) return NO;
    
    return [(NSArray *)dic[key] count] > 0;
}

- (NSURL *_Nullable)safeUrl
{
    if ([self isSafeString]) {
        return [[NSURL alloc] initWithString:[(NSString *)self trim]];
    }
    return nil;
}

/**
 安全对象判断
 */
- (BOOL)isSafeObj
{
    BOOL res = NO;
    
    if (self && ![self isKindOfClass:[NSNull class]] && ![self isEqual:[NSNull null]]) {
        res = YES;
    }
    
    return res;
}

- (BOOL)isSafeArray
{
    BOOL res = NO;
    
    if ([self isSafeObj]) {
        if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]) {
            res = YES;
        }
    }
    
    return res;
}

- (BOOL)isSafeString
{
    BOOL res = NO;
    
    if ([self isSafeObj]) {
        if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSMutableString class]]) {
            NSString *stringTemp = self;
            if ([stringTemp isEqualToString:@"<null>"] || [stringTemp isEqualToString:@"(null)"] || [stringTemp isEqualToString:@"null"] || !stringTemp.length) {
                res = NO;
            } else {
                res = YES;
            }
        }
    }
    
    return res;
}

- (BOOL)isSafeEmptyString{
     BOOL res = NO;
    if ([self isSafeString]) {
        if (((NSString *)self).length == 0 || [((NSString *)self) trim].length == 0) {
            res = YES;
        }
    }
    return res;
}

- (BOOL)isSafeNonEmptyString{
    BOOL res = NO;
    if ([self isSafeString]) {
        if (((NSString *)self) && [((NSString *)self) trim].length) {
            res = YES;
        }
    }
    return res;
}


- (BOOL)isSafeDictionary
{
    BOOL res = NO;
    
    if ([self isSafeObj]) {
        if ([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]]) {
            res = YES;
        }
    }
    
    return res;
}

- (NSString *_Nullable)safeString
{
    if ([self isSafeString]) {
        return [(NSString *)self trim];
    }
    return @"";
}

- (NSString *_Nonnull)safeEmptyString {
    if([self isSafeNonEmptyString]){
        return [(NSString *)self trim];
    }
    return @"";
}

- (NSString *_Nonnull)safeZeroString {
    if([self isSafeNonEmptyString]){
        return [(NSString *)self trim];
    }
    return @"0";
}

- (BOOL)safeBoolValue {
    if([self isSafeString]) {
        if([(NSString *)self isEqualToString:@"1"]) return YES;
        
        return NO;
    }
    //if([self isKindOfClass:[nsc]])
    return (BOOL)self;
}

- (BOOL)arrayHasData
{
    BOOL res = NO;
    
    if ([self isSafeArray]) {
        NSArray *array = (NSArray *)self;
        if (array.count) {
            res = YES;
        }
    }
    
    return res;
}

- (BOOL)dictionaryHasData
{
    BOOL res = NO;
    
    if ([self isSafeDictionary]) {
        NSDictionary *dictTemp = (NSDictionary *)self;
        if ([[dictTemp allKeys] count]) {
            res = YES;
        }
    }
    
    return res;
}

- (BOOL)dictionaryHasKey:(NSString * __nonnull)keyTarget
{
    __block BOOL res = NO;
    
    if ([self dictionaryHasData]) {
        NSMutableDictionary *dictTemp = self;
        [dictTemp enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:keyTarget]) {
                res = YES;
                *stop = YES;
            }
        }];
    }
    
    return res;
}


/**
 获取安全字符串 若为非安全字符串返回@“”

 @return 安全字符串
 */
- (NSString *_Nullable)getSafeString {

    if ([self isSafeObj]) {
        NSString *stringTemp = self;
        if ([stringTemp isEqualToString:@"<null>"] || [stringTemp isEqualToString:@"(null)"] || [stringTemp isEqualToString:@"null"] || !stringTemp.length) {
            return @"";
        }
        return stringTemp;
    }

    return @"";

}

#pragma mark - add new methods -
BOOL isSafeObj(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (anObject && ![anObject isKindOfClass:[NSNull class]] && ![anObject isEqual:[NSNull null]]) {
        res = YES;
    }
    
    return res;
}

BOOL isSafeArray(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (anObject && isSafeObj(anObject)) {
        
        if ([anObject isKindOfClass:[NSArray class]] || [anObject isKindOfClass:[NSMutableArray class]]) {
            
            res = YES;
            
        }
        
    }
    
    return res;
}

BOOL isSafeString(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (anObject && isSafeObj(anObject)) {
        
        if ([anObject isKindOfClass:[NSString class]] || [anObject isKindOfClass:[NSMutableString class]]) {
            
            NSString *stringTemp = [(NSString *)anObject trim];
            
            if ([stringTemp isEqualToString:@"<null>"] || [stringTemp isEqualToString:@"(null)"] || [stringTemp isEqualToString:@"null"] || !stringTemp.length) {
                
                res = NO;
                
            } else {
                
                res = YES;
                
            }
            
        }
        
    }
    
    return res;
}

BOOL isSafeDictionary(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (anObject && isSafeObj(anObject)) {
        
        if ([anObject isKindOfClass:[NSDictionary class]] || [anObject isKindOfClass:[NSMutableDictionary class]]) {
            
            res = YES;
            
        }
        
    }
    
    return res;
}

BOOL isClass_Array(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (isSafeObj(anObject)) {
        
        if ([anObject isMemberOfClass:NSArray.class] || [anObject isKindOfClass:NSArray.class]) {
            
            res = YES;
            
        }
        
    }
    
    return res;
    
}

BOOL isClass_String(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (isSafeObj(anObject)) {
        
        if ([anObject isMemberOfClass:NSString.class] || [anObject isKindOfClass:NSString.class]) {
            
            res = YES;
            
        }
        
    }
    
    return res;
    
}

BOOL isClass_Dictionary(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (isSafeObj(anObject)) {
        
        if ([anObject isMemberOfClass:NSDictionary.class] || [anObject isKindOfClass:NSDictionary.class]) {
            
            res = YES;
            
        }
        
    }
    
    return res;
    
}

NSString * _Nonnull safeString(id _Nullable anObject) {
    
    if (anObject && isSafeString(anObject)) {
        
        return [(NSString *)anObject trim];
        
    }
    
    return @"";
}

BOOL safeBool(id _Nullable anObject) {
    
    if (anObject) {
        
        if([anObject isKindOfClass:[NSNumber class]]) {
            if([anObject isEqualToValue:[NSNumber numberWithBool:YES]]) return YES;
        }
        
        if([anObject isKindOfClass:[NSString class]] && [(NSString *)anObject isEqualToString:@"1"]) return YES;
        
    }
    
    return NO;
}

NSString * _Nonnull safeGtmString(id _Nullable anObject) {
    
    if (anObject && isSafeString(anObject)) {
        
        return safeString(anObject);
        
    }
    
    return @"无";
}

NSString * _Nonnull safeZeroString(id _Nullable anObject) {
    
    if (anObject && isSafeString(anObject)) {
        
        return safeString(anObject);
        
    }
    
    return @"0";
}

BOOL arrayHasData(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (anObject && isSafeArray(anObject)) {
        
        NSArray *array = anObject;
        
        if (array.count) {
            res = YES;
        }
        
    }
    
    return res;
}

BOOL dictionaryHasData(id _Nullable anObject) {
    
    BOOL res = NO;
    
    if (anObject && isSafeDictionary(anObject)) {
        
        NSDictionary *dict = anObject;
        
        if ([[dict allKeys] count]) {
            res = YES;
        }
        
    }
    
    return res;
}

BOOL dictionaryHasKey(id _Nonnull anObject , NSString * __nonnull keyTarget) {
    
    __block BOOL res = NO;
    
    if (isSafeDictionary(anObject) && isSafeString(keyTarget)) {
        
        NSDictionary *dict = anObject;
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([key isEqualToString:keyTarget]) {
                res = YES;
                *stop = YES;
            }
            
        }];
        
    }
    
    return res;
}

@end
