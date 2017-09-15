//
//  RequestManager.h
//
//  Created by 展波 冯 on 14/11/4.
//  Copyright (c) 2014年 展波 冯. All rights reserved.
//

#define METHOD_POST @"POST"
#define METHOD_GET @"GET"

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define IDFAKEY         @"smzdmidfa18911150977"

typedef void(^RequestSeccessBlock)(id result);
typedef void(^RequestFailBlock)(NSError *error);

@interface RequestManager : NSObject

///数据请求
+ (void)requestWithUrl:(NSString *)url body:(NSDictionary *)body Method:(NSString *)method TimeOut:(NSString *)time seccessBlock:(RequestSeccessBlock)seccessBlock failBlock:(RequestFailBlock)failBlock timeBlock:(RequestFailBlock)timeBlock;

+ (void)downLoadWithUrl:(NSString *)aurl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName seccessBlock:(RequestSeccessBlock)seccessBlock failBlock:(RequestFailBlock)failBlock;


///数据请求
+ (void)requestSynchronousWithUrl:(NSString *)url body:(NSDictionary *)body Method:(NSString *)method TimeOut:(NSString *)time seccessBlock:(RequestSeccessBlock)seccessBlock failBlock:(RequestFailBlock)failBlock timeBlock:(RequestFailBlock)timeBlock;

@end
