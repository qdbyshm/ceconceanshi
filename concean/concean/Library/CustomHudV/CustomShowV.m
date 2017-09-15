//
//  CustomShowV.m
//  SMZDM
//
//  Created by 孙 浩明 on 13-12-9.
//
//

#import "CustomShowV.h"
#import <QuartzCore/QuartzCore.h>
@implementation CustomShowV


- (id)initWithFrame:(CGRect)frame withView:(UIView *)superV
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, 100, 40);
        self.layer.cornerRadius = 8;
        self.layer.backgroundColor = [[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f]CGColor];
        [self.layer setMasksToBounds:YES];
        
        _titLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 20)];
        _titLabel.textAlignment = NSTextAlignmentCenter;
        _titLabel.backgroundColor = [UIColor clearColor];
        _titLabel.textColor=[UIColor whiteColor];
        [_titLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self addSubview:_titLabel];
        
    }
    return self;
}

@end
