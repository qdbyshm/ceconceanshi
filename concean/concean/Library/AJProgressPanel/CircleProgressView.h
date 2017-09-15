//
//  CircleProgressView.h
//  MobileSchool
//
//  Created by  cdel_gaolei on 10/30/13.
//  Copyright (c) 2013 feng zhanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView

/**
 * Progress (0.0 to 1.0)
 */
@property (nonatomic, assign) float progress;

/**
 * Indicator progress color.
 * Defaults to white [UIColor whiteColor]
 */
@property (nonatomic, retain) UIColor *progressTintColor;

/**
 * Indicator background (non-progress) color.
 * Defaults to translucent white (alpha 0.1)
 */
@property (nonatomic, retain) UIColor *backgroundTintColor;

/*
 * Display mode - NO = round or YES = annular. Defaults to round.
 */
@property (nonatomic, assign, getter = isAnnular) BOOL annular;


@end
