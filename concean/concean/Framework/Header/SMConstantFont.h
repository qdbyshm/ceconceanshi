//
//  SMConstantFont.h
//  SMZDM
//
//  Created by 冯展波 on 16/1/19.
//  Copyright © 2016年 smzdm. All rights reserved.
//字体

#ifndef SMConstantFont_h
#define SMConstantFont_h

#define UIFontSY10 (DEVICE6P?[UIFont systemFontOfSize:10]:(DEVICESIX?[UIFont systemFontOfSize:10]:(DEVICEFIVE?[UIFont systemFontOfSize:10]:[UIFont systemFontOfSize:10])))


#define UIFontSY12 (DEVICE6P?[UIFont systemFontOfSize:12]:(DEVICESIX?[UIFont systemFontOfSize:12]:(DEVICEFIVE?[UIFont systemFontOfSize:12]:[UIFont systemFontOfSize:12])))

#define UIFontSY13 (DEVICE6P?[UIFont systemFontOfSize:13]:(DEVICESIX?[UIFont systemFontOfSize:13]:(DEVICEFIVE?[UIFont systemFontOfSize:13]:[UIFont systemFontOfSize:13])))


#define UIFontSY11 (DEVICE6P?[UIFont systemFontOfSize:11]:(DEVICESIX?[UIFont systemFontOfSize:11]:(DEVICEFIVE?[UIFont systemFontOfSize:11]:[UIFont systemFontOfSize:11])))


#define UIFontSY15 (DEVICE6P?[UIFont systemFontOfSize:15]:(DEVICESIX?[UIFont systemFontOfSize:15]:(DEVICEFIVE?[UIFont systemFontOfSize:15]:[UIFont systemFontOfSize:15])))


#define UIFontSY16 (DEVICE6P?[UIFont systemFontOfSize:16]:(DEVICESIX?[UIFont systemFontOfSize:16]:(DEVICEFIVE?[UIFont systemFontOfSize:16]:[UIFont systemFontOfSize:16])))


#define UIFontSY20 (DEVICE6P?[UIFont systemFontOfSize:20]:(DEVICESIX?[UIFont systemFontOfSize:20]:(DEVICEFIVE?[UIFont systemFontOfSize:20]:[UIFont systemFontOfSize:20])))

/*
 苹方提供了六个字重，font-family 定义如下：
 苹方-简 常规体
 font-family: PingFangSC-Regular, sans-serif;
 苹方-简 极细体
 font-family: PingFangSC-Ultralight, sans-serif;
 苹方-简 细体
 font-family: PingFangSC-Light, sans-serif;
 苹方-简 纤细体
 font-family: PingFangSC-Thin, sans-serif;
 苹方-简 中黑体
 font-family: PingFangSC-Medium, sans-serif;
 苹方-简 中粗体
 font-family: PingFangSC-Semibold, sans-serif;
 */

//字体
//华文细黑
#define kHelveticaNeueRegular  @"HelveticaNeue"
//华文细黑-Medium
#define kHelveticaNeueMedium  @"HelveticaNeue-Medium"
//华文细黑(加粗)
#define kHelveticaNeueBlod  @"HelveticaNeue-Bold"
//华文细黑(加粗加黑)
#define kHelveticaNeueCondensedBlack    @"HelveticaNeue-CondensedBlack"


//公共字体
#define kZDM_Font(fontName,fontSize)            [UIFont fontWithName:fontName size:fontSize]

#define kZDM_HelveticaNeueRegular(fontSize)         [UIFont fontWithName:kHelveticaNeueRegular size:fontSize]
#define kZDM_HelveticaNeueMedium(fontSize)          [UIFont fontWithName:kHelveticaNeueMedium size:fontSize]
#define kZDM_HelveticaNeueBlod(fontSize)            [UIFont fontWithName:kHelveticaNeueBlod size:fontSize]
#define kZDM_HelveticaNeueCondensedBlack(fontSize)  [UIFont fontWithName:kHelveticaNeueCondensedBlack size:fontSize]

#endif /* SMConstantFont_h */
