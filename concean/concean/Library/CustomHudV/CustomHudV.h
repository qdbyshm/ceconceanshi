//
//  CustomHudV.h
//  SMZDM
//
//  Created by shm on 13-7-9.
//
//

#import <UIKit/UIKit.h>
@interface CustomHudV : UIView
- (id)initWithFrame:(CGRect)frame withView:(UIView *)superV;
@property(nonatomic,retain)UIActivityIndicatorView *actvit;
@property(nonatomic,retain)UILabel *titLabel;
@end
