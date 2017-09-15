//
//  UIAlertShow.h
//  UINavigationDemo
//
//  Created by ZhangWenhui on 15/4/27.
//  Copyright (c) 2015年 张文辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UIAlertShowType) {
    UIAlertShowTypeDefault = 0,//默认alert
    UIAlertShowTypeMakeScore = 1//打分alert
};

//打分选项
typedef NS_ENUM(NSUInteger, MakeScoreOptionsType) {
    MakeScoreOptionsTypeEncourage = 0,//去鼓励
    MakeScoreOptionsTypeLaterEvaluation = 1,//稍后评价
    MakeScoreOptionsTypeNoLongerPrompt = 2,//不再提示
    MakeScoreOptionsTypeDefault = 100//默认
};

@interface UIAlertShow : NSObject

@property (strong, nonatomic) UIAlertView *alertView;

/*!
 * @brief  默认为打分提示alert，间隔提醒
 */
@property (assign, nonatomic) UIAlertShowType alertShowType;
//打分提供选项
@property (assign, nonatomic) MakeScoreOptionsType optionsType;
//点击事件回调
@property (copy, nonatomic) void (^btnClicked) (MakeScoreOptionsType optionType, NSUInteger buttonIndex);
//打分鼓励时，app的ID
@property (strong, nonatomic) NSString *s_appleID;

/**
 *  初始化方法
 *
 *  @param showType AlertView的类型
 */
- (instancetype)initWithAlertShowType:(UIAlertShowType)showType;
/**
 *  显示alertView
 *
 *  @param valueString 标题、副标题、按钮选项标题
 */
- (void)showAlertView:(NSString *)valueString,...;
/**
 *  显示打分提醒
 */
- (void)showMakeScoreAlert;

@end

//==============================================================================
#pragma mark - NSString Category -
//==============================================================================
@interface NSString (SafeMethos)

/**
 *  判断字符窜是否合法
 *
 *  @return YES-合法，NO-不合法
 */
- (BOOL)isLegalString;
/**
 *  如果字符串不合法，返回空串。
 *
 *  @return NSString
 */
- (NSString *)legalString;
/**
 *  去掉首位空格
 *
 *  @return NSString
 */
- (NSString *)trim;

@end

//==============================================================================
#pragma mark - NSArray Category -
//==============================================================================
@interface NSArray (SafeMethos)

/**
 *  取数组中的元素预防越界
 *
 *  @param index 下表
 *
 *  @return 数组中相应下表的元素
 */
- (id)objectAtSafeIndex:(NSUInteger)index;

@end

//==============================================================================
#pragma mark - NSMutableArray Category -
//==============================================================================
@interface NSMutableArray (SafeMethod)

/**
 *  向数组中添加元素，若为nil，添加空串
 *
 *  @param anObject 添加的元素
 */
- (void)addSafeObject:(id)anObject;
//feng
- (void)addSafeObjectOfNavigationVC:(id)anObject;

- (void)removeObjectAtSafeIndex:(NSUInteger)index;

@end
