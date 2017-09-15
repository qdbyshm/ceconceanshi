//
//  SMZDMShareInstance.h
//  SMZDM
//
//  Created by ZhangWenhui on 15/10/6.
//  Copyright © 2015年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UISMZDMRefreshHeaderView.h"
#import "UISMZDMRefreshFooterView.h"
#import "BaseCircleView.h"
@interface SMZDMShareInstance : NSObject

+ (SMZDMShareInstance *)shareInstance;

@property (nonatomic, strong) UISMZDMRefreshHeaderView *refreshHeaderView;
@property (nonatomic, strong) UISMZDMRefreshFooterView *refreshFooterView;
@property (nonatomic, strong) BaseCircleView *circleView;
@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;
@property (nonatomic, strong) NSMutableDictionary *dict_article_rs_params;
@property (nonatomic, strong) NSMutableDictionary *dict_recommendedBack;
@property (nonatomic, strong) NSMutableArray *array_UploadSessionManager;
@property (nonatomic, strong) NSMutableDictionary *requestParams;
//赵彬UIGeneralIndexCell中用，目的是记录Cell的展开状态
@property (nonatomic, strong) NSMutableDictionary *dict_UIGeneralIndexCell_isUnfold;

@property (nonatomic, assign) BOOL smzdmOnekeyHaitaoShouldRefresh;


@property (nonatomic,strong)NSString        *GTMPiCiID;


//发表情晒单专用
- (void)sm_initArrayUploadSession;
- (void)sm_destroyUploadSession;
- (void)sm_destroyUploadSessionWithArray;
//@property (nonatomic, copy) void (^taskSuccessBlock)(NSURLSessionDataTask *, id);
//@property (nonatomic, copy) void (^taskFailedBlock)(NSURLSessionDataTask *, NSError *);

/**
 2017.01.06,标记首页编辑精选刷新间隔:离开各个频道后，再次进入才间隔刷新,默认为YES
 add by 张文辉
 */
@property (nonatomic, assign) BOOL isBackHomePage;

@end
