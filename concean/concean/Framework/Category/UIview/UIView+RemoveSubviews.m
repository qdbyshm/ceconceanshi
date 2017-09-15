//
//  UIView+RemoveSubviews.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/3/9.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "UIView+RemoveSubviews.h"

@implementation UIView (RemoveSubviews)

- (void)removeSubviews
{
    for (UIView *element in self.subviews) {
        [element removeFromSuperview];
    }
}

- (void)yw_recursiveDescription
{
#ifdef DEBUG
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSLog(@"cell recursive description:\n\n%@\n\n",[self performSelector:@selector(recursiveDescription)]);
#pragma clang diagnostic pop
#else
    NSLog(@"");
#endif
}

@end
