//
//  NSString+Business.m
//  SMZDM
//
//  Created by chenshan on 2017/4/26.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "NSString+Business.h"

@implementation NSString (Business)

- (NSString *)smFollowerString
{
    return [NSString stringWithFormat:@"%@ 人关注",[self smBaseFollowerString]];
}

- (NSString *)smBaseFollowerString
{
    if(![self isSafeString]) return @"0";
    
    NSInteger followerNum = [self integerValue];
    if (followerNum > 99000) {
        return @"99k+";
    }
    else if (followerNum >= 1000) {
        return [NSString stringWithFormat:@"%.1fk", floor(followerNum / 100.0) / 10.0];
    } else {
        return [NSString stringWithFormat:@"%@", @(followerNum)];
    }
}

- (NSString *)smFollowerPlusOne {
    if(![self isSafeString]) return @"";
    
    NSInteger followerNum = [self integerValue];
    followerNum++;
    
    return [NSString stringWithFormat:@"%@", @(followerNum)];
}

- (NSString *)smFollowerMinusOne {
    if(![self isSafeString]) return @"";
    
    NSInteger followerNum = [self integerValue];
    followerNum--;
    if(followerNum < 0) followerNum = 0;
    
    return [NSString stringWithFormat:@"%@", @(followerNum)];
}

@end
