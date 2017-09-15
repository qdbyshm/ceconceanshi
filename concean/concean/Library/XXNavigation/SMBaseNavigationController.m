//
//  SMBaseNavigationController.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/9/1.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "SMBaseNavigationController.h"
#import "UINavigationController+SMBackGesture.h"

@interface SMBaseNavigationController ()

@end

@implementation SMBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarHidden = YES;
    [self setNavigationBarHidden:YES];
    
    [self setEnableBackGesture:NO];
    
    self.view.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
