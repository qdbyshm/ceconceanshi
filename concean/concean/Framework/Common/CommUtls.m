//
//  CommUtls.m
//  UtlBox
//
//  Created by cdel cyx on 12-7-10.
//  Copyright (c) 2012年 cdeledu. All rights reserved.
//

#import "CommUtls.h"

#import  <dlfcn.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#import  <CommonCrypto/CommonCryptor.h>
#import  <SystemConfiguration/SystemConfiguration.h>
#import "RegexKitLite.h"
#include <sys/xattr.h>
#import <QuartzCore/QuartzCore.h>
#import <sys/utsname.h>
#import "SBJsonParser.h"
#import "LXF_OpenUDID.h"


@implementation CommUtls

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (BOOL)checkNumberP:(NSString *) telNumber
{
    if ([telNumber isEqualToString:@"."]) {
        return YES;
    }
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;

}

+(NSString *)getOpenUdid
{
    NSString *openUDID = [LXF_OpenUDID value];
    if (openUDID) {
        return openUDID;
    }
    return @"";
}

+(BOOL)IsChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}
+ (NSString *)getDicHttps:(NSString *)strKey;
{
    
    NSString *filePath=[NSString stringWithFormat:@"%@/%@.plist",MAINDBPATH,@"Peizhi"];
    NSDictionary * dic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    if (dic) {
        return [dic valueForKey:strKey];
    } else {
        return nil;
    }
}
+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr WithStr:(NSString *)stre{
    if (originHtmlStr.length<1) {
        return @"";
    }
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:stre];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange range;
        range.location = arrowTagStartRange.location;
        result = [originHtmlStr substringFromIndex:range.location+1];
        return [self filterHtmlTag:result WithStr:stre];    //递归，过滤下一个标签
    }else{
        return originHtmlStr;  // 过滤&nbsp等标签
    }
}




- (void)getTIshi
{
    UIView *mainView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mainView1.userInteractionEnabled = YES;
    mainView1.tag = 1010;
    mainView1.backgroundColor = [UIColor clearColor];
    [mainView1 setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:mainView1];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT-44, 40, 44);
    //    button.center = CGPointMake(button.center.x, field.center.y);
    [button setImage:[UIImage imageNamed:@"ic_back_s"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ic_back_pressed_s"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backPre) forControlEvents:UIControlEventTouchUpInside];
    [mainView1 addSubview:button];
    
    
    UCHudV *customHud1 = [[UCHudV alloc]initWithFrame:CGRectMake(0, 0, 100, 100) withView:[UIApplication sharedApplication].keyWindow];
    customHud1.tag = 1011;
    customHud1.titLabel.text= @"加载中...";
    [[UIApplication sharedApplication].keyWindow addSubview:customHud1];
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(void)backPre
{
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:1010]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1010] removeFromSuperview];
    }
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:1011]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1011] removeFromSuperview];
    }
}

+(void)backVRemove
{
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:1010]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1010] removeFromSuperview];
    }
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:1011]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1011] removeFromSuperview];
    }
}


+(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}


+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
    }
}


+(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}





+ (NSString *)appleId
{
    return @"518213356";
}

+(NSString *)getStyleStr
{
    NSString *styleStr = @"0";
    if ([CommUtls isWiFiNet]) {
        styleStr = @"0";
    }else
    {
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:IMG_MODE]) {
            case IMG_NULL:
                styleStr = @"2";
                break;
            case IMG_THUMBNAILS:
                styleStr = @"1";
                break;
            case IMG_HD:
                styleStr = @"0";
                break;
            default:
                break;
        }     }
    return styleStr;
}

+ (NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return deviceString;
}

+ (NSURL *)getURLFromString:(NSString *)str
{
    NSURL *url =[[NSURL alloc]initWithString:[[self checkNullValueForString:str] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    return url;
}

+ (BOOL )getArrayBool:(id)array
{
    return [array arrayHasData];
}

/**
 *	@brief	判断文件路径是否存在
 *
 *	@param 	fullPathName 	文件完整路径
 *
 *	@return	返回是否存在
 */
+ (BOOL)fileExists:(NSString *)fullPathName
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:fullPathName];
}

/**
 *	@brief	删除文件
 *
 *	@param 	fullPathName 	文件完整路径
 *
 *	@return	是否删除成功
 */
+ (BOOL)remove:(NSString *)fullPathName
{
    NSError *error = nil;
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:fullPathName]) {
        [file_manager removeItemAtPath:fullPathName error:&error];
    }
    if (error) {
        return NO;
    }
    return YES;
}

/**
 *	@brief	创建文件夹
 *
 *	@param 	dir 	文件夹名字
 */
+ (void)makeDirs:(NSString *)dir
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    [file_manager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
}

/**
 *	@brief	判断Document文件路径是否存在
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回是否存在文件路径
 */
+ (BOOL)fileExistInDocumentPath:(NSString*)fileName

{
	if(fileName == nil)
		return NO;
	NSString* documentsPath = [self documentPath:fileName];
	return [[NSFileManager defaultManager] fileExistsAtPath: documentsPath];
}

/**
 *	@brief	通过文件名，获取Document完整路径，如果不存在返回为nil
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回完整路径
 */
+ (NSString*)documentPath:(NSString*)fileName

{
	if(fileName == nil)
		return nil;
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString* documentsDirectory = [paths objectAtIndex: 0];
	NSString* documentsPath = [documentsDirectory stringByAppendingPathComponent: fileName];
	return documentsPath;
}

/**
 *	@brief	删除Document文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	是否成功删除
 */
+ (BOOL)deleteDocumentFile:(NSString*)fileName

{
    BOOL del = NO;
	if(fileName == nil)
		return del;
	NSString* documentsPath = [self documentPath:fileName];
	if( [[NSFileManager defaultManager] fileExistsAtPath: documentsPath])
	{
		
		del = [[NSFileManager defaultManager] removeItemAtPath: documentsPath error:nil];
	}
	return del;
}

/**
 *	@brief	判断Cache是否存在
 *
 *	@param 	fileName 	文件名
 *
 *	@return	是否存在文件
 */
+ (BOOL)fileExistInCachesPath:(NSString*)fileName

{
	if(fileName == nil)
		return NO;
	NSString* cachesPath = [self cachesFilePath:fileName];
	return [[NSFileManager defaultManager] fileExistsAtPath: cachesPath];
}

/**
 *	@brief	通过文件名返回完整的Caches目录下的路径，如果不存在该路径返回nil
 *
 *	@param 	fileName 	文件名
 *
 *	@return	返回Caches完整路径
 */
+ (NSString* )cachesFilePath:(NSString*)fileName
{
	if(fileName == nil)
		return nil;
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString* cachesdirectory = [paths objectAtIndex: 0];
	NSString* cachesPath = [cachesdirectory stringByAppendingPathComponent:fileName];
	return cachesPath;
}

/**
 *	@brief	删除Caches文件
 *
 *	@param 	fileName 	文件名
 *
 *	@return	删除是否成功
 */
+ (BOOL)deleteCachesFile:(NSString*)fileName

{
    BOOL del = NO;
	if(fileName == nil)
		return del;
	NSString* cachesPath = [self cachesFilePath:fileName];
	if( [[NSFileManager defaultManager] fileExistsAtPath: cachesPath])
	{
		del = [[NSFileManager defaultManager] removeItemAtPath: cachesPath error:nil];
	}
	return del;
}

/**
 *	@brief	格式化时间为字符串
 *
 *	@param 	date 	NSDate系统时间类型
 *
 *	@return	返回默认格式yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)encodeTime:(NSDate *)date

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
}

/**
 *	@brief	字符串格式化为时间格式
 *
 *	@param 	dateString 	默认格式yyyy-MM-dd HH:mm:ss
 *
 *	@return	返回时间格式
 */
+ (NSDate *)dencodeTime:(NSString *)dateString

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
    
}

+ (NSString *)convertDateFromCST:(NSString *)_date
{
    if (_date == nil) {
        return nil;
    }
    //return nil;
    NSLog(@"_date==%@",_date);
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"EEE MMM dd HH:mm:ss 'CST' yyyy"];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    
    NSDate *formatterDate = [inputFormatter dateFromString:_date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    NSLog(@"newDateString==%@",newDateString);
    return newDateString;
}

/**
 *	@brief	离现在时间相差时间
 *
 *	@param 	date 	时间格式
 *
 *	@return	返回字符串
 */
+ (NSString *)timeSinceNow:(NSDate *)date

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeInterval interval = 0 - [date timeIntervalSinceNow];
        
        /*
         if (interval < 60) {
         // 几秒前
         return @"1分钟内";
         } else if (interval < (60 * 60)) {
         // 几分钟前
         return [NSString stringWithFormat:@"%u分钟前", (int)(interval / 60)];
         } else if (interval < (24 * 60 * 60)) {
         // 几小时前
         return [NSString stringWithFormat:@"%u小时前", (int)(interval / 60 / 60)];
         } else if (interval < (2 * 24 * 60 * 60)) {
         // 昨天
         [formatter setDateFormat:@"昨天 HH:mm"];
         return [formatter stringFromDate:date];
         } else if (interval < (3 * 24 * 60 * 60)) {
         // 前天
         [formatter setDateFormat:@"前天 HH:mm"];
         return [formatter stringFromDate:date];
         //    } else if (interval < (7 * 24 * 60 * 60)) {
         // 一星期内
         } else {
         // 具体时间
         [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
         return [formatter stringFromDate:date];
         }
         
         */
        
        if (interval < 60) {
            // 几秒前
            return @"1分钟内";
        } else if (interval < (60 * 60)) {
            // 几分钟前
            return [NSString stringWithFormat:@"%u分钟前", (int)(interval / 60)];
        } else if (interval < (24 * 60 * 60)) {
            // 几小时前
            return [NSString stringWithFormat:@"%u小时前", (int)(interval / 60 / 60)];
        } else if (interval < (2 * 24 * 60 * 60)) {
            // 昨天
            [formatter setDateFormat:@"昨天"];
            return [formatter stringFromDate:date];
        } else if (interval < (3 * 24 * 60 * 60)) {
            // 前天
            [formatter setDateFormat:@"前天"];
            return [formatter stringFromDate:date];
            //    } else if (interval < (7 * 24 * 60 * 60)) {
            // 一星期内
        } else {
            // 具体时间
            NSInteger days = interval / (24 * 60 * 60);
            
            return [NSString stringWithFormat:@"%d天前",(int)days];
        }
        
        
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
}

/**
 *	@brief	把秒转化为时间字符串显示，播放器常用
 *
 *	@param 	durartion 	传入参数
 *
 *	@return	播放器播放进度时间，比如
 */
+ (NSString *)changeSecondsToString:(CGFloat)durartion
{
    int hh = durartion/(60 * 60);
    int mm = hh > 0 ? (durartion - 60*60)/60 : durartion/60;
    int ss = (int)durartion%60;
    NSString *hhStr,*mmStr,*ssStr;
    if (hh == 0) {
        hhStr = @"00";
    }else if (hh > 0 && hh < 10) {
        hhStr = [NSString stringWithFormat:@"0%d",hh];
    }else {
        hhStr = [NSString stringWithFormat:@"%d",hh];
    }
    if (mm == 0) {
        mmStr = @"00";
    }else if (mm > 0 && mm < 10) {
        mmStr = [NSString stringWithFormat:@"0%d",mm];
    }else {
        mmStr = [NSString stringWithFormat:@"%d",mm];
    }
    if (ss == 0) {
        ssStr = @"00";
    }else if (ss > 0 && ss < 10) {
        ssStr = [NSString stringWithFormat:@"0%d",ss];
    }else {
        ssStr = [NSString stringWithFormat:@"%d",ss];
    }
    return [NSString stringWithFormat:@"%@:%@:%@",hhStr,mmStr,ssStr];
}


/**
 *	@brief	格式化时间为字符串
 *
 *	@param 	date 	时间
 *	@param 	format 	格式化字符串
 *
 *	@return	返回时间字符串
 */
+ (NSString *)encodeTime:(NSDate *)date format:(NSString *)format

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
    }
    
}

/**
 *	@brief  格式化成时间格式
 *
 *	@param 	dateString 	时间字符串
 *	@param 	format 	格式化字符串
 *
 *	@return	返回时间格式
 */
+ (NSDate *)dencodeTime:(NSString *)dateString format:(NSString *)format

{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
    
}

/**
 *	@brief	跳转到APPSTORE软件下载页面
 *
 *	@param 	appid 	APPID
 */
+ (void)goToAppStoreHomePage:(NSInteger)appid
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%ld?mt=8", (long)appid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

/**
 *	@brief	跳转到APPSTORE软件评论页面
 *
 *	@param 	appid 	APPID
 */
+ (void)goToAppStoreCommentPage:(NSInteger)appid
{
    NSString *str;
    if([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)
    {
        str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%ld?mt=8",(long)appid];
    }
    else
    {
        str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%ld",(long)appid];
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/**
 *	@brief	发短信
 *
 *	@param 	phoneNumber 	手机号码
 */
+ (void)goToSmsPage:(NSString*)phoneNumber

{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phoneNumber]]];
}

/**
 *	@brief	打开网页
 *
 *	@param 	url 	网页地址
 */
+ (void)openBrowse:(NSString*)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

/**
 *	@brief	发送邮件
 *
 *	@param 	email 	email地址
 */
+ (void)openEmail:(NSString*)email;

{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",email]]];
}

+ (CGFloat)freeDiskSpace
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [paths objectAtIndex:0];
    NSDictionary *fileAttr = [[NSFileManager defaultManager] attributesOfFileSystemForPath:cachePath error:nil];
    float freeSpace = [[fileAttr objectForKey:NSFileSystemFreeSize] floatValue];
    return freeSpace;
    
}


/**
 *	@brief	通过字节获取文件大小
 *
 *	@param 	number 	字节数
 *
 *	@return	返回大小
 */
+ (NSString*)getSize:(NSNumber*)number

{
    NSInteger size=[number intValue];
    if(size<1024)
        return [NSString stringWithFormat:@"%ldB", (long)size];
    else
    {
        int size1=(int)size/1024;
        if(size1<1024)
        {
            return [NSString stringWithFormat:@"%u.%ldKB", size1,(size-size1*1024)/10];
        }
        else
        {
            int size2=size1/1024;
            if(size2<1024)
                return [NSString stringWithFormat:@"%u.%uMB", size2,(size1-size2*1024)/10];
        }
    }
    return nil;
}

/**
 *	@brief	获取随即数
 *
 *	@param 	min 	最小数值
 *	@param 	max 	最大数值
 *
 *	@return	返回数值
 */
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max
{
    NSInteger value=0;
    if(min>0)
        value= (arc4random() % (max-min+1)) + min;
    else
        value= arc4random() % max;
    return value;
}

/**
 *	@brief	获取颜色
 *
 *	@param 	stringToConvert 	取色数值
 *
 *	@return	返回颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    
    return [self colorWithHexString:stringToConvert alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

/**
 *	@brief	mac地址
 *
 *	@return	返回地址
 */
+ (NSString *)macAddress

{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        free(msgBuffer);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}
+(NSString *)macIP
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
/**
 *	@brief	转换字符串编码
 *
 *	@param 	s 	字符串
 *
 *	@return	返回UTF-8的编码
 */
+ (NSString *)encode:(NSString *)s {
    return  [s stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
}

/**
 *	@brief	检查是否可用网络
 *
 *	@return	返回是否可用
 */
+ (BOOL)checkConnectNet
{
    Reachability *wifiReach = [Reachability reachabilityForLocalWiFi];
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    return ([wifiReach isReachable] || [internetReach isReachable]);
}

// 是否是wifi
+(BOOL)isWiFiNet
{
    return ((AppDelegate*)[UIApplication sharedApplication].delegate)->wifiNet;
}

+ (NetworkStatus)checkNetworkType
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    return [reach currentReachabilityStatus];
}
/**
 *	@brief	推送状态栏消息
 *
 *	@param 	message 	消息
 *	@param 	time 	延迟时间
 */
+ (void)addStatusMessage:(NSString*)message afterTime:(CGFloat)time;
{
    
    [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelStatusBar];
    [[UIApplication sharedApplication].keyWindow setFrame:CGRectMake(0, 20, 320, 460)];
    for(UIView* view in [[UIApplication sharedApplication].keyWindow  subviews])
    {
        if(view.tag==1000)
        {
            [view removeFromSuperview];
        }
    }
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
    [signLabel setBackgroundColor:[UIColor blackColor]];
    [signLabel setText:message];
    [signLabel setTextColor:[UIColor whiteColor]];
    [signLabel setTextAlignment:NSTextAlignmentCenter];
    [signLabel setFont:[UIFont systemFontOfSize:13]];
    [signLabel setTag:1000];
    [[UIApplication sharedApplication].keyWindow addSubview:signLabel];
    
    // Label进入动画
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromBottom;
    [[signLabel layer] addAnimation:animation forKey:@"animation"];
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(removeStatusMessage)
                                   userInfo:nil
                                    repeats:NO];
}

/**
 *	@brief	消除状态栏消息
 */
+ (void)removeStatusMessage

{
    for(UIView* view in [[UIApplication sharedApplication].keyWindow  subviews])
    {
        if(view.tag==1000)
        {
            [view removeFromSuperview];
        }
    }
}



/**
 * @brief 图片压缩
 *  UIGraphicsGetImageFromCurrentImageContext函数完成图片存储大小的压缩
 * Detailed
 * @param[in] 源图片；指定的压缩size
 * @param[out] N/A
 * @return 压缩后的图片
 * @note
 */
+ (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize {
	
	CGFloat scale;
	CGSize newsize = image.size;
	if (newsize.height && (newsize.height > viewsize.height)) {
		scale = viewsize.height/newsize.height;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	if (newsize.width && (newsize.width >= viewsize.width)) {
		scale = viewsize.width /newsize.width;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	UIGraphicsBeginImageContext(viewsize);
	
	float dwidth = (viewsize.width - newsize.width)/2.0f;
	float dheight = (viewsize.height - newsize.height)/2.0f;
	
	CGRect rect = CGRectMake(dwidth, dheight, newsize.width, newsize.height);
    [image drawInRect:rect];
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

+ (NSString *)systemTime:(NSString *)format {
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init] ;
    NSDate *date = [NSDate date];
    [[NSDate date] timeIntervalSince1970];
    [formatter setDateFormat:format];
    NSString *returnTime = [formatter stringFromDate:date];
    return returnTime;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (NSString *)specialCharForXML:(NSString *)str
{
    if(str!= nil)
    {
        str = [str stringByReplacingOccurrencesOfRegex:@"&lt;" withString:@"<"];
        str = [str stringByReplacingOccurrencesOfRegex:@"&gt;" withString:@">"];
        str = [str stringByReplacingOccurrencesOfRegex:@"&amp;" withString:@"&"];
        str = [str stringByReplacingOccurrencesOfRegex:@"&apos;" withString:@"'"];
        str = [str stringByReplacingOccurrencesOfRegex:@"&quot;" withString:@"\""];
        str = [str stringByReplacingOccurrencesOfRegex:@"&nbsp;" withString:@" "];
        
    }
    return str;
}

+ (CATransition *)creatAnmitionFrom:(NSInteger)direction{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.type = kCATransitionPush;
    if (direction == 0) {
        animation.subtype = kCATransitionFromBottom;
    }else{
        animation.subtype = kCATransitionFromTop;
    }
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    return animation;
}

+ (CATransition *)creatAnmitionHorizontalFrom:(NSInteger)direction{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.type = kCATransitionPush;
    if (direction == 0) {
        animation.subtype = kCATransitionFromRight;
    }else{
        animation.subtype = kCATransitionFromLeft;
    }
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    return animation;
}

+ (CATransition *)creatAnmitionDisplayScreenView:(NSInteger)direction{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    if (direction == 0) {
        animation.type = kCATransitionFade;
    }else{
        animation.type = @"rippleEffect";
    }
    
    return animation;
}


+ (UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)getRandomColor
{
    return [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
}

/*0--1 : lerp( float percent, float x, float y ){ return x + ( percent * ( y - x ) ); };*/
+ (float)lerp:(float)percent min:(float)nMin max:(float)nMax
{
    float result = nMin;
    
    result = nMin + percent * (nMax - nMin);
    
    return result;
}

// 检测是否是数组
+(BOOL)correctData:(id)responder
{
    return ([responder isKindOfClass:[NSDictionary class]]);
}

/*
 判断JSon解析出来的Object是否为NSNull类型
 输入参数：需要判断的Object
 输出参数：返回一个经过格式化的NSString类型
 */
+(NSString *)checkNullValueForString:(id)object
{
	if([object isKindOfClass:[NSNull class]])
	{
		return @"";
	}
	else if(!object)
	{
		return @"";// (NSString *)object;
	}
    else if([object isEqual:@"<null>"])
    {
        return @"";// (NSString *)object;
        
    }
    else
	{
        if ([object isKindOfClass:[NSString class]]) {
            if ([object length] > 0) {
                return [NSString stringWithFormat:@"%@",object];// (NSString *)object;
            }
            else{
                return @"";
            }
        }
        return [NSString stringWithFormat:@"%@",object];// (NSString *)object;
	}
}

//键盘首响应  键盘是否开启
+(BOOL)TTIsKeyboardVisible
{
    // Operates on the assumption that the keyboard is visible if and only if there is a first
    // responder; i.e. a control responding to key events
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return !![window findFirstResponder];
}

//3g 流量
+(int) getGprs3GFlowIOBytes
{
    
    struct ifaddrs *ifa_list= 0, *ifa;
    
    if (getifaddrs(&ifa_list)== -1)
        
    {
        
        return 0;
        
    }
    
    
    
    uint32_t iBytes =0;
    
    uint32_t oBytes =0;
    
    
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
        
    {
        
        if (AF_LINK!= ifa->ifa_addr->sa_family)
            
            continue;
        
        
        
        if (!(ifa->ifa_flags& IFF_UP) &&!(ifa->ifa_flags& IFF_RUNNING))
            
            continue;
        
        
        
        if (ifa->ifa_data== 0)
            
            continue;
        
        
        
        if (!strcmp(ifa->ifa_name,"pdp_ip0"))
            
        {
            
            struct if_data *if_data = (struct if_data*)ifa->ifa_data;
            
            
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
            NSLog(@"%s :iBytes is %d, oBytes is %d",ifa->ifa_name, iBytes, oBytes);
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    
    
    return iBytes + oBytes;
    
}
//wifi 流量
+(float)bytesToAvaiUnit:(int )bytes
{
    if(bytes < 1024)     // B
    {
        return (float)bytes;
    }
    else  // KB
    {
        return (float)((double)bytes / 1024);
    }
}

+(long long int)getInterfaceBytes

{
    
    struct ifaddrs *ifa_list = 0, *ifa;
    
    if (getifaddrs(&ifa_list) == -1)
        
    {
        
        return 0;
        
    }
    
    
    
    uint32_t iBytes = 0;
    
    uint32_t oBytes = 0;
    
    
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
        
    {
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            
            continue;
        
        
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            
            continue;
        
        
        
        if (ifa->ifa_data == 0)
            
            continue;
        
        
        
        /* Not a loopback device. */
        
        if (strncmp(ifa->ifa_name, "lo", 2))
            
        {
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
            
            
            //            NSLog(@"%s :iBytes is %d, oBytes is %d",
            
            //                  ifa->ifa_name, iBytes, oBytes);
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    
    
    return iBytes+oBytes;
    
}

//图片
+(UIImage *)readImageFormLocoal:(NSString *)name
{
    NSArray * array=[name componentsSeparatedByString:@"."];
    NSString *type;
    NSString *path;
    if (array.count==2) {
        path =[array objectAtIndex:0];
        type=[array objectAtIndex:1];
    }else {
        path=name;
        type=@"png";
    }
    return  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:type]];
}
//统计字符量
+ (int)charNumber:(NSString*)strtemp {
    
    NSString *string=[NSString stringWithFormat:@"%@",strtemp];
    
    int strlength = 0;
    char *p = (char *)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}
//统计字数
+ (int)characterLength:(NSString*)strtemp
{
    NSString *string=[NSString stringWithFormat:@"%@",strtemp];
    
    int strlength = 0;
    char *p = (char *)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength/2;
}
//时间格式
+(NSString*) convertToTime:(NSString* )message
{
    NSString* time = @"";
    NSCalendar* calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    static NSDateFormatter* dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    //    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    float dd = [message floatValue];
    NSDate* createdAt = [NSDate dateWithTimeIntervalSince1970:dd];
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *createdAtComponents = [calendar components:unitFlags fromDate:createdAt];
    if([nowComponents year] == [createdAtComponents year] &&
       [nowComponents month] == [createdAtComponents month] &&
       [nowComponents day] == [createdAtComponents day])
    {//今天
        
        int time_long = [createdAt timeIntervalSinceNow];
        
        if (time_long <= 0 && time_long >-60*60) {//一小时之内
            int min = -time_long/60;
            if (min == 0) {
                min = 1;
            }
            //            time = [[[NSString alloc]initWithFormat:loadMuLanguage(@"%d分钟前",@""),min] autorelease];
            if (min <= 1) {
                time = [NSString stringWithFormat:@"%d分钟前",min];
            } else {
                time = [NSString stringWithFormat:@"%d分钟前",min];
            }
        }else if (time_long > 0) {
            time = [NSString stringWithFormat:@" %d分钟前",1];
            
        } else {
            [dateFormatter setDateFormat:@"H:mm"];
            
            time = [dateFormatter stringFromDate:createdAt];
        }
    } else if ([nowComponents year] == [createdAtComponents year]) {
        NSLocale *cnLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setLocale:cnLocale];
        //        [dateFormatter setDateFormat:@"MM月dd日' 'HH:mm"];
        [dateFormatter setDateFormat:@"MM月dd日 H:mm"];
        
        time = [dateFormatter stringFromDate:createdAt];
    } else {//去年
        NSLocale *cnLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setLocale:cnLocale];
        //        [dateFormatter setDateFormat:@"YYYY年MM月dd日' 'HH:mm"];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 H:mm"];
        
        time = [dateFormatter stringFromDate:createdAt];
    }
    
    return time;
}
//图片尺寸处理
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
+(NSString *)getDeviceBounds
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    if (rect.size.width ==480||rect.size.height ==480) {
        return @"4";
    }else if (rect.size.width==568||rect.size.height ==568)
    {
        return @"5";

    }else if (rect.size.width==667||rect.size.height ==667)
    {
        return @"6";

    }else if (rect.size.width==736||rect.size.height ==736)
    {
        return @"6p";

    }

    return nil;

    
}

+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {

    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

#pragma mark - 获取设备UUID
#pragma mark - 获取MAC地址
+ (NSString *)obtainMacAddress {
    int                    mib[6];
    size_t                 len;
    char                   *buf;
    unsigned char          *ptr;
    struct if_msghdr       *ifm;
    struct sockaddr_dl     *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) > 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];

    free(buf);
    
    return [outstring uppercaseString];
}

+ (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
//    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

+ (NSString *)obtainDeviceOpenUUID
{
    
        NSString *uuid = nil;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
            uuid = [self obtainMacAddress]; // 6.0以前用MAC地址作为UID
        } else {
            // identifierForVendor 6.0后可用
            uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        }
    
    return uuid;
}
+(NSString *)getDicHttp:(NSString *)strKey
{
    
    NSString *filePath=[NSString stringWithFormat:@"%@/%@.plist",MAINDBPATH,@"Peizhi"];
    NSDictionary * dic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    if (dic) {
        return [dic valueForKey:strKey];
    }else
    {
        return nil;
    }
}
//detail
#pragma mark - 申请成功
+ (void)showSubSuccess
{
    
    [AppDelegate getAppDelegate].nav.topViewController.view.userInteractionEnabled = NO;
    
    UIView *bgView = [[UIView alloc]initWithFrame:[AppDelegate getAppDelegate].nav.topViewController.view.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6f;
    [[AppDelegate getAppDelegate].nav.topViewController.view addSubview:bgView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.layer.cornerRadius = 5;
    view.center = [AppDelegate getAppDelegate].nav.topViewController.view.center;
    view.backgroundColor = [UIColor whiteColor];
    [[AppDelegate getAppDelegate].nav.topViewController.view addSubview:view];
    
    
    UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"zhongce_apply_success"] forState:UIControlStateNormal];
    xButton.userInteractionEnabled = NO;
    xButton.frame = CGRectMake( 0, 25, 0, 0);
    [view addSubview:xButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 0, 0)];
    titleLabel.text = @"申请成功";
    titleLabel.numberOfLines = 0;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [CommUtls colorWithHexString:@"333333"];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [view addSubview:titleLabel];
    
    NSString *str = @"申请进度可稍后在“我的众测”中查看";
    
    CGSize size  = [str stringSize:[UIFont systemFontOfSize:15.0] constraintSize:CGSizeMake(270-30, 1000)];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 270-30, 35)];
    
    contentLabel.frame = CGRectMake(0, 53, 0, 0);
    
    contentLabel.text = str;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [CommUtls colorWithHexString:@"666666"];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:15.0f];
    [view addSubview:contentLabel];
    
    
    [UIView animateWithDuration:.4f animations:^{
        view.frame = CGRectMake([AppDelegate getAppDelegate].nav.topViewController.view.frame.size.width/2-290/2, [AppDelegate getAppDelegate].nav.topViewController.view.frame.size.height/2-125/2, 290, 125);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.1f animations:^{
            view.frame = CGRectMake([AppDelegate getAppDelegate].nav.topViewController.view.frame.size.width/2-270/2, [AppDelegate getAppDelegate].nav.topViewController.view.frame.size.height/2-115/2, 270, 115);
        } completion:^(BOOL finished) {
            
            contentLabel.frame = CGRectMake(15, 53, 270-30, size.height);
            titleLabel.frame = CGRectMake(100, 22, 100, 20);
            xButton.frame = CGRectMake( 75, 25, 16, 16);
            
            [self performSelector:@selector(dismissAlerts:) withObject:[NSArray arrayWithObjects:bgView,view, nil] afterDelay:2.0f];
        }];
    }];
    
    
}

//数组转jsonstring
+ (NSString *)toJSONData:(id)theData{

        NSData* jsonData =[NSJSONSerialization dataWithJSONObject:theData
                                                          options:NSJSONWritingPrettyPrinted error:nil];
        NSString *strs=[[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
        return strs;
    
//    NSError *error;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString *jsonString;
//    
//    if (!jsonData) {
//        
//        NSLog(@"%@",error);
//        
//    }else{
//        
//        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//        
//    }
//    
//    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//    
//    NSRange range = {0,jsonString.length};
//    
//    //去掉字符串中的空格
//    
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    
//    NSRange range2 = {0,mutStr.length};
//    
//    //去掉字符串中的换行符
//    
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
//    
//    return mutStr;

    
}

+ (void)showMsgs:(NSString*)msg
{
    NSString *string = msg;
    if ([CommUtls characterLength:string] > 14) {
        [[HUDShare shareInstance] showText:[string substringToIndex:14] AndDetail:[string substringFromIndex:14]];
    }
    else{
        [[HUDShare shareInstance] showFail:string];
    }
}

+ (void)showMsgs:(NSString*)msg delay:(CGFloat)delay andLengh:(CGFloat)lengh
{
    if (IsIOS11) {
        NSString *string = msg;
        if ([CommUtls characterLength:string] > lengh) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.minShowTime=2.0f;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [string substringToIndex:lengh];
            hud.detailsLabelText = [string substringFromIndex:lengh];
            hud.detailsLabelFont = hud.labelFont;
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            hud.userInteractionEnabled = NO;
            [hud hide:YES afterDelay:delay];
        }
        else{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
            hud.minShowTime=.7f;
            
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = [[UIImageView alloc] initWithImage:nil];
            hud.labelText = string;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:NO afterDelay:delay];
        }
    }
    else{
        NSString *string = msg;
        if ([CommUtls characterLength:string] > lengh) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
            hud.minShowTime=.7f;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [string substringToIndex:lengh];
            hud.detailsLabelText = [string substringFromIndex:lengh];
            hud.detailsLabelFont = hud.labelFont;
//            hud.margin = 0.0f;
            
            hud.removeFromSuperViewOnHide = YES;
            hud.userInteractionEnabled = NO;
            [hud hide:NO afterDelay:delay];
            
            
  
            
            
        }
        else{
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
            hud.minShowTime=.7f;
            
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = [[UIImageView alloc] initWithImage:nil];
            hud.labelText = string;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:NO afterDelay:delay];
        }
    }
}

+ (void)showMsgs:(NSString*)msg delay:(CGFloat)delay
{
    if (IsIOS11) {
        NSString *string = msg;
        if ([CommUtls characterLength:string] > 14) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.minShowTime=2.0f;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [string substringToIndex:14];
            hud.detailsLabelText = [string substringFromIndex:14];
            hud.detailsLabelFont = hud.labelFont;
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            hud.userInteractionEnabled = NO;
            [hud hide:YES afterDelay:delay];
        }
        else{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
            hud.minShowTime=.7f;
            
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = [[UIImageView alloc] initWithImage:nil];
            hud.labelText = string;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:NO afterDelay:delay];
        }
    }
    else{
        NSString *string = msg;
        if ([CommUtls characterLength:string] > 14) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows objectAtIndex:[[UIApplication sharedApplication].windows count]-1] animated:NO];
            hud.minShowTime=.7f;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [string substringToIndex:14];
            hud.detailsLabelText = [string substringFromIndex:14];
            hud.detailsLabelFont = hud.labelFont;
            hud.margin = 10.f;
            
            hud.removeFromSuperViewOnHide = YES;
            hud.userInteractionEnabled = NO;
            [hud hide:NO afterDelay:delay];
        }
        else{
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows objectAtIndex:[[UIApplication sharedApplication].windows count]-1] animated:NO];
            hud.minShowTime=.7f;
            
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = [[UIImageView alloc] initWithImage:nil];
            hud.labelText = string;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:NO afterDelay:delay];
        }
    }
}

+(NSString *)ret32bitString
{
    
//    char data[32];
//    
//    for (int x=0;x<32;data[x++] = (char)('a' + (arc4random_uniform(26))));

    char data[32];
    for (int x=0; x<32;x++) {
        BOOL isAM = arc4random_uniform(2);;
        
        if (isAM) {
            data[x] = (char)('a' + (arc4random_uniform(26)));
        }else
        {
            data[x] = (char)('0' + (arc4random() %10));

        }
    }
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}
// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSString *)jsonString{
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    id object = [parser objectWithString:jsonString];
    return object;
}

+ (NSString *)getSettings//获取手机wifi 版本信息等
{
    NSString *notificationState=@"获取失败";
    NSString *settings=@"获取失败";
    
    
    if (IsIOS8) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types)
        {
            NSLog(@"notifications are disabled");
            notificationState=@"本地推送关闭";
            
            
        }else if (setting.types==(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert))
        {
            NSLog(@"Badge, Alert & Sound");
            notificationState=@"Badge, Alert & Sound";
        }else if (setting.types == (UIUserNotificationTypeBadge | UIUserNotificationTypeAlert)) {
            NSLog(@"Badge & Alert");
            notificationState=@"Badge & Alert";
        } else if (setting.types == (UIUserNotificationTypeBadge | UIUserNotificationTypeSound)) {
            NSLog(@"Badge & Sound");
            notificationState=@"Badge & Sound";
        } else if (setting.types == (UIUserNotificationTypeAlert | UIUserNotificationTypeSound)) {
            NSLog(@"Alert & Sound");
            notificationState=@"Alert & Sound";
        } else if (setting.types == UIUserNotificationTypeBadge) {
            NSLog(@"Badge only");
            notificationState=@"Badge only";
        } else if (setting.types == UIUserNotificationTypeAlert) {
            NSLog(@"Alert only");
            notificationState=@"Alert only";
        } else if (setting.types == UIUserNotificationTypeSound) {
            NSLog(@"Sound only");
            notificationState=@"Sound only";
        }

    }else
    {
        UIRemoteNotificationType notificationTypes=[[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (notificationTypes == UIRemoteNotificationTypeNone) {
            NSLog(@"notifications are disabled");
            notificationState=@"本地推送关闭";
        } else if (notificationTypes == UIRemoteNotificationTypeBadge) {
            NSLog(@"Badge only");
            notificationState=@"Badge only";
        } else if (notificationTypes == UIRemoteNotificationTypeAlert) {
            NSLog(@"Alert only");
            notificationState=@"Alert only";
        } else if (notificationTypes == UIRemoteNotificationTypeSound) {
            NSLog(@"Sound only");
            notificationState=@"Sound only";
        } else if (notificationTypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)) {
            NSLog(@"Badge & Alert");
            notificationState=@"Badge & Alert";
        } else if (notificationTypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)) {
            NSLog(@"Badge & Sound");
            notificationState=@"Badge & Sound";
        } else if (notificationTypes == (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)) {
            NSLog(@"Alert & Sound");
            notificationState=@"Alert & Sound";
        } else if (notificationTypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)) {
            NSLog(@"Badge, Alert & Sound");
            notificationState=@"Badge, Alert & Sound";
        }        
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    NSString* netType = @"无网络";
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    if (num == nil) {
        netType = @"无网络";
    }else{
        int n = [num intValue];
        if (n == 0) {
            netType = @"无网络";
        }else if (n == 1){
            netType = @"2G网络";
        }else if (n == 2){
            netType = @"3G网络";
        }else if (n == 3){
            netType = @"4G网络";
        }else{
            netType = @"WiFi网络";
        }
    }
    
    //////////17.05.23
    /*
     => Start *** Collection <CALayerArray: 0x1744424f0> was mutated while being enumerated.
     -> translating『 0x10039a5ec 』=> +[CommUtls getSettings] /Users/sunfaxin/Desktop/SMZDM/iphone7.8.1/SMZDM/Utls/Common/CommUtls.m: line 2314
     -> translating『 0x100522c60 』=>
     -> translating『 0x10064dc00 』=> -[AppDelegate updatePushConfig:] /Users/sunfaxin/Desktop/SMZDM/iphone7.8.1/SMZDM/AppDelegate.m: line 2150
     => End *** Collection <CALayerArray: 0x1744424f0> was mutated while being enumerated.
     */
    NSString *token = [[[NSUserDefaults standardUserDefaults] stringForKey:@"token"] isSafeString] ? [[NSUserDefaults standardUserDefaults] stringForKey:@"token"] : @"获取失败";
    NSString *device = [[CommUtls deviceString] isSafeString] ? [CommUtls deviceString] : @"获取失败";
    NSString *systemVersion = [[[UIDevice currentDevice] systemVersion] isSafeString] ? [[UIDevice currentDevice] systemVersion] : @"获取失败";
    NSString *cfBundleShortVersionString = [[SMZDMAppInfo shareInstance].CFBundleShortVersionString isSafeString] ? [SMZDMAppInfo shareInstance].CFBundleShortVersionString : @"获取失败";
    NSString *idfa = [[Desencryption encryptUseDES:[SMZDMDeviceInfo shareInstance].IDFA key:IDFAKEY] isSafeString] ? [Desencryption encryptUseDES:[SMZDMDeviceInfo shareInstance].IDFA key:IDFAKEY] : @"获取失败";
    settings = [NSString stringWithFormat:@" \n本地推送设置:%@|token:%@|设备型号:%@|设备系统版本:%@|客户端版本:%@|网络类型:%@|idfa:%@",notificationState,token,device,systemVersion,cfBundleShortVersionString,netType,idfa];
    
    return settings;
}

+ (NSString *)getAllSettings;
{
    NSString *settings=nil;
    settings = [NSString stringWithFormat:@"os_type=%@&device_type=%@&client_type=%@",[[UIDevice currentDevice] systemVersion],[CommUtls deviceString],[SMZDMAppInfo shareInstance].CFBundleShortVersionString];
    
    return settings;
}
+(NSString *)getPushsetting
{
    NSString *notificationState=nil;
   
    
    
    if (IsIOS8) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types)
        {
            NSLog(@"notifications are disabled");
            notificationState=@"notifications_are_disabled";
            
            
        }else if (setting.types==(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert))
        {
            NSLog(@"Badge, Alert & Sound");
            notificationState=@"Badge, Alert & Sound";
        }else if (setting.types == (UIUserNotificationTypeBadge | UIUserNotificationTypeAlert)) {
            NSLog(@"Badge & Alert");
            notificationState=@"Badge & Alert";
        } else if (setting.types == (UIUserNotificationTypeBadge | UIUserNotificationTypeSound)) {
            NSLog(@"Badge & Sound");
            notificationState=@"Badge & Sound";
        } else if (setting.types == (UIUserNotificationTypeAlert | UIUserNotificationTypeSound)) {
            NSLog(@"Alert & Sound");
            notificationState=@"Alert & Sound";
        } else if (setting.types == UIUserNotificationTypeBadge) {
            NSLog(@"Badge only");
            notificationState=@"Badge only";
        } else if (setting.types == UIUserNotificationTypeAlert) {
            NSLog(@"Alert only");
            notificationState=@"Alert only";
        } else if (setting.types == UIUserNotificationTypeSound) {
            NSLog(@"Sound only");
            notificationState=@"Sound only";
        }
        
    }else
    {
        UIRemoteNotificationType notificationTypes=[[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (notificationTypes == UIRemoteNotificationTypeNone) {
            NSLog(@"notifications are disabled");
            notificationState=@"notifications_are_disabled";
        } else if (notificationTypes == UIRemoteNotificationTypeBadge) {
            NSLog(@"Badge only");
            notificationState=@"Badge only";
        } else if (notificationTypes == UIRemoteNotificationTypeAlert) {
            NSLog(@"Alert only");
            notificationState=@"Alert only";
        } else if (notificationTypes == UIRemoteNotificationTypeSound) {
            NSLog(@"Sound only");
            notificationState=@"Sound only";
        } else if (notificationTypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)) {
            NSLog(@"Badge & Alert");
            notificationState=@"Badge & Alert";
        } else if (notificationTypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)) {
            NSLog(@"Badge & Sound");
            notificationState=@"Badge & Sound";
        } else if (notificationTypes == (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)) {
            NSLog(@"Alert & Sound");
            notificationState=@"Alert & Sound";
        } else if (notificationTypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)) {
            NSLog(@"Badge, Alert & Sound");
            notificationState=@"Badge, Alert & Sound";
        }
        
        
    }
    if (notificationState==nil) {
        return @"nodevice_push";

    }else
    {
        return notificationState;

    }
}

#pragma mark - emoji
+ (BOOL)isEmo:(NSString *)substring
{
    if ([substring isEqualToString:@"❤️"]) {
        return YES;
    }
    const unichar hs = [substring characterAtIndex:0];
    //         // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                return  YES;
            }
        }
    } else if (substring.length > 1) {
        const unichar ls = [substring characterAtIndex:1];
        if (ls == 0x20e3) {
            return YES;
        }
        
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            return YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            return YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            return YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            return YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)defaultUserAgentString
{

    NSString *defaultUserAgent = nil;
        
        if (!defaultUserAgent) {
            
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            
            // Attempt to find a name for this application
//            NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
//            if (!appName) {
//                appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
//            }
            NSString *appName = @"什么值得买";

            NSData *latin1Data = [appName dataUsingEncoding:NSUTF8StringEncoding];
//            appName = [[NSString alloc] initWithData:latin1Data encoding:NSISOLatin1StringEncoding] ;
            
            // If we couldn't find one, we'll give up (and ASIHTTPRequest will use the standard CFNetwork user agent)
            if (!appName) {
                return nil;
            }
            
            NSString *appVersion = nil;
            NSString *marketingVersionNumber = [SMZDMAppInfo shareInstance].CFBundleShortVersionString;
            NSString *developmentVersionNumber = [SMZDMAppInfo shareInstance].CFBundleVersion;
            if (marketingVersionNumber && developmentVersionNumber) {
                if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
                    appVersion = marketingVersionNumber;
                } else {
                    appVersion = [NSString stringWithFormat:@"%@ rv:%@",marketingVersionNumber,developmentVersionNumber];
                }
            } else {
                appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
            }
            
            NSString *deviceName;
            NSString *OSName;
            NSString *OSVersion;
            NSString *locale = [[NSLocale currentLocale] localeIdentifier];
            
#if TARGET_OS_IPHONE
            UIDevice *device = [UIDevice currentDevice];
            deviceName = [device model];
            OSName = [device systemName];
            OSVersion = [device systemVersion];
            
#else
            deviceName = @"Macintosh";
            OSName = @"Mac OS X";
            
            // From http://www.cocoadev.com/index.pl?DeterminingOSVersion
            // We won't bother to check for systems prior to 10.4, since ASIHTTPRequest only works on 10.5+
            OSErr err;
            SInt32 versionMajor, versionMinor, versionBugFix;
            err = Gestalt(gestaltSystemVersionMajor, &versionMajor);
            if (err != noErr) return nil;
            err = Gestalt(gestaltSystemVersionMinor, &versionMinor);
            if (err != noErr) return nil;
            err = Gestalt(gestaltSystemVersionBugFix, &versionBugFix);
            if (err != noErr) return nil;
            OSVersion = [NSString stringWithFormat:@"%u.%u.%u", versionMajor, versionMinor, versionBugFix];
#endif
            
            // Takes the form "My Application 1.0 (Macintosh; Mac OS X 10.5.7; en_GB)"
            
            //            NSLog(@"%@",[NSString stringWithFormat:@"网络请求：：：%@ %@ (%@; %@ %@; %@)", appName, appVersion, deviceName, OSName, OSVersion, locale]);
            defaultUserAgent=[NSString stringWithFormat:@"%@ %@ (%@; %@ %@; %@)", @"smzdm", appVersion, deviceName, OSName, OSVersion, locale];
        }
        return defaultUserAgent;
}
+ (void)clearWebViewCache
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}

+ (NSString*)decodeBase64String:(NSString*)input{
    NSData*data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    data = [GTMBase64 decodeData:data];
    
    NSString*base64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    
    return base64String;
}

+ (void)saveIntoUserDefaultWithObject:(id)obj key:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: obj];
    [kStandardUserDefaults setObject:data forKey:key];
    [kStandardUserDefaults synchronize];
}

+ (id)getObjectWithDefaultKey:(NSString *)key {
    if ([kStandardUserDefaults objectForKey:key]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:[kStandardUserDefaults objectForKey:key]];
    }
    return nil;
}


@end
