//
//  SMHomeAddOptionsView.h
//  SMZDM
//
//  Created by ZhangWenhui on 2017/6/16.
//  Copyright © 2017年 smzdm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSMHomeAddOption_imageName  @"imageName"
#define kSMHomeAddOption_showName  @"showName"
#define kSMHomeAddOption_addOptionsType  @"addOptionsType"
#define kSMHomeAddOption_eventLabel  @"eventLabel"
#define kSMHomeAddOption_action  @"action"

typedef NS_ENUM(NSInteger, SMHomeAddOptionsType) {
    SMHomeAddOptionsType_None = 0,
    //加关注
    SMHomeAddOptionsType_Follow = 1,
    //发爆料
    SMHomeAddOptionsType_Broke = 2,
    //扫一扫
    SMHomeAddOptionsType_QRCodeReader = 3,
    //发布原创
    SMHomeAddOptionsType_PublishingOriginal = 4
};

typedef void(^SMHomeAddOptionsViewBlock)(NSDictionary *dictData, SMHomeAddOptionsType optionsType);

@interface SMHomeAddOptionsView : UIControl

@property (nonatomic, copy) SMHomeAddOptionsViewBlock optionSelectBlock;

- (void)sm_showInView:(UIView *)superView convertedFrame:(CGRect)frame;

@end

@interface SMHomeAddOptionsCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dictData;

@end
