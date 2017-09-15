//
//  RequestManager.m
//
//  Created by 展波 冯 on 14/11/4.
//  Copyright (c) 2014年 展波 冯. All rights reserved.
//

#define RequestHeaderTokenKey @"RequestHeaderTokenKey"

#import "RequestManager.h"
#import <AdSupport/AdSupport.h>
#import "Desencryption.h"
#import "SMZDMShareInstance.h"
#import "SMZDMAppInfo.h"
#import "SMZDMDeviceInfo.h"
#import "UIDevice+Additions.h"
#define APISINGKEY @"Zj6!9ZwzG4*8LNHUTdBA1j*pJTVCX*oS"

/*
 cookie:
 API:
	device_id:设备id
	device_s：接口返回s
	smzdm_id：用户id
	sess：签名sess值
	device_type：设备类型
	device_system_version：设备系统版本
	device_name：设备名称
	device_smzdm：iphone
	device_smzdm_version:值得买应用版本号
	network：网络类型
	device_push：推送设置
	phone_sort：设备尺寸
	login：登录与否
	partner_id：渠道id
	partner_name：渠道name
	ab_test：ab测试
	rs_id1 到 5： 推荐参数
 
 另外：web的cookie
 还有 v ：版本号
	f ：iphone
 */

@implementation RequestManager

+ (void)requestWithUrl:(NSString *)url body:(NSDictionary *)body Method:(NSString *)method TimeOut:(NSString *)time seccessBlock:(RequestSeccessBlock)seccessBlock failBlock:(RequestFailBlock)failBlock timeBlock:(RequestFailBlock)timeBlock
{
    body = [RequestManager bodyAppending:body];
    if ([body isSafeDictionary]) {
        NSMutableArray *paramArray = [NSMutableArray arrayWithArray:body.allKeys];
        [paramArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
            return [str1 compare:str2];
        }];
        NSMutableString *tempUrl = [[NSMutableString alloc]initWithString:url];
        NSMutableString *stringA = [[NSMutableString alloc]init];//签名string

        for (NSInteger i = 0; i < [paramArray count]; i++) {
            NSString* key = [paramArray objectAtIndex:i];
            NSString* value = [body objectForKey:key];
            if (i==0) {
                [tempUrl appendFormat:@"?%@=%@",key,value];
                [stringA appendFormat:@"%@=%@",key,value];
            } else {
                [tempUrl appendFormat:@"&%@=%@",key,value];
                [stringA appendFormat:@"&%@=%@",key,value];
            }
        }
        
        NSString *stringSignTemp = [NSString stringWithFormat:@"%@&key=%@",stringA,APISINGKEY];
        NSString *sign = [[stringSignTemp md5] uppercaseString];
        
        if (isSafeString(sign)) {
            body = [RequestManager bodyAppendingAndStr:body andNString:sign];
            NSLog(@"Request url = %@&sign=%@",tempUrl,sign);
        }
        else{
            NSLog(@"Request url = %@",tempUrl);
        }
    }
    NSLog(@"%@ body = %@",method,body);
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [sessionManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    if([url rangeOfString:get_push_config_mod].location !=NSNotFound) {
//        {
//            [sessionManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        }
//    }
    sessionManager.requestSerializer.HTTPShouldHandleCookies = YES;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    if ([time length] < 1) {
        sessionManager.requestSerializer.timeoutInterval = 20.f;
    } else {
        sessionManager.requestSerializer.timeoutInterval = [time doubleValue];
    }
    
    
    NSURL *cookieHost = [NSURL URLWithString:url];
    NSMutableDictionary *properties = [RequestManager returnCookie:method];
    [properties enumerateKeysAndObjectsUsingBlock:^(id key,id obj, BOOL *stop) {
        //设定 cookie
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                                
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [cookieHost host], NSHTTPCookieDomain,
                                 
                                 [cookieHost path], NSHTTPCookiePath,
                                 
                                 key,NSHTTPCookieName,
                                 
                                 obj,NSHTTPCookieValue,
                                 
                                 nil]];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }];
    

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionDataTask *sessionDataTask = nil;
    
    
    __weak typeof(self) weakSelf = self;
    void (^taskSuccessBlock)(NSURLSessionDataTask * _Nonnull, id _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf handleSuccess:responseObject sessionDataTask:task seccessBlock:seccessBlock failBlock:failBlock urlString:url];
    };
    
    void (^taskFailedBlock)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf handleFailed:error sessionDataTask:task failBlock:failBlock timeBlock:timeBlock];
    };
    
    if ([[method safeString] isEqualToString:METHOD_GET]) {
        sessionDataTask = [sessionManager GET:url parameters:body progress:nil success:taskSuccessBlock failure:taskFailedBlock];
    }
    else if ([[method safeString] isEqualToString:METHOD_POST]) {
        sessionDataTask = [sessionManager POST:url parameters:body progress:nil success:taskSuccessBlock failure:taskFailedBlock];
    }
    
    [SMZDMShareInstance shareInstance].requestParams = body;
    [SMZDMShareInstance shareInstance].sessionDataTask = sessionDataTask;
    if ([SMZDMShareInstance shareInstance].array_UploadSessionManager) {
        [[SMZDMShareInstance shareInstance].array_UploadSessionManager addObject:sessionDataTask];
    }
}

+ (void)downLoadWithUrl:(NSString *)aurl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName seccessBlock:(RequestSeccessBlock)seccessBlock failBlock:(RequestFailBlock)failBlock
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
    
    if (![fileManager fileExistsAtPath:aSavePath]) {
        [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //下载附件
    NSURL *url = [[NSURL alloc] initWithString:aurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:request.URL];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSData *data = (NSData *)responseObject;
            [data writeToFile:[NSString stringWithFormat:@"%@/%@", aSavePath, aFileName] atomically:YES];
            if (seccessBlock) {
                seccessBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
}

///数据请求
+ (void)requestSynchronousWithUrl:(NSString *)url body:(NSDictionary *)body Method:(NSString *)method TimeOut:(NSString *)time seccessBlock:(RequestSeccessBlock)seccessBlock failBlock:(RequestFailBlock)failBlock timeBlock:(RequestFailBlock)timeBlock{
    body = [RequestManager bodyAppending:body];
    NSMutableString *tempUrlRe = [[NSMutableString alloc]init];
    NSMutableString *tempUrl = [[NSMutableString alloc]initWithString:url];

    if ([body isSafeDictionary]) {
        NSMutableArray *paramArray = [NSMutableArray arrayWithArray:body.allKeys];
        [paramArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
            return [str1 compare:str2];
        }];
        NSMutableString *stringA = [[NSMutableString alloc]init];//签名string

        for (NSInteger i = 0; i < [paramArray count]; i++) {
            NSString* key = [paramArray objectAtIndex:i];
            NSString* value = [body objectForKey:key];
            if (i==0) {
                [tempUrl appendFormat:@"?%@=%@",key,value];
                [tempUrlRe appendFormat:@"%@=%@",key,value];
                [stringA appendFormat:@"%@=%@",key,value];

            } else {
                [tempUrl appendFormat:@"&%@=%@",key,value];
                [tempUrlRe appendFormat:@"&%@=%@",key,value];
                [stringA appendFormat:@"&%@=%@",key,value];
            }
        }
        NSString *stringSignTemp = [NSString stringWithFormat:@"%@&key=%@",stringA,APISINGKEY];
        NSString *sign = [[stringSignTemp md5] uppercaseString];
        if (isSafeString(sign)) {
            body = [RequestManager bodyAppendingAndStr:body andNString:sign];
            [tempUrlRe appendFormat:@"&%@=%@",@"sign",sign];

            NSLog(@"Request url = %@&sign=%@",tempUrl,sign);
        }
        else{
            NSLog(@"Request url = %@",tempUrl);
        }
    }
    NSLog(@"%@ body = %@",method,body);
    
    if(!time){
        time = @"10";
    }
    NSTimeInterval timeInt = [time doubleValue];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeInt];
    [request setHTTPMethod:method];//设置请求方式为POST，默认为GET
    if ([body isSafeDictionary]) {
        NSData *data = [tempUrlRe dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }

    NSString *IDFA = [SMZDMDeviceInfo shareInstance].IDFA;
    
    NSMutableDictionary *properties = [RequestManager returnCookie:method];
 
    
    NSURL *cookieHost = [NSURL URLWithString:url];
    [properties enumerateKeysAndObjectsUsingBlock:^(id key,id obj, BOOL *stop) {
        //设定 cookie
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                                
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [cookieHost host], NSHTTPCookieDomain,
                                 
                                 [cookieHost path], NSHTTPCookiePath,
                                 
                                 key,NSHTTPCookieName,
                                 
                                 obj,NSHTTPCookieValue,
                                 
                                 nil]];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSError *error;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    id respond = [str1 mj_JSONObject];
    if([respond isSafeDictionary]){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"response :::   %@",respond);

        if (![respond isSafeObj]) {
            return;
        }
        
        if ([[respond[@"error_code"] safeString] isEqualToString:@"0"]) {
            if (seccessBlock) {
                [RequestManager saveRequesHeaderToken:respond];
                seccessBlock(respond[@"data"]);
                
            }
        } else {
            if ([[respond valueForKey:@"logout"] integerValue] == 1) {
                //登出操作
                [self logOut];
            }
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
            
            if(respond[@"data"]) {
                tempDic = respond[@"data"];
            }
            
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            
            if (tempUrl) {
                [info setObject:tempUrl forKey:@"URL"];
            }
            if (respond[@"error_msg"]) {
                [info setObject:respond[@"error_msg"] forKey:NSLocalizedDescriptionKey];
            }
            if (tempDic) {
                [info setObject:tempDic forKey:@"data"];
            }
            if (respond[@"error_code"]) {
                [info setObject:[NSString stringWithFormat:@"%@",respond[@"error_code"]] forKey:@"error_code"];
            }
            
            NSString *domain = @"";
            if (respond[@"error_msg"]) {
                domain = respond[@"error_msg"];
            }
            NSError *error = [[NSError alloc] initWithDomain:domain code:[respond[@"error_code"] integerValue] userInfo:info];
            if (failBlock) {
                NSLog(@"error.userInfo : %@",error.userInfo);
                failBlock(error);
            }
        }

    }
    else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        NSErrorDomain errorDomin = @"";
        if (error.code == NSURLErrorCancelled) {
            errorDomin = @"已取消";
        } else {
            errorDomin = KNONETWORKMSG;
        }
        NSError *errors = [NSError errorWithDomain:errorDomin code:error.code userInfo:nil];
        failBlock(errors);
    }
}



+ (NSDictionary *)bodyAppending:(NSDictionary *)body
{
    NSMutableDictionary *newBody = [[NSMutableDictionary alloc] initWithDictionary:body];
    
    [newBody setValue:@"iphone" forKey:@"f"];
    [newBody setValue:[SMZDMAppInfo shareInstance].CFBundleShortVersionString forKey:@"v"];
 
    [newBody setValue:[NSString convertToTimeStamp:[NSDate date]] forKey:@"time"];

    
    return newBody;
}


+ (NSDictionary *)bodyAppendingAndStr:(NSDictionary *)body andNString:(NSString *)stingSign
{
    NSMutableDictionary *newBody = [[NSMutableDictionary alloc] initWithDictionary:body];
    [newBody setValue:stingSign forKey:@"sign"];
    return newBody;
}

+ (void)setRequestHeater:(AFHTTPSessionManager *)manager
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:RequestHeaderTokenKey];
    if (token.length > 0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"s"];
    }
}

+ (void)saveRequesHeaderToken:(id)responseObject
{
    if ([[responseObject valueForKey:@"logout"] integerValue] == 1) {
        [RequestManager logOut];
    }
}

+ (BOOL)requestSeccessWithResponseState:(NSString *)state
{
    if ([[state safeString] isEqualToString:@"seccess"]) {
        return YES;
    }
    return NO;
}

#pragma mark - cookie
+ (NSMutableDictionary *)returnCookie:(NSString *)method{
    NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
    return properties;
}

#pragma mark- 接口返回登出操作
+ (void)logOut
{

}

+ (BOOL)urlRange:(NSString *)urlString{
    
   
    return NO;
}

//==============================================================================
#pragma mark - handle respond -
//==============================================================================
+ (void)handleSuccess:(id _Nullable)respond sessionDataTask:(NSURLSessionDataTask * _Nonnull)task seccessBlock:(RequestSeccessBlock)seccessBlock failBlock:(RequestFailBlock)failBlock urlString:(NSString *)urlString
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"%@",respond);
    
    if (![respond isSafeObj]) {
        return;
    }
    
    if ([[respond[@"error_code"] safeString] isEqualToString:@"0"]) {
        if (seccessBlock) {
            
            [RequestManager saveRequesHeaderToken:respond];
            if ([RequestManager urlRange:urlString]) {
                seccessBlock(respond);
            } else {
                seccessBlock(respond[@"data"]);
            }
            
        }
    } else {
        if ([[respond valueForKey:@"logout"] integerValue] == 1) {
            //登出操作
            [self logOut];
        }
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        
        if(respond[@"data"]) {
            tempDic = respond[@"data"];
        }
        
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        
        if (task.currentRequest.URL) {
            [info setObject:task.currentRequest.URL forKey:@"URL"];
        }
        if ([respond[@"error_msg"] safeString]) {
            [info setObject:respond[@"error_msg"] forKey:NSLocalizedDescriptionKey];
        }
        if (tempDic) {
            [info setObject:tempDic forKey:@"data"];
        }
        if ([respond[@"error_code"] safeString]) {
            [info setObject:[NSString stringWithFormat:@"%@",respond[@"error_code"]] forKey:@"error_code"];
        }
        
        NSString *domain = @"";
        if (respond[@"error_msg"]) {
            domain = [respond[@"error_msg"] safeString];
        }
        if (![domain isSafeString]) {
            domain = @"请求失败";
        }
        NSInteger code = [[[respond objectForKey:@"error_code"] safeEmptyString] integerValue];
        NSError *error = [[NSError alloc] initWithDomain:domain code:code userInfo:info];
        if (failBlock) {
            NSLog(@"error.userInfo : %@",error.userInfo);
            failBlock(error);
        }
    }
}

+ (void)handleFailed:(NSError * _Nonnull)error sessionDataTask:(NSURLSessionDataTask * _Nonnull)task failBlock:(RequestFailBlock)failBlock timeBlock:(RequestFailBlock)timeBlock
{

    NSLog(@"%s error = %@",__FUNCTION__,error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    if ([[[error.userInfo valueForKey:@"NSLocalizedDescription"] safeString] isEqualToString:@"The request timed out."]||[[[error.userInfo valueForKey:@"NSLocalizedDescription"] safeString] isEqualToString:@"请求超时。"] || (error.code == NSURLErrorTimedOut)) {
        [task cancel];
        if (timeBlock) {
            timeBlock(error);
        }
    } else if (failBlock) {
        NSErrorDomain errorDomin = @"";
        if (error.code == NSURLErrorCancelled) {
            errorDomin = @"已取消";
        } else {
            errorDomin = KNONETWORKMSG;
        }
        
        NSError *errors = [NSError errorWithDomain:errorDomin code:error.code userInfo:nil];
        failBlock(errors);
    }
}

@end
