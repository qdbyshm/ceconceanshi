//
//  UIAlertShow.m
//  UINavigationDemo
//
//  Created by ZhangWenhui on 15/4/27.
//  Copyright (c) 2015年 张文辉. All rights reserved.
//

#import "UIAlertShow.h"

#define kSECONDS_IN_A_DAY 86400.0
#define kAppStoreURL    @"https://itunes.apple.com/app/id"

@interface UIAlertShow () <UIAlertViewDelegate>
{
    //是否处在show状态
    BOOL _isShowing;
}

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
//稍后提醒间隔(天)
@property (assign, nonatomic) NSInteger delayRemind;
//是否提醒
@property (assign, nonatomic) BOOL isRemind;
@property (strong, nonatomic) NSMutableDictionary *data;

@end

//版本号
#define kAppVersion @"appVersion"
//是否已经打分提醒
#define kMakeScore @"makeScore"
//打分时间
#define kMakeScoreDate  @"makeScoreDate"
//最后一次取消提醒时间
#define kLastCancleDate @"lastCancleDate"
//延迟提醒次数
#define kDelayTimes @"delayTimes"
//下次提醒时间
#define kRemindTime @"remindTime"
//忽略这个版本（不再提示）
#define kIgnoreThisVersion  @"ignoreThisVersion"


//打分提示选项字符串
#define kEncourage          @"去鼓励"
#define kLaterEvaluation    @"稍后评价"
#define kNoLongerPrompt     @"不再提示"

@implementation UIAlertShow

//==============================================================================
#pragma mark - 初始化方法 -
//==============================================================================
- (instancetype)init
{
    return [self initWithAlertShowType:UIAlertShowTypeMakeScore];
}
- (instancetype)initWithAlertShowType:(UIAlertShowType)showType
{
    self = [super init];
    if (self) {
        [self initDefaultParams:showType];
    }
    return self;
}

- (void)initDefaultParams:(UIAlertShowType)shwoType
{
    _isShowing = NO;
    _delayRemind = 1;
    if (!_dateFormatter) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    self.alertShowType = shwoType;
}

- (void)setRemindInfo
{
    switch (_alertShowType) {
        case UIAlertShowTypeDefault: {
            _isRemind = NO;
            break;
        }
        case UIAlertShowTypeMakeScore: {
            _data = [[NSMutableDictionary alloc] initWithContentsOfFile:[self localPath]];
            if (_data == nil) {
                _data = [NSMutableDictionary dictionary];
            }
            if ([[_data objectForKey:kAppVersion] isEqualToString:[self appVersion]]) {//如果版本号相同
                if ([[_data objectForKey:kMakeScore] isEqualToString:@"1"]) {//此版本已经打分评论过
                    _isRemind = NO;
                } else if ([[_data objectForKey:kIgnoreThisVersion] isEqualToString:@"1"]) {//如果忽略此版本提醒
                    _isRemind = [self dateCompare];
                } else {//没有忽略此版本提醒、没有打分评论
                    _isRemind = [self dateCompare];
                }
            } else {//版本号不同：首次打开 APP 3天后，第一次提醒
                _isRemind = NO;
                if (_data && ![[_data objectForKey:kAppVersion] isEqualToString:[self appVersion]]) {
                    [self removeFiles:[self localPath]];
                    _data = nil;
                    _data = [[NSMutableDictionary alloc] initWithContentsOfFile:[self localPath]];
                    if (_data == nil) {
                        _data = [NSMutableDictionary dictionary];
                    }
                }
                //版本号
                [_data setObject:[self appVersion] forKey:kAppVersion];
                //提醒日期
                [_data setObject:[_dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:kSECONDS_IN_A_DAY * 2]] forKey:kRemindTime];
                //是否已经打分
                [_data setObject:@"0" forKey:kMakeScore];
                //打分日期
                [_data setObject:@"" forKey:kMakeScoreDate];
                //最后一次取消提醒时间
                [_data setObject:@"" forKey:kLastCancleDate];
                //延迟提醒次数
                [_data setObject:@"0" forKey:kDelayTimes];
                //忽略这个版本（不再提示）
                [_data setObject:@"0" forKey:kIgnoreThisVersion];
                BOOL wirteSuccess = [_data writeToFile:[self localPath] atomically:YES];
                if (wirteSuccess) {
                    NSLog(@"已保存");
                }
            }
            break;
        }
        default: {
            break;
        }
    }
}

//==============================================================================
#pragma mark - set / get methods -
//==============================================================================
- (void)setAlertShowType:(UIAlertShowType)alertShowType
{
    _alertShowType = alertShowType;
    
    [self setRemindInfo];
}

//==============================================================================
#pragma mark - 提示框 -
//==============================================================================
- (void)showAlertView:(NSString *)valueString, ...
{
    va_list varlist;
    
    NSMutableArray *aArray = [NSMutableArray array];
    [aArray addSafeObject:valueString];
    
    if (!valueString) {
        return;
    }
    
    NSString *eachObject = nil;
    va_start(varlist, valueString);
    while ((eachObject = va_arg(varlist, NSString *))) {
        [aArray addSafeObject:eachObject];
    }
    va_end(varlist);
    
    self.alertView = [[UIAlertView alloc] initWithTitle:[self getValueString:[aArray objectAtSafeIndex:0]]
                                                message:[self getValueString:[aArray objectAtSafeIndex:1]]
                                               delegate:self
                                      cancelButtonTitle:[self getValueString:[aArray objectAtSafeIndex:2]]
                                      otherButtonTitles:[self getValueString:[aArray objectAtSafeIndex:3]], nil];
    _alertView.delegate = self;
    for (NSInteger i = 4; i < aArray.count; i++) {
        [_alertView addButtonWithTitle:[self getValueString:[aArray objectAtSafeIndex:i]]];
    }
    [_alertView show];
}

//==============================================================================
#pragma mark - 显示打分提示框 -
//==============================================================================
- (void)showMakeScoreAlert
{
    if (_alertShowType == UIAlertShowTypeMakeScore) {
        self.alertShowType = UIAlertShowTypeMakeScore;
        if (_isRemind) {
            if (!_isShowing) {
                if (_alertView.visible) {
                    return;
                }
                _isShowing = YES;
                [self performSelector:@selector(toShowAfterDelay) withObject:nil afterDelay:3];
            }
        }
    }
}

- (void)toShowAfterDelay
{
    if (_alertView.visible) {
        return;
    }
    [self showAlertView:@"给 什么值得买 打分",@"喜欢新版什么值得买吗？那就打分鼓励下吧！",kNoLongerPrompt,kEncourage,kLaterEvaluation,nil];
}

- (NSString *)getValueString:(NSString *)aString
{
    NSString *valueString = nil;
    
    if ([aString trim].length) {
        valueString = [aString trim];
    }
    
    return valueString;
}

//==============================================================================
#pragma mark - UIAlertViewDelegate -
//==============================================================================
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (_alertShowType) {
        case UIAlertShowTypeDefault: {
            if (_btnClicked) {
                _btnClicked (MakeScoreOptionsTypeDefault, buttonIndex);
            }
            break;
        }
        case UIAlertShowTypeMakeScore: {//打分
            _isShowing = NO;
            NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
            if ([title isEqualToString:kEncourage]) {//鼓励
                self.optionsType = MakeScoreOptionsTypeEncourage;
            } else if ([title isEqualToString:kLaterEvaluation]) {//稍后评价
                self.optionsType = MakeScoreOptionsTypeLaterEvaluation;
            } else if ([title isEqualToString:kNoLongerPrompt]) {//不再提示
                self.optionsType = MakeScoreOptionsTypeNoLongerPrompt;
            }
            switch (_optionsType) {
                case MakeScoreOptionsTypeEncourage: {//去鼓励
                    NSInteger delatTimes = [[_data objectForKey:kDelayTimes] integerValue];
                    NSString * kTimes = [NSString stringWithFormat:@"%@_去评价",[self GTM_Change:delatTimes]];

                    [_data setObject:@"1" forKey:kMakeScore];
                    [_data setObject:[_dateFormatter stringFromDate:[NSDate date]] forKey:kMakeScoreDate];
                    [_data setObject:@"" forKey:kLastCancleDate];
                    BOOL writeSuccess = [_data writeToFile:[self localPath] atomically:YES];
                    if (writeSuccess) {
                        NSLog(@"已保存");
                    }
                    
                    NSMutableString *stringURL = [NSMutableString string];
                    [stringURL appendString:kAppStoreURL];
                    [stringURL appendString:_s_appleID];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringURL]];
                    break;
                }
                case MakeScoreOptionsTypeLaterEvaluation: {//稍后评价
                    [_data setObject:@"0" forKey:kMakeScore];
                    [_data setObject:@"" forKey:kMakeScoreDate];
                    [_data setObject:[_dateFormatter stringFromDate:[NSDate date]] forKey:kLastCancleDate];
                    NSInteger delatTimes = [[_data objectForKey:kDelayTimes] integerValue];
                    NSString * kTimes = [NSString stringWithFormat:@"%@_稍后",[self GTM_Change:delatTimes]];
                    switch (delatTimes) {
                        case 0:
                        {
                            _delayRemind = 6;//延迟七天
                            break;
                        }
                        case 1:
                        {
                            _delayRemind = 29;//延迟30天
                            break;
                        }
                        case 2:
                        {
                            _delayRemind = 59;//延迟60天
                            break;
                        }
                            
                        default:
                        {
                            _delayRemind = 59;//延迟60天
                            break;
                        }
                    }
                    NSString *delayTime = [NSString stringWithFormat:@"%ld",delatTimes + 1];
                    [_data setObject:delayTime forKey:kDelayTimes];
                    NSDate *remindDate = [NSDate dateWithTimeIntervalSinceNow:_delayRemind * kSECONDS_IN_A_DAY];
                    [_data setObject:[_dateFormatter stringFromDate:remindDate] forKey:kRemindTime];
                    BOOL writeSuccess = [_data writeToFile:[self localPath] atomically:YES];
                    if (writeSuccess) {
                        NSLog(@"已保存");
                    }
                    break;
                }
                case MakeScoreOptionsTypeNoLongerPrompt: {//不再提示
                    NSInteger delatTimes = [[_data objectForKey:kDelayTimes] integerValue];
                    NSString * kTimes = [NSString stringWithFormat:@"%@_关闭",[self GTM_Change:delatTimes]];
                    [_data setObject:@"1" forKey:kIgnoreThisVersion];
                    _delayRemind = 59;//延迟60天提醒
                    NSDate *remindDate = [NSDate dateWithTimeIntervalSinceNow:_delayRemind * kSECONDS_IN_A_DAY];
                    [_data setObject:[_dateFormatter stringFromDate:remindDate] forKey:kRemindTime];
                    BOOL writeSuccess = [_data writeToFile:[self localPath] atomically:YES];
                    if (writeSuccess) {
                        NSLog(@"已保存");
                    }
                    break;
                }
                default: {
                    break;
                }
            }
            if (_btnClicked) {
                _btnClicked (_optionsType, buttonIndex);
            }
            break;
        }
        default: {
            break;
        }
    }
}
//#43574 统计第几天浮层
- (NSString *)GTM_Change:(NSInteger)num
{
    NSString * day = @"";
    if (num==0) {
        day = @"第3天";

    }else if (num==1)
    {
        day = @"第10天";

    }else if (num==2)
    {
        day = @"第40天";

    }else if (num>2)
    {
        
        day = [NSString stringWithFormat:@"第%d天",40+60*(num-2)] ;
    }
    
    return day;
}
- (BOOL)dateCompare
{
    //当前日期与提醒日期相比较
    NSComparisonResult comparisonResult = [[_dateFormatter dateFromString:[_dateFormatter stringFromDate:[NSDate date]]] compare:[_dateFormatter dateFromString:[_data objectForKey:kRemindTime]]];
    switch (comparisonResult) {
        case NSOrderedAscending: {//升序
            return NO;
            break;
        }
        case NSOrderedSame://相等
        case NSOrderedDescending: {//降序
            return YES;
            break;
        }
        default: {
            return NO;
            break;
        }
    }
}

#define kMakeScoreInfo   @"userMakeScore.plist"
- (NSString *)GetDocumentPath
{
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    return path;
}

- (NSString *)GetPathForDocuments:(NSString *)filename
{
    return [[self GetDocumentPath] stringByAppendingPathComponent:filename];
}

- (NSString *)localPath
{
    return [self GetPathForDocuments:kMakeScoreInfo];
}

- (BOOL)filesIsExist:(NSString *)filesName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filesName];
}

- (void)removeFiles:(NSString *)filesName
{
    NSError *error = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([self filesIsExist:filesName]) {
        BOOL removeSuccess = [fileManager removeItemAtPath:filesName error:&error];
        
        if (removeSuccess) {
            NSLog(@"删除成功");
        }
        
        if (error) {
            NSLog(@"%@",error.userInfo);
        }
    }
}

- (NSString *)appVersion
{
    return [SMZDMAppInfo shareInstance].CFBundleShortVersionString;
}

@end



@implementation NSString (SafeMethos)

/**
 * @brief  判断字符串是否合法
 *
 * @return YES - 合法 NO － 不合法
 */
- (BOOL)isLegalString
{
    BOOL isLegal = NO;
    if ([self isKindOfClass:[NSString class]]) {
        if (![self isKindOfClass:[NSNull class]] && self && ![self isEqualToString:@"(null)"] && ![self isEqualToString:@""]&& ![self isEqualToString:@"null"] && self.length) {
            isLegal = YES;
        } else {
            isLegal = NO;
        }
    } else {
        isLegal = NO;
    }
    return isLegal;
}

/*!
 * @return 若字符串非法，则返回@""
 */
- (NSString *)legalString
{
    if ([self isLegalString]) {
        return self;
    } else {
        return @"";
    }
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

@implementation NSArray (SafeMethos)

- (id)objectAtSafeIndex:(NSUInteger)index
{
    if (self) {
        if (index >= self.count) {
            //NSLog(@"数组越界%lu-%lu",(unsigned long)index,(unsigned long)self.count);
            return nil;
        }
    } else {
        //NSLog(@"数组为空");
        return nil;
    }
    
    return [self objectAtIndex:index];
}

@end

@implementation NSMutableArray (SafeMethod)

- (void)addSafeObject:(id)anObject
{
    if ([anObject isKindOfClass:[NSString class]]) {
        [self addObject:[anObject legalString]];
    } else {
        if (anObject) {
            [self addObject:anObject];
        } else {
            //NSLog(@"添加空值!!!");
            //[self addObject:@""];
        }
    }
}
//feng
- (void)addSafeObjectOfNavigationVC:(id)anObject
{
    if ([anObject isKindOfClass:[NSString class]]) {
        [self addObject:[anObject legalString]];
    } else {
        if (anObject) {
            [self addObject:anObject];
        } else {
            //NSLog(@"添加空值!!!");
            [self addObject:[NavigationBarViewController new]];
        }
    }
}
- (void)removeObjectAtSafeIndex:(NSUInteger)index
{
    if (!self.count) {
        return;
    }
    if (index >= self.count) {
        return;
    }
    [self removeObjectAtIndex:index];
}

@end
