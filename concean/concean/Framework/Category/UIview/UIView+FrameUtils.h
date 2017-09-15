//
//  UIView+FrameUtils.h
//  SMZDM
//
//  Created by sunhaoming on 15/4/24.
//
//

#import <UIKit/UIKit.h>

typedef CGFloat UIScreenType;

static UIScreenType UIScreenType_iPhone6 = 375.0f;

@interface UIView (FrameUtils)
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

// shortcuts for positions
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (void)setLeft:(CGFloat)left right:(CGFloat)right;
- (void)setWidth:(CGFloat)width right:(CGFloat)right;
- (void)setTop:(CGFloat)top bottom:(CGFloat)bottom;
- (void)setHeight:(CGFloat)height bottom:(CGFloat)bottom;




// top, bottom, left, right
- (void)top:(CGFloat)top FromView:(UIView *)view;
- (void)bottom:(CGFloat)bottom FromView:(UIView *)view;
- (void)left:(CGFloat)left FromView:(UIView *)view;
- (void)right:(CGFloat)right FromView:(UIView *)view;

- (void)topRatio:(CGFloat)top FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)bottomRatio:(CGFloat)bottom FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)leftRatio:(CGFloat)left FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)rightRatio:(CGFloat)right FromView:(UIView *)view screenType:(UIScreenType)screenType;

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;

- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;

- (void)topEqualToView:(UIView *)view;
- (void)bottomEqualToView:(UIView *)view;
- (void)leftEqualToView:(UIView *)view;
- (void)rightEqualToView:(UIView *)view;

// imbueset
- (void)fillWidth;
- (void)fillHeight;
- (void)fill;

- (UIView *)topSuperView;

@end
