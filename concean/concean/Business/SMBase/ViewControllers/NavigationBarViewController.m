//
//  NavigationBarViewController.m
//  MobileClass
//
//  Created by cyx on 13-3-19.
//  Copyright (c) 2013年 cyx. All rights reserved.
//

#import "NavigationBarViewController.h"
#import "SMHomeAddOptionsView.h"

@interface NavigationBarViewController () <UITextFieldDelegate>


@end

@implementation NavigationBarViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    navigationBar = [[NavigatonBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    navigationBar.delegate = self;
    navigationBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navigationBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameDidChange:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

-(void)statusBarFrameDidChange:(NSNotification *)notification
{
//    self.view.height = SCREEN_HEIGHT - (APP_STATUSBAR_HEIGHT - 20);
    [[NSNotificationCenter defaultCenter] postNotificationName:KSTATUSBAERCHANGE object:self userInfo:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    dataController.isListPush = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//==============================================================================
#pragma mark - public methods -
//==============================================================================
- (void)initSearchNavigationBarView
{
    navigationBar.backgroundColor = HEXColor(@"ffffff");
    [navigationBar showBottomShadow];
    //left
    //avigationBar.leftLabel.text = @"筛选";
    navigationBar.leftLabel.font = [UIFont boldSystemFontOfSize:13.0];
    if (DEVICE6P) {
        navigationBar.leftLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    navigationBar.leftLabel.textColor = HEXColor(@"333333");
    navigationBar.leftLabel.width = [@"筛选" stringWidth:navigationBar.leftLabel.font] + 2 * 15;
    
    navigationBar.leftButton.backgroundColor = kClearColor;
    navigationBar.leftButton.frame = navigationBar.leftLabel.frame;
    [navigationBar.leftButton setImage:[UIImage imageNamed:@"homePage_Filter"] forState:UIControlStateNormal];
    
    //center
//    UIImage *imageBG = [UIImage imageNamed:@"homePage_searchBG"];
//    UIImageView *imageViewBG = [[UIImageView alloc] initWithFrame:(CGRect){0, 0, navigationBar.width - 2 * navigationBar.leftLabel.width, imageBG.size.height}];
//    imageViewBG.userInteractionEnabled = YES;
//    imageViewBG.image = [imageBG resizableImage];
//    imageViewBG.centerX = navigationBar.width / 2;
//    imageViewBG.centerY = navigationBar.leftLabel.centerY;
//    [navigationBar addSubview:imageViewBG];
    UIView * centerV = [[UIView alloc]initWithFrame:(CGRect){0, 0, navigationBar.width - 2 * navigationBar.leftLabel.width, 30}];
    centerV.backgroundColor = [CommUtls colorWithHexString:@"#f9f9f9"];
    centerV.clipsToBounds = YES;
    centerV.layer.cornerRadius = 15;
    centerV.centerX = navigationBar.width / 2;
    centerV.centerY = navigationBar.leftLabel.centerY;
    centerV.tag = 1122;
    [navigationBar addSubview:centerV];

    
    UIImage *imageSearchIcon = [UIImage imageNamed:@"homePage_searchIcon"];
    UIButton *buttonSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSearch.frame = CGRectMake(0, 0, 35.0, centerV.height);
    [buttonSearch setImage:imageSearchIcon forState:UIControlStateNormal];
    [buttonSearch setImage:imageSearchIcon forState:UIControlStateSelected];
    [buttonSearch setImage:imageSearchIcon forState:UIControlStateHighlighted];
    [buttonSearch addTarget:self action:@selector(baseButtonSearchClick:) forControlEvents:UIControlEventTouchUpInside];
    buttonSearch.backgroundColor = kClearColor;
    [centerV addSubview:buttonSearch];
    
    //扫一扫
//    UIImage *imageScan = [UIImage imageNamed:@"homePage_scan"];
//    UIButton *buttonScan = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonScan.frame = CGRectMake(0, 0, 2 * 8 + imageScan.size.width, centerV.height);
//    [buttonScan setImage:imageScan forState:UIControlStateNormal];
//    [buttonScan setImage:imageScan forState:UIControlStateSelected];
//    [buttonScan setImage:imageScan forState:UIControlStateHighlighted];
//    [buttonScan addTarget:self action:@selector(baseButtonScan:) forControlEvents:UIControlEventTouchUpInside];
//    buttonScan.right = centerV.width-5;
//    buttonScan.backgroundColor = kClearColor;
//    [centerV addSubview:buttonScan];
    
    //输入框
    UITextField *textField_Search = [[UITextField alloc] initWithFrame:(CGRect){buttonSearch.right, 1, centerV.width - buttonSearch.right, centerV.height - 2}];
    textField_Search.runtimeIndex = 10;
    textField_Search.delegate = self;
    textField_Search.backgroundColor = kClearColor;
    textField_Search.font = [UIFont systemFontOfSize:14.0];
    if (DEVICE6P) {
        textField_Search.font = [UIFont systemFontOfSize:15.0];
    }
//    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:[dataController isSearchHolder] attributes:@{NSFontAttributeName: textField_Search.font, NSForegroundColorAttributeName: HEXColor(@"666666")}];
//    textField_Search.attributedPlaceholder = attributedPlaceholder;
    NSString * placeHolder= @"";
    NSArray * array = [[NSUserDefaults standardUserDefaults] valueForKey:@"HOME_SEARCH_WORDS"];//首页搜索框默认词
    if (array.count) {
        placeHolder = safeString(array[0][@"keyword"]);
    }
    if (placeHolder.length<1) {
        placeHolder = @"搜索";
    }
    textField_Search.placeholder = placeHolder;
    textField_Search.backgroundColor = kClearColor;
    [centerV addSubview:textField_Search];
    
    //right
    //navigationBar.rightLabel.text = @"关注";
    navigationBar.rightLabel.font = [UIFont systemFontOfSize:13.0];
    if (DEVICE6P) {
        navigationBar.rightLabel.font = [UIFont systemFontOfSize:14.0];
    }
    navigationBar.rightLabel.width = [@"关注" stringWidth:navigationBar.rightLabel.font] + 2 * 15;
    navigationBar.rightLabel.right = navigationBar.width;
    
    navigationBar.rightButton.frame = navigationBar.rightLabel.frame;
    //navigationBar.rightButton.imageEdgeInsets = UIEdgeInsetsMake(8, 18, 15, 15/2);
    //[navigationBar.rightButton setImage:[UIImage imageNamed:@"homeAdd"] forState:UIControlStateNormal];
    [navigationBar.rightButton removeTarget:navigationBar action:NULL forControlEvents:UIControlEventTouchUpInside];
    [navigationBar.rightButton addTarget:self action:@selector(buttonAdd:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView_add = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView_add.image = [UIImage imageNamed:@"homeAdd"];
    imageView_add.size = imageView_add.image.size;
    [navigationBar.rightButton addSubview:imageView_add];
    [navigationBar.rightButton clipsToBounds];
    imageView_add.center = (CGPoint){navigationBar.rightButton.width / 2.0, navigationBar.rightButton.height / 2.0};
    imageView_add.tag = 100;
    [self sm_setAssociateValue:textField_Search withKey:@"textField_Search"];

}

- (void)initNormalNavigationBarView {
    
    navigationBar.backgroundColor = [UIColor whiteColor];
    navigationBar.delegate = self;
    
    navigationBar.titleLabel.textColor = HEXColor(@"333333");
    
    [navigationBar.leftButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [navigationBar.leftButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];

    [navigationBar showBottomShadow];
    
    [self.view bringSubviewToFront:navigationBar];


    
}


- (void) setNavigationBarRightLabelText:(NSString *) text {

    
    navigationBar.rightButton.width = 72;
    navigationBar.rightButton.left = SCREEN_WIDTH - navigationBar.rightButton.width;
    [navigationBar.rightButton setTitle:text forState:UIControlStateNormal];
    navigationBar.rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [navigationBar.rightButton setTitleColor:navigationBar.titleLabel.textColor forState:UIControlStateNormal];
    
}

//==============================================================================
#pragma mark - UITextFieldDelegate -
//==============================================================================
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.runtimeIndex != 10) {
        return YES;
    }
    if (self.baseCenterBlock) {
        _baseCenterBlock ();
    }
    return NO;
}

//==============================================================================
#pragma mark - enent response -
//==============================================================================
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)baseButtonSearchClick:(UIButton *)button
{
    if (self.baseCenterBlock) {
        _baseCenterBlock ();
    }
}

- (void)baseButtonScan:(UIButton *)button
{
    if (self.baseScanBlock) {
        _baseScanBlock ();
    }
}

- (void)baseButtonGoodArticlePublish:(UIButton *)button
{
    if (self.goodArticlePublishBlock) {
       _goodArticlePublishBlock();
    }
}

- (void)buttonAdd:(UIButton *)button
{
    NSLog(@"buttonAdd:");
    UIImageView *view = (UIImageView *)[button viewWithTag:100];
    [self sm_addImageViewAnimate:YES withView:view];
    
//    NSString *category = @"";
//    NSString *action = @"首页搜索栏";
//    NSString *eventLabel = @"加号";
//    if (self.sm_index == 1) {
//        category = @"首页";
//    } else if (self.sm_index == 2) {
//        category = @"好价";
//    } else if (self.sm_index == 3) {
//        category = @"好物";
//    } else if (self.sm_index == 4) {
//        category = @"好文首页";
//    }
//    if ([category isSafeString]) {
//        [GTMObject pushEventName:@"trackEvent" andCategory:category andAction:action andEventLabel:eventLabel];
//    }
}

- (void)sm_addImageViewAnimate:(BOOL)rotation withView:(UIView *)view
{
    if (view) {
        [UIView animateWithDuration:.25 animations:^{
            if (!CGAffineTransformEqualToTransform(view.transform,CGAffineTransformIdentity)){
                view.transform = CGAffineTransformMakeRotation(M_PI_4);
            } else {
                view.transform = CGAffineTransformIdentity;
            }
        }];
    }
    
    if (rotation) {
        
        
        SMHomeAddOptionsView *optionsView = [[SMHomeAddOptionsView alloc] init];
        @smWeak(view);
        @smWeak(self);
        optionsView.optionSelectBlock = ^(NSDictionary *dictData, SMHomeAddOptionsType optionsType) {
            NSLog(@"%@,%ld",dictData, optionsType);
            @smStrong(view);
            @smStrong(self);
            [UIView animateWithDuration:.25 animations:^{
                view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (optionsType != SMHomeAddOptionsType_None) {
                    [self sm_JumpProcess:optionsType dictItem:dictData];
                }
            }];
        };
        UIView *superview = [[UIApplication sharedApplication] keyWindow];
        CGRect convertedFrame = [view.superview convertRect:view.frame toView:superview];
        [optionsView sm_showInView:superview convertedFrame:convertedFrame];
    } else {
        
    }
}

- (void)sm_JumpProcess:(SMHomeAddOptionsType)optionsType dictItem:(NSDictionary *)dictItem
{
    NSString *category = @"";
    NSString *action = safeString([dictItem objectForKey:kSMHomeAddOption_action]);
    NSString *eventLabel = safeString([dictItem objectForKey:kSMHomeAddOption_eventLabel]);
    
    if (self.sm_index == 1) {
        category = @"首页";
    } else if (self.sm_index == 2) {
        category = @"好价";
    } else if (self.sm_index == 3) {
        category = @"好物";
    } else if (self.sm_index == 4) {
        category = @"好文首页";
    }
    
    switch (optionsType) {
        case SMHomeAddOptionsType_Follow:
        {//添加关注-链接至当前App内“新增关注”页面
            break;
        }
        case SMHomeAddOptionsType_Broke:
        {//发爆料-连接至当前app内“爆料好价”页面
            break;
        }
        case SMHomeAddOptionsType_QRCodeReader:
        {//扫一扫
            [self baseButtonScan:nil];
            break;
        }
        case SMHomeAddOptionsType_PublishingOriginal:
        {//好文发布
            [self baseButtonGoodArticlePublish: nil];
            break;
        }
        default:
            break;
    }
}

/**
 设置筛选、搜索框、+ 等空间的透明度
 
 @param sm_alpha 透明度比例
 */
- (void)sm_setAlpha:(CGFloat)sm_alpha
{
    navigationBar.leftButton.alpha = sm_alpha;
    navigationBar.rightButton.alpha = sm_alpha;
    UIView *view = (UIView *)[navigationBar viewWithTag:1122];
    view.alpha = sm_alpha;
}

- (void)leftButtonClick {
    [kNavigationController xPopViewControllerAnimated:YES];
}

@end
