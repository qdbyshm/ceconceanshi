//
//  BaseViewController.h
//  MobileSchool
//
//  Created by zhanbo on 13-10-11.
//  Copyright (c) 2013年 feng zhanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"
@interface BaseViewController : UIViewController
{
    DataController * dataController;
}

@property (nonatomic, assign) NSInteger sm_index;

- (void)initData;

- (void)initView;


@end
