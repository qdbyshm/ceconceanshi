//
//  RootViewController.h
//  SMZDM
//
//  Created by sunhaoming on 15/6/9.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MainToolBar.h"
#import "CCHomeViewController.h"
#import "CCVideoRecomViewController.h"
#import "CCMallViewController.h"
#import "CCStoreViewController.h"
#import "CCUserCenterViewController.h"

#define isAppVersion7

@interface RootViewController : BaseViewController<MAINTOOLBARDELEGATE>
{
    BOOL isFMbool;
}
@property (nonatomic, assign)int seletedN;
@property (nonatomic, strong)MainToolBar *mainToolBar;
/**
 *  首页
 */
@property (nonatomic, strong) CCHomeViewController *homePageViewController;

/**
 *  直播
 */
@property (nonatomic, strong) CCVideoRecomViewController *videoPageViewContoller;

/**
 *  商城
 */
@property (nonatomic, strong) CCMallViewController *mallPageViewContoller;
/**
 *  门店
 */
@property (nonatomic, strong) CCStoreViewController *storePageViewContoller;
/**
 *  用户
 */
@property (nonatomic, strong) CCUserCenterViewController *userCenterPageViewContoller;
@end
