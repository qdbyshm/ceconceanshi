//
//  NavigatonBarView.m
//  forum
//
//  Created by cyx on 12-7-26.
//  Copyright (c) 2012年 cdeledu. All rights reserved.
//

#import "NavigatonBarView.h"
@implementation NavigatonBarView
@synthesize titleLabel =  titleLabel;
@synthesize leftButton = leftButton;
@synthesize rightButton = rightButton;
@synthesize backGroundImgeView = backGroundImgeView;
@synthesize rightLabel = rightLabel;
@synthesize leftLabel = leftLabel;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        
        self.backgroundColor = [UIColor clearColor];
        CGFloat point = 0;
        if(IsIOS7)
            point = 20;
        CGFloat buttonHeight = NAVIGATIONBAR_HEIGHT - point;
        buttonHeight = 44.0;
        
        backGroundImgeView = [[UIImageView alloc] initWithFrame:(CGRect){{0, 0}, self.size}];
        
        titleLabel = [[UILabel alloc] initWithFrame:(CGRect){0, 0, NAVIGATIONBAR_TITLE_WIDTH, buttonHeight}];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:NAVIGATIONBAR_FRONT_SIZE];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.bottom = self.height;
        titleLabel.centerX = self.width / 2;
      
        leftButton = [[UIButton alloc] initWithFrame:(CGRect){NAVIGATIONBAR_INTERVAL, point, NAVIGATIONBAR_BUTTON_WIDTH - 30, buttonHeight}];
        leftButton.backgroundColor = [UIColor clearColor];
        [leftButton addTarget:self action:@selector(navigationLeftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        leftButton.bottom = self.height;
        
        rightButton = [[UIButton alloc] initWithFrame:(CGRect){0, point, NAVIGATIONBAR_BUTTON_WIDTH - 30, buttonHeight}];
        rightButton.left = frame.size.width - NAVIGATIONBAR_INTERVAL - NAVIGATIONBAR_BUTTON_WIDTH + 30;
        rightButton.backgroundColor=[UIColor clearColor];
        [rightButton addTarget:self action:@selector(navigationRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        rightButton.bottom = self.height;
        
        leftLabel = [[UILabel alloc] initWithFrame:(CGRect){NAVIGATIONBAR_INTERVAL, point, NAVIGATIONBAR_BUTTON_WIDTH, buttonHeight}];
        leftLabel.backgroundColor = [UIColor clearColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.font = [UIFont boldSystemFontOfSize:NAVIGATIONBAR_BUTTON_FONT_SIZE];
        leftLabel.textColor=[UIColor blackColor];
        leftLabel.bottom = self.height;
        
        rightLabel=[[UILabel alloc] initWithFrame:(CGRect){0, point, NAVIGATIONBAR_BUTTON_WIDTH, buttonHeight}];
        rightLabel.left = frame.size.width - NAVIGATIONBAR_INTERVAL - NAVIGATIONBAR_BUTTON_WIDTH + 5;
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.font = [UIFont boldSystemFontOfSize:NAVIGATIONBAR_BUTTON_FONT_SIZE+2];
        rightLabel.textColor = [UIColor blackColor];
        rightLabel.bottom = self.height;

        [self addSubview:backGroundImgeView];
        [self addSubview:titleLabel];
        [self addSubview:leftButton];
        [self addSubview:rightButton];
        [self addSubview:rightLabel];
        [self addSubview:leftLabel];
        
        [rightButton setExclusiveTouch:YES];
        [leftButton setExclusiveTouch:YES];

        //custom init image
        backGroundImgeView.image = [UIImage imageNamed:@"bg_bottombar"];
    }
    return self;
}

- (void)navigationLeftButtonClick
{
    if (delegate && [delegate respondsToSelector:@selector(leftButtonClick)]) {
        [delegate leftButtonClick];
    }
}

- (void)navigationRightButtonClick
{
    if (delegate && [delegate respondsToSelector:@selector(rightButtonClick)]) {
        [delegate rightButtonClick];
    }
}

- (void)dealloc
{   
    if(backGroundImgeView != nil) {
        backGroundImgeView = nil;
    }
    
    if(titleLabel != nil) {
        titleLabel = nil;
    }
    
    if(leftButton != nil) {
        leftButton = nil;
    }
    
    if(rightButton != nil) {
        rightButton = nil;
    }
    
    if(rightLabel != nil) {
        rightLabel = nil;
    }
    
    if(leftLabel != nil) {
        leftLabel = nil;
    }
}

- (void)refershUI
{
    [backGroundImgeView setNeedsDisplay];
    [titleLabel setNeedsDisplay];
    [leftButton setNeedsDisplay];
    [rightLabel setNeedsDisplay];
    [rightButton setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self resize];
}

- (void)resize
{
    backGroundImgeView.bottom = self.height;
    
    leftButton.bottom = self.height;
    leftLabel.bottom = self.height;
    leftButton.left = 0;
    leftLabel.left = 0;
    
    titleLabel.bottom = self.height;
    
    rightButton.bottom = self.height;
    rightLabel.bottom = self.height;
    
    rightButton.right = self.width;
    rightLabel.right = self.width;
}

@end
