//
//  SMUserView.h
//  SMZDM
//
//  Created by ZhangWenhui on 2017/9/4.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMUserView : UIControl

/**
 自身最大宽度，默认为0，即：没有最大宽度，不做限制
 */
@property (nonatomic, assign) CGFloat sm_maxWidth;

/**
 左侧头像 与 右侧昵称 的间距，默认为10.0
 */
@property (nonatomic, assign) CGFloat sm_space;

/**
 左侧图片view
 */
@property (nonatomic, strong) UIImage *sm_image;
@property (nonatomic, strong) NSURL *sm_imageUrl;
@property (nonatomic, assign) CGSize sm_imageSize;

/**
 右侧label
 */
@property (nonatomic, strong) NSString *sm_title;

@end
