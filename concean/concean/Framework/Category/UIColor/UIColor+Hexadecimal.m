//
//  UIColor+Hexadecimal.m
//  SMZDM
//
//  Created by ZhangWenhui on 15/6/3.
//
//

#import "UIColor+Hexadecimal.h"

@implementation UIColor (Hexadecimal)

//转换颜色色值
+ (UIColor *)colorWithHexString:(NSString *)hexadecimal
{
    NSString *cString = [[hexadecimal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
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
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexNumber:(NSUInteger)hexColor
{
    float r = ((hexColor>>16) & 0xFF) / 255.0f;
    float g = ((hexColor>>8) & 0xFF) / 255.0f;
    float b = (hexColor & 0xFF) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

+ (UIColor *)HEXColor:(NSString *)hexColor
{
    return [self colorWithHexString:hexColor];
}

+ (UIColor *)randomColor
{
    return kRandomColor;
}

//默认黑
+ (UIColor *)color_333333
{
    UIColor *color = [self colorWithHexString:@"#333333"];
    return color;
}

//轻度黑
+ (UIColor *)color_666666
{
    UIColor *color = [self colorWithHexString:@"#666666"];
    return color;
}

//灰色（偏重度）
+ (UIColor *)color_999999
{
    UIColor *color = [self colorWithHexString:@"#999999"];
    return color;
}

//红色
+ (UIColor *)color_f04848
{
    UIColor *color = [self colorWithHexString:@"#f04848"];
    return color;
}

//淡绿色
+ (UIColor *)color_5deb07
{
    UIColor *color = [self colorWithHexString:@"#5deb07"];
    return color;
}
//浅绿色
+ (UIColor *)color_749911
{
    UIColor *color = [self colorWithHexString:@"#749911"];
    return color;
}

//分割线颜色（偏灰色）
+ (UIColor *)color_d6d6d6
{
    UIColor *color = [self colorWithHexString:@"#d6d6d6"];
    return color;
}

//背景颜色灰色
+ (UIColor *)color_f5f5f5
{
    UIColor *color = [self colorWithHexString:@"#f5f5f5"];
    return color;
}

//背景颜色轻度灰
+ (UIColor *)color_fafafa
{
    UIColor *color = [self colorWithHexString:@"#fafafa"];
    return color;
}

//导航栏白色
+ (UIColor *)color_white
{
    UIColor *color = [UIColor whiteColor];
    return color;
}

+ (UIColor *)color_ffffff
{
    UIColor *color = [self colorWithHexString:@"#ffffff"];
    return color;
}

+ (UIColor *)color_5a5a5a{
    UIColor *color = [self colorWithHexString:@"#5a5a5a"];
    return color;
}

+ (UIColor *)color_a0a0a0{
    UIColor *color = [self colorWithHexString:@"#a0a0a0"];
    return color;
}

+ (UIColor *)color_c8c8c8{
    UIColor *color = [self colorWithHexString:@"#c8c8c8"];
    return color;
}

+ (UIColor *)color_7b7b7b{
    UIColor *color = [self colorWithHexString:@"#7b7b7b"];
    return color;
}

+ (UIColor *)color_444444{
    UIColor *color = [self colorWithHexString:@"#444444"];
    return color;
}

+ (UIColor *)color_ff9e1e{
    UIColor *color = [self colorWithHexString:@"#ff9e1e"];
    return color;
}

+ (UIColor *)color_50c846{
    UIColor *color = [self colorWithHexString:@"#50c846"];
    return color;
}

+ (UIColor *)color_cacaca{
    UIColor *color = [self colorWithHexString:@"#cacaca"];
    return color;
}

+ (UIColor *)color_0066c0{
    UIColor *color = [self colorWithHexString:@"#0066c0"];
    return color;
}

+ (UIColor *)color_f0f0f0{
    UIColor *color = [self colorWithHexString:@"#f0f0f0"];
    return color;
}

+ (UIColor *)color_646464{
    UIColor *color = [self colorWithHexString:@"#646464"];
    return color;
}


+ (UIColor *)color_background {
    UIColor *color = [self colorWithHexString:@"#f8f8f8"];
    return color;
}

+ (UIColor *)color_title {
    UIColor *color = [self colorWithHexString:@"#333333"];
    return color;
}

+ (UIColor *)color_yetBrowse {
    UIColor *color = [self colorWithHexString:@"#888888"];
    return color;
}

+ (UIColor *)color_accessory {
    UIColor *color = [self colorWithHexString:@"#9b9b9b"];
    return color;
}

+ (UIColor *)color_company {
    UIColor *color = [self colorWithHexString:@"#f04848"];
    return color;
}

+ (UIColor *)color_subtitle {
    UIColor *color = [self colorWithHexString:@"#666666"];
    return color;
}

+ (UIColor *)color_separator {
    UIColor *color = [self colorWithHexString:@"#e0e0e0"];
    return color;
}

+ (UIColor *)color_darkgray {
    UIColor *color = [self colorWithHexString:@"#999999"];
    return color;
}

@end
