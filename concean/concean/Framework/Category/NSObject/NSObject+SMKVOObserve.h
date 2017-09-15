//
//  NSObject+SMKVOObserve.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/6/1.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Observer with block (KVO).
 */
@interface NSObject (SMKVOObserve)


- (void)sm_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id _Nonnull obj, _Nullable id oldVal, _Nullable id newVal))block;

- (void)sm_removeObserverBlocksForKeyPath:(NSString *)keyPath;

- (void)sm_removeObserverBlocks;

@end

NS_ASSUME_NONNULL_END
