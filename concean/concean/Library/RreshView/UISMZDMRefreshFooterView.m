//
//  UISMZDMRefreshFooterView.m
//  MJRefreshProject
//
//  Created by ZhangWenhui on 15/9/6.
//  Copyright (c) 2015年 ZhangWenhui. All rights reserved.
//

#import "UISMZDMRefreshFooterView.h"
#import "SMZDMShareInstance.h"
#import "CircleProgressView.h"

@interface UISMZDMRefreshFooterView ()

@property (nonatomic, strong) CircleProgressView *circleProgressView;
@property (nonatomic, strong) UIImageView *imageViewLogo;
@property (nonatomic, strong) UIImageView *imageViewSemicircle;
@property (nonatomic, strong) UILabel *labelState;

@end

@implementation UISMZDMRefreshFooterView

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 60;
    self.automaticallyHidden = YES;
    self.triggerAutomaticallyRefreshPercent = -13;
    
    [self labelState];
    [self imageViewLogo];
    [self imageViewSemicircle];
    [self circleProgressView];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    _imageViewLogo.centerX = self.width / 2;
    _imageViewLogo.top = 5;
    _labelState.width = self.width;
    _labelState.centerX = self.width / 2;
    _labelState.top = _imageViewLogo.bottom + 5;
}

- (void)noticeNoMoreData
{
    [super noticeNoMoreData];
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.scrollView.contentInset = edgeInsets;
    }];
}

- (void)beginRefreshing
{
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom = self.height;
    [UIView animateWithDuration:.25 animations:^{
        self.scrollView.contentInset = edgeInsets;
    }];
    [super beginRefreshing];
}

- (void)endRefreshingWithNoMoreData
{
    [super endRefreshingWithNoMoreData];
    
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.scrollView.contentInset = edgeInsets;
    }];
}

- (void)endRefreshing
{
    [super endRefreshing];
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
    // 设置位置
//    self.mj_y = MAX(self.scrollView.mj_contentH, self.scrollView.height - self.scrollView.contentInset.top);

}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
    if (self.state != MJRefreshStateNoMoreData) {
        UIEdgeInsets edgeInsets = self.scrollView.contentInset;
        edgeInsets.bottom = self.height;
        [UIView animateWithDuration:.25 animations:^{
            self.scrollView.contentInset = edgeInsets;
        }];
    }
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
        {
            _labelState.text = @"";
            [self stopAnimations];
            [SMZDMShareInstance shareInstance].refreshFooterView = nil;

            break;
        }
        case MJRefreshStatePulling:
        {
            _labelState.text = @"";
            [self stopAnimations];
            [SMZDMShareInstance shareInstance].refreshFooterView = nil;
            
            break;
        }
        case MJRefreshStateRefreshing:
        {
            _labelState.text = @"";
            _circleProgressView.hidden = YES;
            _imageViewSemicircle.hidden = NO;
            [self addLayersAnimations];
            [SMZDMShareInstance shareInstance].refreshFooterView = self;
            
            break;
        }
        case MJRefreshStateNoMoreData:
        {
            [self stopAnimations];
            _labelState.text = @"没有了哦";
            [SMZDMShareInstance shareInstance].refreshFooterView = nil;
            
            break;
        }
        default:
        {
            [SMZDMShareInstance shareInstance].refreshFooterView = nil;
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

- (CircleProgressView *)circleProgressView
{
    if (!_circleProgressView) {
        _circleProgressView = [[CircleProgressView alloc] initWithFrame:(CGRect){0, 0, _imageViewSemicircle.mj_size}];
        _circleProgressView.annular = YES;
        _circleProgressView.progressTintColor = [UIColor HEXColor:@"F04949"];
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
        _labelState.text = @"";
        _labelState.height = _labelState.font.pointSize * 1.3;
        [self addSubview:_labelState];
    }
    return _labelState;
}

//==============================================================================
#pragma mark - public methods -
//==============================================================================
- (void)hiddenSomeView:(BOOL)hidden
{
    _circleProgressView.hidden = hidden;
    _imageViewLogo.hidden = hidden;
    _imageViewSemicircle.hidden = hidden;
    _labelState.hidden = hidden;
}

@end
