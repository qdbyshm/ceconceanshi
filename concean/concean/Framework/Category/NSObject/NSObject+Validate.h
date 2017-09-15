//
//  NSObject+Validate.h
//  SMZDM
//
//  Created by chenshan on 16/3/8.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Validate)

- (BOOL)safeDictWithKey:(NSString * _Nonnull)key;
- (BOOL)hasArrayForKey:(NSString *_Nonnull)key;

- (NSURL *_Nullable)safeUrl;


/**
 安全对象判断
 */
- (BOOL)isSafeObj;
- (BOOL)isSafeArray;
- (BOOL)isSafeString;
- (BOOL)isSafeEmptyString;
- (BOOL)isSafeNonEmptyString;
- (BOOL)isSafeDictionary;

- (NSString *_Nullable)safeString DEPRECATED_MSG_ATTRIBUTE("弃用属性，nil不会调用改方法，存在crash风险");
- (NSString *_Nonnull)safeEmptyString;
- (NSString *_Nonnull)safeZeroString;
- (BOOL)safeBoolValue;

- (BOOL)arrayHasData;
- (BOOL)dictionaryHasData;
- (BOOL)dictionaryHasKey:(NSString * __nonnull)keyTarget;

- (NSString *_Nullable)getSafeString;

#pragma mark - add new methods -
BOOL isSafeObj(id _Nullable anObject);
BOOL isSafeArray(id _Nullable anObject);
BOOL isSafeString(id _Nullable anObject);
BOOL isSafeDictionary(id _Nullable anObject);

BOOL isClass_Array(id _Nullable anObject);
BOOL isClass_String(id _Nullable anObject);
BOOL isClass_Dictionary(id _Nullable anObject);

NSString * _Nonnull safeString(id _Nullable anObject);
NSString * _Nonnull safeGtmString(id _Nullable anObject);
NSString * _Nonnull safeZeroString(id _Nullable anObject);
BOOL safeBool(id _Nullable anObject);

BOOL arrayHasData(id _Nullable anObject);
BOOL dictionaryHasData(id _Nullable anObject);
BOOL dictionaryHasKey(id _Nonnull anObject , NSString * __nonnull keyTarget);

@end
