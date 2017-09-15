//
//  SMBaseModel.m
//  SMZDM
//
//  Created by ZhangWenhui on 2017/6/21.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "SMBaseModel.h"

@interface SMBaseModel ()

@end

@implementation SMBaseModel

- (instancetype)init
{
    if (self = [super init]) {
        self.sm_isActive = NO;
    }
    return self;
}

@end
