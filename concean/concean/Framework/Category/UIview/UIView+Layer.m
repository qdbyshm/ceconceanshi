//
//  UIView+Layer.m
//  SMZDM
//
//  Created by 冯展波 on 16/4/23.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "UIView+Layer.h"
#import "UIColor+Expand.h"
@implementation UIView (Layer)

- (void)layerColor:(NSString *)colorStr Radius:(CGFloat)radius boder:(CGFloat)boder
{
    UIColor * color = [UIColor colorWithHexString:colorStr];
    
    CALayer *loginLayer = self.layer;
    [loginLayer setBorderColor:[color CGColor]];
    [loginLayer setBorderWidth:boder];
    [loginLayer setMasksToBounds:NO];
    [loginLayer setCornerRadius:radius];
    
}
- (void)commonLayer
{
    UIColor * color = [UIColor colorWithHexString:@"#c8c8c8"];
    
    CALayer *loginLayer = self.layer;
    [loginLayer setBorderColor:[color CGColor]];
    [loginLayer setBorderWidth:0];
    [loginLayer setMasksToBounds:NO];
    [loginLayer setCornerRadius:3];
}
@end
