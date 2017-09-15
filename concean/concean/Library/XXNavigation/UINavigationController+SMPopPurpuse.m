//
//  UINavigationController+SMPopPurpuse.m
//  SMZDM
//
//  Created by 冯展波 on 17/1/6.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "UINavigationController+SMPopPurpuse.h"

@implementation UINavigationController (SMPopPurpuse)

- (void)popPurposeFatherVC:(NSString *)father
{
    for (UIViewController * vc in self.viewControllers) {
        if ([[NSString stringWithUTF8String:object_getClassName(vc)] isEqualToString:father]) {
            [self popToViewController:vc animated:YES];
        }
    }
}
@end
