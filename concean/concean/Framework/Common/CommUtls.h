//
//  CommUtls.h
//  UtlBox
//
//  Created by cdel cyx on 12-7-10.
//  Copyright (c) 2012年 cdeledu. All rights reserved.
//

#import "UCHudV.h"

#define kUserBKTopicCollect @"topic"
#import <QuartzCore/QuartzCore.h>
@interface CommUtls<CAAnimationDelegate> : NSObject
{
    UCHudV *customHud;
    UIView *mainView;
}
@property(nonatomic,retain)NSString *requestUrl ;
@property(nonatomic,retain)NSString *bannerTitle ;

+ (NSString*)decodeBase64String:(NSString*)input;
+ (BOOL)checkNumberP:(NSString *) telNumber;
#pragma mark ====旋转动画======
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount;


+(NSString *)getOpenUdid;
+ (NSString *)getMacAddress;
+(BOOL)IsChinese:(NSString *)str;
+ (BOOL)getChannel:(NSString *)url;

+(UIImage *) getImageFromURL:(NSString *)fileURL;

+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

+(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

+ (void)drawDashLine:(UIImageView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

+ (NSString *)appleId;

//+(NSString *)getModeStr:(NSString *)art_id;

+(NSString *)getStyleStr;

+ (NSString*)deviceString;

+ (NSURL *)getURLFromString:(NSString *)str;

+ (NSString *)getDicHttps:(NSString *)strKey;

+ (BOOL )getArrayBool:(id)array;


/*文件处理*/
//文件路径是否存在
+ (BOOL)fileExists:(NSString *)fullPathName;

//根据文件路径删除文件
+ (BOOL)remove:(NSString *)fullPathName;

//创建文件
+ (void)makeDirs:(NSString *)dir;

//documentPath路径是否存在
+ (BOOL)fileExistInDocumentPath:(NSString*)fileName;

//返回完整的documentPath下文件路径
+ (NSString*)documentPath:(NSString*)fileName;

//删除documentPath路径下文件
+ (BOOL)deleteDocumentFile:(NSString*)fileName;

//cachePath路径是否存在
+ (BOOL)fileExistInCachesPath:(NSString*)fileName;

//返回完整的cachePath下文件路径
+ (NSString*)cachesFilePath:(NSString*)fileName;

//删除cachePath下文件路径
+ (BOOL)deleteCachesFile:(NSString*)fileName;
+ (UIImage *)imageWithColor:(UIColor *)color;
/*时间处理*/
//CST时间格式转换
+ (NSString *)convertDateFromCST:(NSString *)_date;

//转换NSDate格式为字符串"yyyy-MM-dd HH:mm:ss"
+ (NSString *)encodeTime:(NSDate *)date;

//转换字符串为"yyyy-MM-dd HH:mm:ss"格式到NSDate
+ (NSDate *)dencodeTime:(NSString *)dateString;

//装换NSDate格式到NString
+ (NSString *)encodeTime:(NSDate *)date format:(NSString *)format;

//转换NString到NSdate
+ (NSDate *)dencodeTime:(NSString *)dateString format:(NSString *)format;

//从现在到某天的时间
+ (NSString *)timeSinceNow:(NSDate *)date;

//把秒转化为时间字符串显示，播放器常用
+ (NSString *)changeSecondsToString:(CGFloat)durartion;

/*跳转处理*/
//跳转到电子市场页面
+ (void)goToAppStoreHomePage:(NSInteger)appid;

//跳转到电子市场评论页面
+ (void)goToAppStoreCommentPage:(NSInteger)appid;

//跳到短信页面
+ (void)goToSmsPage:(NSString*)phoneNumber;

//打开浏览器
+ (void)openBrowse:(NSString*)url;

//打开EMAIL
+ (void)openEmail:(NSString*)email;

/*其他处理*/
//返回字节大小
+ (NSString*)getSize:(NSNumber*)number;

//获取空余磁盘信息
+ (CGFloat)freeDiskSpace;

//返回随即数
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max;

//转换颜色色值
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;
//返回mac地址
+ (NSString *)macAddress;
//ip
+(NSString *)macIP;
+ (NSString *)encode:(NSString *)s;

//是否存在网络
+ (BOOL)checkConnectNet;



/*UI组件*/
//状态栏添加信息
+ (void)addStatusMessage:(NSString*)message afterTime:(CGFloat)time;

//删除信息
+ (void)removeStatusMessage;


//图片压缩
+ (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize;

+ (NSString *)systemTime:(NSString *)format;//time  string>string

//增加icloud不被备份
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

//过滤xml
+ (NSString *)specialCharForXML:(NSString *)str;

//简单过渡效果
+ (CATransition *)creatAnmitionFrom:(NSInteger)direction;

+ (CATransition *)creatAnmitionHorizontalFrom:(NSInteger)direction;

+ (CATransition *)creatAnmitionDisplayScreenView:(NSInteger)direction;

//将view转为image
+ (UIImage *)getImageFromView:(UIView *)view;

//获取随机颜色color
+ (UIColor *)getRandomColor;

//根据比例（0...1）在min和max中取值
+ (float)lerp:(float)percent min:(float)nMin max:(float)nMax;

// 检测是否是数组
+(BOOL)correctData:(id)responder;
//加密
+ (NSString *)AES256Encrypt:(NSString *)string andKey:(NSString *)key;
+ (NSString *)AES256Decrypt:(NSString *)string andKey:(NSString *)key;
// 是否是wifi
+(BOOL)isWiFiNet;

/*
 判断JSon解析出来的Object是否为NSNull类型
 输入参数：需要判断的Object
 输出参数：返回一个经过格式化的NSString类型
 */
+(NSString *)checkNullValueForString:(id)object;

//键盘首响应  键盘是否开启
+(BOOL)TTIsKeyboardVisible;

//3g 流量
+(int) getGprs3GFlowIOBytes;

//wifi 流量
+(long long int)getInterfaceBytes;
+(float)bytesToAvaiUnit:(int )bytes;

//获取配置api
+(NSString *)getDicHttp:(NSString *)strKey;

//颜色变换

//图片
+(UIImage *)readImageFormLocoal:(NSString *)name;
//统计字符量
+ (int)charNumber:(NSString*)strtemp;
//统计字数
+ (int)characterLength:(NSString*)strtemp;

//时间格式
+(NSString*) convertToTime:(NSString* )message;

//图片处理
+(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

+(NSString *)getDeviceBounds;

+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
//uuid
+ (NSString *)obtainMacAddress;

+ (NSString *)obtainDeviceOpenUUID;
+ (NSString *)getSettings;
+ (NSString *)getAllSettings;

//申请众测成功、失败
+ (void)showSubSuccess;
+ (void)dismissAlerts:(NSArray*)viewarrays;
+ (void)showSubFailed:(NSString*)msg;

+ (void)showMsgs:(NSString*)msg;
+ (void)showMsgs:(NSString*)msg delay:(CGFloat)delay;
+ (void)showMsgs:(NSString*)msg delay:(CGFloat)delay andLengh:(CGFloat)lengh;

//数组转jsonstring
+ (NSString *)toJSONData:(id)theData;
// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSString *)jsonString;
//推送
+(NSString *)getPushsetting;
//是否登录
+(NSString *)getIflogin;


//emoji
+ (BOOL)isEmo:(NSString *)substring;

//default ua
+ (NSString *)defaultUserAgentString;

+ (void)clearWebViewCache;

+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr WithStr:(NSString *)stre;


+ (NSMutableArray *)channelNum:(NSArray *)array;

+ (NSString *)ret32bitString;

/**
 *  将对象保存到NSUserDefault
 *
 *  @param obj 对象
 *  @param key 键值
 */
+ (void)saveIntoUserDefaultWithObject:(id)obj key:(NSString *)key;

/**
 *  从NSUserDefault中获取对象
 *
 *  @param key 键值
 *
 *  @return 对象
 */
+ (id)getObjectWithDefaultKey:(NSString *)key;

@end
