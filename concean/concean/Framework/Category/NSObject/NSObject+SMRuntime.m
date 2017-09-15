//
//  NSObject+SMRuntime.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/6/1.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSObject+SMRuntime.h"
#import <objc/runtime.h>

BOOL yw_method_swizzle(Class klass, SEL origSel, SEL altSel)
{
    if (!klass)
        return NO;
    
    Method __block origMethod, __block altMethod;
    
    void (^find_methods)() = ^
    {
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);
        
        origMethod = altMethod = NULL;
        
        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i)
            {
                if (method_getName(methodList[i]) == origSel)
                    origMethod = methodList[i];
                
                if (method_getName(methodList[i]) == altSel)
                    altMethod = methodList[i];
            }
        
        free(methodList);
    };
    
    find_methods();
    
    if (!origMethod)
    {
        origMethod = class_getInstanceMethod(klass, origSel);
        
        if (!origMethod)
            return NO;
        
        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod)))
            return NO;
    }
    
    if (!altMethod)
    {
        altMethod = class_getInstanceMethod(klass, altSel);
        
        if (!altMethod)
            return NO;
        
        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
            return NO;
    }
    
    find_methods();
    
    if (!origMethod || !altMethod)
        return NO;
    
    method_exchangeImplementations(origMethod, altMethod);
    
    return YES;
}

@implementation NSObject (SMRuntime)

@dynamic runtimeIndex, runtimeValue;

static void *runtimeIndexKey = &runtimeIndexKey;

- (void)setRuntimeIndex:(NSInteger)runtimeIndex
{
    objc_setAssociatedObject(self, &runtimeIndexKey, @(runtimeIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)runtimeIndex
{
    return [objc_getAssociatedObject(self, &runtimeIndexKey) integerValue];
}

static void *runtimeValueKey = &runtimeValueKey;

- (void)setRuntimeValue:(id)runtimeValue
{
    objc_setAssociatedObject(self, &runtimeValueKey, runtimeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)runtimeValue
{
    return objc_getAssociatedObject(self, &runtimeValueKey);
}

#pragma mark - Associate value

- (void)sm_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sm_setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)sm_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)sm_removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}

#pragma mark - Swap method (Swizzling)

+ (BOOL)sm_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}

+ (BOOL)sm_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getClassMethod(class, originalSel);
    Method newMethod = class_getClassMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

/**
 Exchange methods' implementations.
 
 @param originalMethod Method to exchange.
 @param newMethod Method to exchange.
 */
+ (void)yw_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod
{
    [self yw_method_swizzle:self.class originalMethod:originalMethod newMethod:newMethod];
}

+ (void)yw_method_swizzle:(Class)cls originalMethod:(SEL)originalMethod newMethod:(SEL)newMethod
{
    yw_method_swizzle(cls, originalMethod, newMethod);
}

@end
