//
//  NavigationBarViewController.h
//  MobileClass
//
//  Created by cyx on 13-3-19.
//  Copyright (c) 2013年 cyx. All rights reserved.
//

#import <UIKit/UIKit.h>                            
#import "BaseViewController.h"
#import "NavigatonBarView.h"


//导航栏左侧非返回按钮block（eg:筛选 ect）
typedef void(^BaseLeftBlock)(void);
//导航栏中间block（eg:搜索 ect）
typedef void(^BaseCenterBlock)(void);
//扫描二维码block
typedef void(^BaseScanBlock)(void);
//好文发布block
typedef void(^BaseGoodArticlePublishBlock)(void);
//导航栏右侧按钮block
typedef void(^BaseRightBlock)(void);

@interface NavigationBarViewController : BaseViewController <NavigatonBarViewDelegate>
{
    NavigatonBarView *navigationBar;
}

@property (nonatomic, strong) NSString *fromSourceStr;//来源字符串

@property (nonatomic, copy) BaseLeftBlock baseLeftBlock;
@property (nonatomic, copy) BaseCenterBlock baseCenterBlock;
@property (nonatomic, copy) BaseScanBlock baseScanBlock;
@property (nonatomic, copy) BaseGoodArticlePublishBlock goodArticlePublishBlock;
@property (nonatomic, copy) BaseRightBlock baseRightBlock;
@property (nonatomic, assign)BOOL freshBool;

//哪些列表需要注册
@property (nonatomic, strong) NSMutableArray *arrAllList;
//当前显示的view
@property (nonatomic, strong) UIView *currentVisibleView;
//当前列表显示的数据
@property (nonatomic, strong) NSArray *arrCurrentData;



- (void)initSearchNavigationBarView;

- (void)initNormalNavigationBarView;

/**
 设置导航条右边按钮文字

 @param text 名称
 */
- (void) setNavigationBarRightLabelText:(NSString *) text;

/**
 设置筛选、搜索框、+ 等空间的透明度

 @param sm_alpha 透明度比例
 */
- (void)sm_setAlpha:(CGFloat)sm_alpha;

@end
