//
//  SMHomeAddOptionsView.m
//  SMZDM
//
//  Created by ZhangWenhui on 2017/6/16.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import "SMHomeAddOptionsView.h"

@interface SMHomeAddOptionsView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *viewContainer;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) NSMutableArray *arrayData;

@property (nonatomic, strong) UIImageView *imageViewArrow;

@property (nonatomic, assign) NSInteger index;

@end

@implementation SMHomeAddOptionsView

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
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

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)initialized
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4];
    self.clipsToBounds = YES;
    self.frame = [[UIScreen mainScreen] bounds];
    
    [self addSubview:self.viewContainer];
    [_viewContainer addSubview:self.listView];
    [self addSubview:self.imageViewArrow];
    
    [self my_resize];
    
    _index = -1;
    [self addTarget:self action:@selector(sm_removeFromSuperview:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)my_resize
{
    
}

- (void)sm_removeFromSuperview:(UIControl *)control
{
    if (self.optionSelectBlock) {
        if (control) {
            _optionSelectBlock(nil, SMHomeAddOptionsType_None);
        } else {
            NSDictionary *dictItem = _arrayData[_index];
            _optionSelectBlock(dictItem, (SMHomeAddOptionsType)[[dictItem objectForKey:kSMHomeAddOption_addOptionsType] integerValue]);
        }
        
        [UIView animateWithDuration:.1 animations:^{
            _viewContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.01);
            _imageViewArrow.alpha = 0.0;
            self.alpha = .0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (UIView *)viewContainer
{
    if (!_viewContainer) {
        _viewContainer = [[UIView alloc] initWithFrame:(CGRect){0, 0, 230.0 / 2.0, (80 + 1) * self.arrayData.count / 2.0}];
        _viewContainer.backgroundColor = kWhiteColor;
        _viewContainer.clipsToBounds = YES;
        _viewContainer.layer.cornerRadius = 5.0;
        
        _viewContainer.layer.anchorPoint = CGPointMake(1.0, 0.0);
    }
    return _viewContainer;
}

- (UITableView *)listView
{
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:_viewContainer.bounds];
        _listView.backgroundColor = kClearColor;
        _listView.scrollEnabled = NO;
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.layer.borderColor = kClearColor.CGColor;
    }
    return _listView;
}

- (UIImageView *)imageViewArrow
{
    if (!_imageViewArrow) {
        _imageViewArrow = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageViewArrow.backgroundColor = kClearColor;
        _imageViewArrow.image = [UIImage imageNamed:@"home_arrow"];
        _imageViewArrow.size = _imageViewArrow.image.size;
    }
    return _imageViewArrow;
}

- (NSMutableArray *)arrayData
{
    if (!_arrayData) {
        _arrayData = @[
                       
                       @{kSMHomeAddOption_imageName:@"home_addAttention",
                         kSMHomeAddOption_showName:@"加关注",
                         
                         kSMHomeAddOption_addOptionsType:@(SMHomeAddOptionsType_Follow),
                         
                         kSMHomeAddOption_eventLabel:@"关注",
                         kSMHomeAddOption_action:@"首页搜索栏"},
                       
                       @{kSMHomeAddOption_imageName:@"home_baoliao",
                         kSMHomeAddOption_showName:@"发爆料",
                         
                         kSMHomeAddOption_addOptionsType:@(SMHomeAddOptionsType_Broke),
                         
                         kSMHomeAddOption_eventLabel:@"好价爆料",
                         kSMHomeAddOption_action:@"首页搜索栏"},
                       
                       @{kSMHomeAddOption_imageName:@"icon-Original",
                         kSMHomeAddOption_showName:@"发原创",
                         
                         kSMHomeAddOption_addOptionsType:@(SMHomeAddOptionsType_PublishingOriginal),
                         
                         kSMHomeAddOption_eventLabel:@"好文发布",
                         kSMHomeAddOption_action:@"首页搜索栏"},
                       
                       @{kSMHomeAddOption_imageName:@"home_scan",
                         kSMHomeAddOption_showName:@"扫一扫",
                         
                         kSMHomeAddOption_addOptionsType:@(SMHomeAddOptionsType_QRCodeReader),
                         
                         kSMHomeAddOption_eventLabel:@"扫一扫",
                         kSMHomeAddOption_action:@"首页搜索栏"}
                       
                       ].mutableCopy;
    }
    return _arrayData;
}

//==========================================================
#pragma mark - UITableViewDataSource Method -
//==========================================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SMHomeAddOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SMHomeAddOptionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.dictData = _arrayData[indexPath.row];
    
    return cell;
}

//==========================================================
#pragma mark - UITableViewDelegate Method -
//==========================================================
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    _index = indexPath.row;
    [self sm_removeFromSuperview:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return the height of rows in the section.
    return (81.0 / 2.0);
}

- (void)sm_showInView:(UIView *)superView convertedFrame:(CGRect)frame;
{
    [superView addSubview:self];
    
    _imageViewArrow.centerX = CGRectGetMidX(frame);
    _imageViewArrow.top = CGRectGetMaxY(frame) + 10.0;
    
    _viewContainer.top = _imageViewArrow.bottom - kOnePixel_LINE;
    _viewContainer.right = self.width - 10.0;
    
    _viewContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
    self.alpha = .0;
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 1.0;
        _viewContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.03, 1.05);
        _imageViewArrow.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 animations:^{
            _viewContainer.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }];
}

@end

@interface SMHomeAddOptionsCell ()

@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) UILabel *labelShow;
@property (nonatomic, strong) UIImageView *separatorLine;

@property (nonatomic, strong) UIImageView *highlightedView;

@end

@implementation SMHomeAddOptionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self sm_initSubviews];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self sm_resize];
}

- (void)sm_initSubviews
{
    self.layer.borderColor = kClearColor.CGColor;
    self.contentView.layer.borderColor = kClearColor.CGColor;
    [self.contentView addSubview:self.imageViewIcon];
    [self.contentView addSubview:self.labelShow];
    [self.contentView addSubview:self.separatorLine];
    
    [self.contentView insertSubview:self.highlightedView atIndex:0];
    
    [self sm_resize];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        _highlightedView.backgroundColor = HEXColor(@"eeeeee");
    } else {
        _highlightedView.backgroundColor = kClearColor;
    }
}

- (void)sm_resize
{
    _labelShow.left = _imageViewIcon.right + 8.0;
    _labelShow.width = self.contentView.width - _labelShow.left;
    _labelShow.centerY = floor(self.contentView.height) / 2.0;
    
    _separatorLine.width = self.contentView.width;
    _separatorLine.bottom = self.contentView.height;
    
    _highlightedView.size = self.contentView.size;
}

- (UIImageView *)imageViewIcon
{
    if (!_imageViewIcon) {
        _imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageViewIcon.top = 8.0;
        _imageViewIcon.left = 18.0;
        _imageViewIcon.size = (CGSize){24.0, 24.0};
    }
    return _imageViewIcon;
}

- (UILabel *)labelShow
{
    if (!_labelShow) {
        _labelShow = [[UILabel alloc] initWithFrame:CGRectZero];
        _labelShow.backgroundColor = kClearColor;
        _labelShow.font = kZDM_HelveticaNeueMedium(15.0);
        _labelShow.textColor = HEXColor(@"333333");
    }
    return _labelShow;
}

- (UIImageView *)separatorLine
{
    if (!_separatorLine) {
        _separatorLine = [[UIImageView alloc] initWithFrame:CGRectZero];
        _separatorLine.backgroundColor = HEXColor(@"e2e2e2");
        _separatorLine.height = kOnePixel_LINE;
    }
    return _separatorLine;
}

- (UIImageView *)highlightedView
{
    if (!_highlightedView) {
        _highlightedView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _highlightedView.backgroundColor = kClearColor;
        _highlightedView.userInteractionEnabled = NO;
    }
    return _highlightedView;
}

- (void)setDictData:(NSDictionary *)dictData
{
    if (_dictData) {
        _dictData = nil;
    }
    _dictData = dictData;
    
    _imageViewIcon.image = [UIImage imageNamed:[_dictData objectForKey:kSMHomeAddOption_imageName]];
    _labelShow.text = [_dictData objectForKey:kSMHomeAddOption_showName];
    
    _labelShow.height = [_labelShow.text stringHeight:_labelShow.font];
    
    [self sm_resize];
}

@end
