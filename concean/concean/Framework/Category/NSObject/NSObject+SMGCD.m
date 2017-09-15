//
//  NSObject+SMGCD.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/9/12.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSObject+SMGCD.h"

@implementation NSObject (SMGCD)

/**
 *  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)sm_performAsynchronous:(void(^)(void))block
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}

+ (void)sm_performAsynchronous:(void(^)(void))block
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}

/**
 *  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求 YES - Synchronous；NO - Asynchronous
 */
- (void)sm_performOnMainThread:(void(^)(void))block wait:(BOOL)wait
{
    if (wait) {
        // Synchronous
        dispatch_sync(dispatch_get_main_queue(), block);
    } else {
        // Asynchronous
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 *  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)sm_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
    // dispatch_after(popTime, dispatch_get_current_queue(), block);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end
