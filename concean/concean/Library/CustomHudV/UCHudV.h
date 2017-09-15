//
//  UCHudV.h
//  SMZDM
//
//  Created by 法良涛 on 14-9-30.
//
//

#import <UIKit/UIKit.h>

@interface UCHudV : UIView
- (id)initWithFrame:(CGRect)frame withView:(UIView *)superV;
@property(nonatomic,retain)UIActivityIndicatorView *actvit;
@property(nonatomic,retain)UILabel *titLabel;

+(UCHudV *)showInView:(UIView *)view withText:(NSString *)text;
+ (UCHudV *)showInView:(UIView *)view;
+(BOOL)hideForView:(UIView *)view;

@end
