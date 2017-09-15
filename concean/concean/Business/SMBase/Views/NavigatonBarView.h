//
//  NavigatonBarView.h
//  forum
//
//  Created by cyx on 12-7-26.
//  Copyright (c) 2012年 cdeledu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigatonBarViewDelegate <NSObject>

@optional
- (void)leftButtonClick;

- (void)rightButtonClick;

@end

@interface NavigatonBarView : UIView
{
    UILabel *titleLabel;
    UIButton *leftButton;
    UIButton *rightButton;
    UIImageView *backGroundImgeView;
    UILabel *rightLabel;
    UILabel *leftLabel;
}

- (void)refershUI;

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIButton *leftButton;
@property (nonatomic,retain) UIButton *rightButton;
@property (nonatomic,retain) UIImageView *backGroundImgeView;
@property (nonatomic,retain) UILabel *rightLabel;
@property (nonatomic,retain) UILabel *leftLabel;
@property (nonatomic,assign) id<NavigatonBarViewDelegate>delegate; 

@end
