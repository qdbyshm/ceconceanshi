//
//  BaseViewController.m
//  MobileSchool
//
//  Created by zhanbo on 13-10-11.
//  Copyright (c) 2013年 feng zhanbo. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "SMZDMShareInstance.h"

@interface BaseViewController ()
{
}
@end

@implementation BaseViewController

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
	// Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.sm_index = -1;
    
    //self.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth;
    
    dataController = [AppDelegate getAppDelegate].dataController;
    self.view.backgroundColor = [CommUtls colorWithHexString:@"f8f8f8"];
    
    [self initData];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if ([SMZDMShareInstance shareInstance].refreshHeaderView) {
        [[SMZDMShareInstance shareInstance].refreshHeaderView addLayersAnimations];
    }
    
    if ([SMZDMShareInstance shareInstance].refreshFooterView) {
        [[SMZDMShareInstance shareInstance].refreshFooterView addLayersAnimations];
    }
    if ([SMZDMShareInstance shareInstance].circleView) {
        [[SMZDMShareInstance shareInstance].circleView addCircleAnimal];
    }
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

- (void)dealloc
{
    NSLog(@"-[%@ dealloc]",NSStringFromClass([self class]));
}

- (void)initData
{
    
}

- (void)initView
{
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}


- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
 
    return UIStatusBarStyleDefault;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
