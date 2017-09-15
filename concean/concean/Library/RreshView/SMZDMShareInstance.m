//
//  SMZDMShareInstance.m
//  SMZDM
//
//  Created by ZhangWenhui on 15/10/6.
//  Copyright © 2015年 smzdm. All rights reserved.
//

#import "SMZDMShareInstance.h"

@interface SMZDMShareInstance ()

@property (nonatomic, strong) NSMutableDictionary *dict_RS_Value;

@property (nonatomic, strong) NSDate *date_RS_Timestamp;

//推荐
@property (nonatomic, strong) NSMutableDictionary *dict_recommendation_Value;
@property (nonatomic, strong) NSDate *date_recommendation_Timestamp;
@property (nonatomic, strong) NSMutableArray *array_RS_Key;

@end

static SMZDMShareInstance *instance;

@implementation SMZDMShareInstance

+ (SMZDMShareInstance *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            @synchronized(self) {
                instance = [SMZDMShareInstance new];
                instance.refreshHeaderView = nil;
                instance.refreshFooterView = nil;
                instance.sessionDataTask = nil;
                instance.dict_article_rs_params = nil;
                instance.circleView = nil;
                instance.dict_RS_Value = nil;
                instance.dict_recommendation_Value = nil;
                instance.date_RS_Timestamp = nil;
                instance.date_recommendation_Timestamp = nil;
                instance.array_UploadSessionManager = nil;
                instance.smzdmOnekeyHaitaoShouldRefresh = NO;
                instance.isBackHomePage = YES;
                instance.dict_UIGeneralIndexCell_isUnfold = @{}.mutableCopy;
            }
        }
    });
    return instance;
}

- (void)setDict_article_rs_params:(NSMutableDictionary *)dict_article_rs_params
{
    if ([dict_article_rs_params isSafeDictionary]) {
        _dict_RS_Value = [NSMutableDictionary dictionaryWithDictionary:dict_article_rs_params];
        _date_RS_Timestamp = [NSDate date];
    }
}

- (void)setGTMPiCiID:(NSString *)GTMPiCiID{
    if ([GTMPiCiID isSafeString]) {
        [[NSUserDefaults standardUserDefaults]setValue:[NSDate date] forKey:@"PCIDDATE"];
        
        [[NSUserDefaults standardUserDefaults]setValue:GTMPiCiID forKey:@"PCIDSTRING"];

    }
}

- (NSMutableDictionary *)dict_article_rs_params
{
//    return @{@"rs_id1": [NSString stringWithFormat:@"%@",@(arc4random() % 10)],
//             @"rs_id2": [NSString stringWithFormat:@"%@",@(arc4random() % 10)],
//             @"rs_id3": [NSString stringWithFormat:@"%@",@(arc4random() % 10)],
//             @"rs_id4": [NSString stringWithFormat:@"%@",@(arc4random() % 10)],
//             @"rs_id5": [NSString stringWithFormat:@"%@",@(arc4random() % 10)],};
//    
//    return @{@"rs_id1": @(arc4random() % 10),
//             @"rs_id2": @(arc4random() % 10),
//             @"rs_id3": @(arc4random() % 10),
//             @"rs_id4": @(arc4random() % 10),
//             @"rs_id5": @(arc4random() % 10),};
    
    if ([_date_RS_Timestamp isSafeObj]) {
        if ([[NSDate date] secondsAfterDate:_date_RS_Timestamp] < 1800) {
            if ([_dict_RS_Value isSafeDictionary]) {
                return _dict_RS_Value;
            }
        }
    }
    
    return nil;
}


- (NSString *)GTMPiCiID
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"PCIDDATE"] isSafeObj]) {
        if ([[NSDate date] secondsAfterDate:[[NSUserDefaults standardUserDefaults] valueForKey:@"PCIDDATE"]] < 1800) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"PCIDSTRING"] isSafeString]) {
                return [[NSUserDefaults standardUserDefaults] valueForKey:@"PCIDSTRING"];
            }
        }
    }
    
    return nil;
}



- (void)setDict_recommendedBack:(NSMutableDictionary *)dict_recommendedBack
{
    if ([dict_recommendedBack isSafeDictionary]) {
        _dict_recommendation_Value = [NSMutableDictionary dictionaryWithDictionary:dict_recommendedBack];
        _date_recommendation_Timestamp = [NSDate date];
        if (!_array_RS_Key) {
            _array_RS_Key = @[@"rs_id1",@"rs_id2",@"rs_id3",@"rs_id4",@"rs_id5"].mutableCopy;
        }
        
        NSMutableDictionary *dictRSValue = @{}.mutableCopy;
        for (NSInteger i = 0; i < _array_RS_Key.count; i++) {
            NSString *rsKey = _array_RS_Key[i];
            if ([[_dict_recommendation_Value objectForKey:rsKey] isSafeString]) {
                [dictRSValue setObject:[_dict_recommendation_Value objectForKey:rsKey] forKey:rsKey];
            }
        }
        
        if ([dictRSValue dictionaryHasData]) {
            self.dict_article_rs_params = dictRSValue;
        }
    }
}

- (NSMutableDictionary *)dict_recommendedBack
{
    if ([_date_recommendation_Timestamp isSafeObj]) {
        if ([[NSDate date] secondsAfterDate:_date_recommendation_Timestamp] < 1800) {
            if ([_dict_recommendation_Value isSafeDictionary]) {
                return _dict_recommendation_Value;
            }
        }
    }
    
    return nil;
}

- (void)sm_initArrayUploadSession
{
    if (!_array_UploadSessionManager) {
        _array_UploadSessionManager = [NSMutableArray array];
    } else {
        [_array_UploadSessionManager removeAllObjects];
    }
}

- (void)sm_destroyUploadSession
{
    if (_array_UploadSessionManager) {
        
        if (_array_UploadSessionManager.count) {
            
            for (NSInteger i = 0; i < _array_UploadSessionManager.count; i++) {
                NSURLSessionDataTask *sessionDataTask = _array_UploadSessionManager[i];
                [sessionDataTask cancel];
            }
            
            [_array_UploadSessionManager removeAllObjects];
        }
        
        _array_UploadSessionManager = nil;
    }
}
//feng
- (void)sm_destroyUploadSessionWithArray
{
    if (_array_UploadSessionManager) {
        
        if (_array_UploadSessionManager.count) {
            
            for (NSInteger i = 0; i < _array_UploadSessionManager.count; i++) {
                NSURLSessionDataTask *sessionDataTask = _array_UploadSessionManager[i];
                [sessionDataTask cancel];
            }
            
            [_array_UploadSessionManager removeAllObjects];
        }
        
    }

}

@end
