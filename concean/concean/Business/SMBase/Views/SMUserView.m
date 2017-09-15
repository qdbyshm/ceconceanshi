//
//  SMUserView.m
//  SMZDM
//
//  Created by ZhangWenhui on 2017/9/4.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "SMUserView.h"

@interface SMUserView ()

@property (nonatomic, strong) UIImageView *sm_imageView;
@property (nonatomic, strong) UILabel *sm_label;

@end

@implementation SMUserView

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialized];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialized];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialized];
    }
    return self;
}

- (void)initialized
{
    self.clipsToBounds = YES;
    
    _sm_maxWidth = 0.0;
    _sm_space = 10.0;
    
    [self sm_imageView];
    [self sm_label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self my_resize];
}

- (void)my_resize
{
    _sm_imageView.centerY = self.height / 2.0;
    
    _sm_label.centerY = _sm_imageView.centerY;
}

- (UIImageView *)sm_imageView
{
    if (!_sm_imageView) {
        _sm_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _sm_imageView.size = (CGSize){20.0, 20.0};
        _sm_imageView.backgroundColor = [UIColor clearColor];
        _sm_imageView.layer.masksToBounds = YES;
        _sm_imageView.layer.cornerRadius = _sm_imageView.height / 2.0;
        _sm_imageView.clipsToBounds = YES;
        _sm_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_sm_imageView];
    }
    
    return _sm_imageView;
}

- (UILabel *)sm_label
{
    if (!_sm_label) {
        _sm_label = [[UILabel alloc] initWithFrame:CGRectZero];
        _sm_label.backgroundColor = [UIColor clearColor];
        _sm_label.font = [UIFont systemFontOfSize:12];
        _sm_label.textColor = HEXColor(@"888888");
        _sm_label.height = [@"EjJgGP" stringHeight:_sm_label.font];
        _sm_label.lineBreakMode = NSLineBreakByTruncatingTail;
        _sm_label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_sm_label];
    }
    return _sm_label;
}

//==============================================================================
#pragma mark - setter -
//==============================================================================
- (void)setSm_maxWidth:(CGFloat)sm_maxWidth
{
    _sm_maxWidth = sm_maxWidth;
    
    [self sm_sizeToFit];
}

- (void)setSm_space:(CGFloat)sm_space
{
    if (sm_space <= 0) {
        sm_space = 0;
    }
    _sm_space = sm_space;
    
    [self sm_sizeToFit];
}

- (void)setSm_image:(UIImage *)sm_image
{
    _sm_image = sm_image;
    
    _sm_imageView.image = _sm_image;
    
    [self sm_sizeToFit];
}

- (void)setSm_imageUrl:(NSURL *)sm_imageUrl
{
    _sm_imageUrl = sm_imageUrl;
    
    if (!isSafeObj(_sm_imageUrl)) {
        _sm_imageView.image = nil;
        return;
    }
    
    if (![_sm_imageUrl isKindOfClass:[NSURL class]]) {
        _sm_imageView.image = nil;
        return;
    }
//    
////    [_sm_imageView sd_setImageWithURL:_sm_imageUrl placeholderImage:[UIImage imageNamed:[CommUtls getAvatarString]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        
//    }];
    
    [self sm_sizeToFit];
}

- (void)setSm_imageSize:(CGSize)sm_imageSize
{
    _sm_imageSize = sm_imageSize;
    
    _sm_imageView.size = _sm_imageSize;
    _sm_imageView.layer.cornerRadius = _sm_imageView.height / 2.0;
    
    [self sm_sizeToFit];
}

- (void)setSm_title:(NSString *)sm_title
{
    _sm_title = sm_title;
    
    _sm_label.text = _sm_title;
    
    if (isSafeString(_sm_title)) {
        _sm_label.width = [_sm_title stringWidth:_sm_label.font];
    } else {
        _sm_label.width = 0.0;
    }
    
    [self sm_sizeToFit];
}

- (void)sm_sizeToFit
{
    _sm_label.left = _sm_imageView.right + _sm_space;
    
    CGFloat sm_width = 0.0;
    if (isSafeString(_sm_label.text)) {
        sm_width = _sm_imageView.width + _sm_space + _sm_label.width;
    } else {
        sm_width = _sm_imageView.width;
    }
    
    if (_sm_maxWidth > 0) {
        sm_width = MIN(sm_width, _sm_maxWidth);
    }
    
    if (_sm_label.right > sm_width) {
        _sm_label.width = sm_width - _sm_label.left;
    }
    
    self.width = sm_width;
}

@end
