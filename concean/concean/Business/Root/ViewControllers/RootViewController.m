//
//  RootViewController.m
//  SMZDM
//
//  Created by sunhaoming on 15/6/9.
//
//

#import "RootViewController.h"
@interface RootViewController ()

@end


@implementation RootViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFMbool = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    
    self.seletedN = 1;
    [self.view setBackgroundColor:[CommUtls colorWithHexString:@"#fafafa"]];
    
    //底部 bar
    _mainToolBar = [[MainToolBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - KMAINTOOLBARHIGHT, SCREEN_WIDTH, KMAINTOOLBARHIGHT)];
    _mainToolBar.autoresizingMask =   UIViewAutoresizingFlexibleTopMargin;
    [_mainToolBar showTopShadow];
    _mainToolBar.delegate = self;
    [self.view addSubview:_mainToolBar];
    [self.view bringSubviewToFront:_mainToolBar];
    [self mainView];
    [self seletedNum:1];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    switch (self.seletedN) {
        case 1:
        {
            [_homePageViewController viewWillAppear:animated];
            
        }
            
            break;
        case 3:
            [_videoPageViewContoller viewWillAppear:animated];
            break;
        case 2:
            [_mallPageViewContoller  viewWillAppear:animated];
            break;
        case 4:
            [_storePageViewContoller viewWillAppear:animated];
            break;
            
        case 5:
            [_userCenterPageViewContoller viewWillAppear:animated];
            break;
            
        default:
            break;
    }
    [_mainToolBar setSelectIndex:self.seletedN];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    switch (self.seletedN) {
        case 1:
            [_homePageViewController viewDidAppear:animated];
            break;
        case 3:
            [_videoPageViewContoller viewDidAppear:animated];
            break;
        case 2:
            [_mallPageViewContoller  viewDidAppear:animated];
            break;
        case 4:
            [_storePageViewContoller viewDidAppear:animated];
            break;
            
        case 5:
            [_userCenterPageViewContoller viewDidAppear:animated];
            break;
            
        default:
            break;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    switch (self.seletedN) {
        case 1:
            [_homePageViewController viewWillDisappear:animated];
            
            break;
        case 3:
            [_videoPageViewContoller viewWillDisappear:animated];
            break;
        case 2:
            [_mallPageViewContoller  viewWillDisappear:animated];
            break;
        case 4:
            [_storePageViewContoller viewWillDisappear:animated];
            break;
            
        case 5:
            [_userCenterPageViewContoller viewWillDisappear:animated];
            break;
            
        default:
            break;
    }
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    switch (self.seletedN) {
        case 1:
            [_homePageViewController viewDidDisappear:animated];
            
            break;
        case 3:
            [_videoPageViewContoller viewDidDisappear:animated];
            break;
        case 2:
            [_mallPageViewContoller  viewDidDisappear:animated];
            break;
        case 4:
            [_storePageViewContoller viewDidDisappear:animated];
            break;
            
        case 5:
            [_userCenterPageViewContoller viewDidDisappear:animated];
            break;
            
        default:
            break;
    }
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.view.top = 0;
    self.view.height = SCREEN_HEIGHT - (APP_STATUSBAR_HEIGHT - 20);
    _mainToolBar.bottom = self.view.height;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.view.top = 0;
    self.view.height = SCREEN_HEIGHT - (APP_STATUSBAR_HEIGHT - 20);
    _mainToolBar.bottom = self.view.height;
}

#pragma mark - 首页
- (void)mainView
{
    if (!_homePageViewController) {
        _homePageViewController = [[CCHomeViewController alloc] init];
  
        [_homePageViewController.view setFrame:CGRectMake(0, 0, self.view.width, self.view.height - KMAINTOOLBARHIGHT)];
        
        [self.view addSubview:_homePageViewController.view];
        
        [self.view bringSubviewToFront:_mainToolBar];
    }
}

#pragma mark - 底部tabbar
- (void)seletedNum:(int )num
{
    switch (num) {
        case 1:
        {
            if (!_homePageViewController) {
                _homePageViewController = [[CCHomeViewController alloc] init];
                [_homePageViewController.view setFrame:CGRectMake(0, 0, self.view.width, self.view.height - KMAINTOOLBARHIGHT)];
                [self.view addSubview:_homePageViewController.view];
                [self.view bringSubviewToFront:_mainToolBar];
            }
            break;
        }
        case 2:
        {
            if (!_mallPageViewContoller) {
                _mallPageViewContoller = [[CCMallViewController alloc] init];
                [_mallPageViewContoller.view setFrame:CGRectMake(0, 0, self.view.width, self.view.height - KMAINTOOLBARHIGHT)];
                [self.view addSubview:_mallPageViewContoller.view];
                [self.view bringSubviewToFront:_mainToolBar];
            }
            break;
        }
        case 3:
        {
            if (!_videoPageViewContoller) {
                _videoPageViewContoller = [[CCVideoRecomViewController alloc] init];
                [_videoPageViewContoller.view setFrame:CGRectMake(0, 0, self.view.width, self.view.height - KMAINTOOLBARHIGHT)];
                [self.view addSubview:_videoPageViewContoller.view];
                [self.view bringSubviewToFront:_mainToolBar];
            }
            break;
        }
        case 4:
        {
            if (!_storePageViewContoller) {
                _storePageViewContoller = [[CCStoreViewController alloc] init];
                [_storePageViewContoller.view setFrame:CGRectMake(0, 0, self.view.width, self.view.height - KMAINTOOLBARHIGHT)];
                [self.view addSubview:_storePageViewContoller.view];
                [self.view bringSubviewToFront:_mainToolBar];
            }
            break;
        }
        case 5:
        {
            if (!_userCenterPageViewContoller) {
                _userCenterPageViewContoller = [[CCUserCenterViewController alloc] init];
                [_userCenterPageViewContoller.view setFrame:CGRectMake(0, 0, self.view.width, self.view.height - KMAINTOOLBARHIGHT)];
                [self.view addSubview:_userCenterPageViewContoller.view];
                [self.view bringSubviewToFront:_mainToolBar];
            }
            break;
        }
    
        default:
            break;
    }
    [self hiddenAllControllesView:num];
    self.seletedN = num;
    [_mainToolBar setSelectIndex:self.seletedN];
    [self setNeedsStatusBarAppearanceUpdate];
    [self appear:YES];
}

- (void)appear:(BOOL)animated
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    [array addSafeObjectOfNavigationVC:_homePageViewController];
    [array addSafeObjectOfNavigationVC:_mallPageViewContoller];
    [array addSafeObjectOfNavigationVC:_videoPageViewContoller];
    [array addSafeObjectOfNavigationVC:_storePageViewContoller];
    [array addSafeObjectOfNavigationVC:_userCenterPageViewContoller];
    
    if (_mainToolBar.lastNum == self.seletedN) {
        return;
    }
    if (self.seletedN<=5&&_mainToolBar.lastNum<=5) {
        [(NavigationBarViewController *)[array objectAtIndex:self.seletedN-1] viewWillAppear:animated];
        [(NavigationBarViewController *)[array objectAtIndex:self.seletedN-1] viewDidAppear:animated];
        
        [(NavigationBarViewController *)[array objectAtIndex:_mainToolBar.lastNum-1] viewWillDisappear:animated];
        [(NavigationBarViewController *)[array objectAtIndex:_mainToolBar.lastNum-1] viewDidDisappear:animated];
    }
    
}

- (void)hiddenAllControllesView:(int)selentint
{
    if (_homePageViewController) {
        _homePageViewController.view.hidden = YES;
    }
    
    if (_mallPageViewContoller) {
        _mallPageViewContoller.view.hidden = YES;
    }
    
    if (_videoPageViewContoller) {
        _videoPageViewContoller.view.hidden = YES;
    }
    
    if (_storePageViewContoller) {
        _storePageViewContoller.view.hidden = YES;
    }
    
    if (_userCenterPageViewContoller) {
        _userCenterPageViewContoller.view.hidden = YES;
    }
 
    switch (selentint) {
        case 1:
            _homePageViewController.view.hidden = NO;

            break;
        case 2:
            _mallPageViewContoller.view.hidden = NO;

            break;
        case 3:
            _videoPageViewContoller.view.hidden = NO;

            break;
        case 4:
            _storePageViewContoller.view.hidden = NO;

            break;
        case 5:
            _userCenterPageViewContoller.view.hidden = NO;

            break;
            
        default:
            break;
    }

}

@end
