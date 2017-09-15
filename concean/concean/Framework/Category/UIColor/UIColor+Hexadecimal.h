//
//  UIColor+Hexadecimal.h
//  SMZDM
//
//  Created by ZhangWenhui on 15/6/3.
//
//

#import <UIKit/UIKit.h>

#define kRandomColor    [UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1]
//#define kRandomColor    [UIColor clearColor]
#define kPageSize   20

#define HEXColor(hexColor)  [UIColor HEXColor:hexColor]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (Hexadecimal)

//转换颜色色值
+ (UIColor *)colorWithHexString:(NSString *)hexadecimal;
+ (UIColor *)HEXColor:(NSString *)hexColor;
+ (UIColor *)randomColor;

//默认黑
+ (UIColor *)color_333333;
//轻度黑
+ (UIColor *)color_666666;
//灰色（偏重度）
+ (UIColor *)color_999999;
//红色
+ (UIColor *)color_f04848;
//淡绿色
+ (UIColor *)color_5deb07;
//浅绿色
+ (UIColor *)color_749911;
//分割线颜色（偏灰色）
+ (UIColor *)color_d6d6d6;
//背景颜色灰色
+ (UIColor *)color_f5f5f5;
//背景颜色轻度灰
+ (UIColor *)color_fafafa;
//导航栏白色
+ (UIColor *)color_white;
+ (UIColor *)color_ffffff;
+ (UIColor *)color_5a5a5a;
+ (UIColor *)color_a0a0a0;
+ (UIColor *)color_7b7b7b;
+ (UIColor *)color_c8c8c8;
+ (UIColor *)color_444444;
+ (UIColor *)color_ff9e1e;
+ (UIColor *)color_50c846;
+ (UIColor *)color_cacaca;
+ (UIColor *)color_0066c0;
+ (UIColor *)color_f0f0f0;
+ (UIColor *)color_646464;

//-----------------赵彬 2017-05-24----------------//
/**
 背景颜色

 @return f8f8f8
 */
+ (UIColor *)color_background;

/**
 标题颜色

 @return 333333
 */
+ (UIColor *)color_title;

/**
 标题已读颜色

 @return 888888
 */
+ (UIColor *)color_yetBrowse;

/**
 附件颜色

 @return 9b9b9b
 */
+ (UIColor *)color_accessory;

/**
 企业色

 @return f40808
 */
+ (UIColor *)color_company;

/**
 副标题
 
 @return 666666
 */
+ (UIColor *)color_subtitle;

/**
 分割线

 @return e0e0e0
 */
+ (UIColor *)color_separator;

/**
 深灰

 @return 999999
 */
+ (UIColor *)color_darkgray;

@end
