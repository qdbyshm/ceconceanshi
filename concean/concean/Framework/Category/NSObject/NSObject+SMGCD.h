//
//  NSObject+SMGCD.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/9/12.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SMGCD)

/**
 *  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)sm_performAsynchronous:(void(^)(void))block;
+ (void)sm_performAsynchronous:(void(^)(void))block;

/**
 *  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求 YES - Synchronous；NO - Asynchronous
 */
- (void)sm_performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)sm_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;

@end
