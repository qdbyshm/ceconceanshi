//
//  UISMZDMRefreshHeaderView.m
//  MJRefreshProject
//
//  Created by ZhangWenhui on 15/9/6.
//  Copyright (c) 2015年 ZhangWenhui. All rights reserved.
//

#import "UISMZDMRefreshHeaderView.h"
#import "CircleProgressView.h"
#import "SMZDMShareInstance.h"
#import "NSDate+Additons.h"
#define kMainScreenSize [[UIScreen mainScreen] bounds].size
#define kMainScreenWidth    kMainScreenSize.width
#define kMainScreenHeight    kMainScreenSize.height

@interface UISMZDMRefreshHeaderView ()

@property (nonatomic, strong) CircleProgressView *circleProgressView;
@property (nonatomic, strong) UIImageView *imageViewLogo;
@property (nonatomic, strong) UIImageView *imageViewSemicircle;
@property (nonatomic, strong) UILabel *labelState;
@property (nonatomic,copy)    NSString * freshtip;
@property (nonatomic, strong) UIImageView *aImageView;

@end

@implementation UISMZDMRefreshHeaderView
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 60;
    
    [self labelState];
    [self imageViewLogo];
    [self imageViewSemicircle];
    [self circleProgressView];
}

- (void)setHasImageFresh:(BOOL)hasImageFresh
{
    _hasImageFresh = hasImageFresh;
    if (_hasImageFresh) {
        self.clipsToBounds = NO;
        [self aImageView];
    }
}
- (void)beginRefreshing
{
    if (self.state==MJRefreshStateRefreshing) {
        
    } else {
        [super beginRefreshing];
    }
}
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    _imageViewLogo.centerX = self.width / 2;
    _imageViewLogo.bottom = self.height - 5;
    _labelState.width = self.width;
    _labelState.centerX = self.width / 2;
    _labelState.bottom = _imageViewLogo.top - 5;
    
    if (_hasImageFresh) {
        _aImageView.width = self.width;
        _aImageView.height = kMainScreenHeight;
        _aImageView.bottom = self.height;
    }
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
        {
            _labelState.text = self.freshtip;


            [self stopAnimations];
            _imageViewSemicircle.hidden = YES;
            _circleProgressView.hidden = NO;
            [SMZDMShareInstance shareInstance].refreshHeaderView = nil;
            break;
        }
        case MJRefreshStatePulling:
        {
            

            _labelState.text = self.freshtip;
            [SMZDMShareInstance shareInstance].refreshHeaderView = nil;
            [self stopAnimations];
            break;
        }
        case MJRefreshStateRefreshing:
        {

            _labelState.text = self.freshtip;

            _circleProgressView.hidden = YES;
            _imageViewSemicircle.hidden = NO;
            [self addLayersAnimations];
            [SMZDMShareInstance shareInstance].refreshHeaderView = self;
            break;
        }
        default:
        {
            break;
        }
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    if (_circleProgressView.hidden) {
        _circleProgressView.hidden = NO;
        _imageViewSemicircle.hidden = YES;
    }
    if (!_circleProgressView) {//
        [self circleProgressView];
    }
    if (pullingPercent - 1 < 0) {
    }
    _circleProgressView.progress = pullingPercent;
}

#pragma mark - private -

- (void)addLayersAnimations
{
    [self stopAnimations];
    
    _imageViewSemicircle.hidden = NO;
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO; 
    
    [_imageViewSemicircle.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopAnimations
{
    [_imageViewSemicircle.layer removeAllAnimations];
}

//==========================================================
#pragma mark - 16进制颜色 -
//==========================================================
#define HEXCOLOR_0X(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

- (CircleProgressView *)circleProgressView
{
    if (!_circleProgressView) {
        _circleProgressView = [[CircleProgressView alloc] initWithFrame:(CGRect){0, 0, _imageViewSemicircle.mj_size}];
        _circleProgressView.annular = YES;
        _circleProgressView.progressTintColor = HEXCOLOR_0X(0xF04949);
        [_imageViewLogo addSubview:_circleProgressView];
    }
    return _circleProgressView;
}

- (UIImageView *)imageViewLogo
{
    if (!_imageViewLogo) {
        _imageViewLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhi"]];
        _imageViewLogo.backgroundColor = [UIColor clearColor];
        _imageViewLogo.mj_size = _imageViewLogo.image.size;
        _imageViewLogo.mj_x = (self.mj_w - _imageViewLogo.mj_w) / 2;
        _imageViewLogo.mj_y = (self.mj_h - _imageViewLogo.mj_h) / 2;
        [self addSubview:_imageViewLogo];
    }
    return _imageViewLogo;
}

- (UIImageView *)imageViewSemicircle
{
    if (!_imageViewSemicircle) {
        _imageViewSemicircle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle"]];
        _imageViewSemicircle.mj_size = _imageViewSemicircle.image.size;
        _imageViewSemicircle.backgroundColor = [UIColor clearColor];
        _imageViewSemicircle.hidden = YES;
        [_imageViewLogo addSubview:_imageViewSemicircle];
    }
    return _imageViewSemicircle;
}

- (UILabel *)labelState
{
    if (!_labelState) {
        _labelState = [[UILabel alloc] initWithFrame:CGRectZero];
        _labelState.font = [UIFont systemFontOfSize:14.0];
        _labelState.width = self.width;
        _labelState.textAlignment = NSTextAlignmentCenter;
        _labelState.textColor = [UIColor grayColor];
        _labelState.text = self.freshtip;
        _labelState.height = _labelState.font.pointSize * 1.3;
        [self addSubview:_labelState];
    }
    return _labelState;
}

- (UIImageView *)aImageView
{
    if (!_aImageView)
    {
        _aImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _aImageView.backgroundColor = kClearColor;
        [self insertSubview:_aImageView atIndex:0];
        
        
        NSString *filePath1=[NSString stringWithFormat:@"%@/%@.png",MAINDBPATH,@"Rrefh/refreshPING"];
        NSString *filePath=[NSString stringWithFormat:@"%@/%@.plist",MAINDBPATH,@"refresh"];
        NSDictionary * dic1 = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        if([dic1 valueForKey:@"start_date"]&&[dic1 valueForKey:@"end_date"])
        {
            NSDate * date = [NSDate date];
            NSDate *date1 = [CommUtls dencodeTime:[dic1 valueForKey:@"start_date"]];
            NSDate *date2 = [CommUtls dencodeTime:[dic1 valueForKey:@"end_date"]];
            if([date secondsAfterDate:date2]>0)
            {
                NSFileManager *file_manager = [NSFileManager defaultManager];
                if ([file_manager fileExistsAtPath:filePath1]) {
                    [file_manager  removeItemAtPath:filePath1 error:nil];
                }
            }
            if ([date timeIntervalSinceDate:date2]<0&&[date timeIntervalSinceDate:date1]>0) {
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:filePath1])
                {
                    [_aImageView setImage:[UIImage imageWithContentsOfFile:filePath1]];
                }
            }
        }
    }
    return _aImageView;
}

@end
