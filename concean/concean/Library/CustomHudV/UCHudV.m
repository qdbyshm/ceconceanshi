//
//  UCHudV.m
//  SMZDM
//
//  Created by 法良涛 on 14-9-30.
//
//

#import "UCHudV.h"
#import <QuartzCore/QuartzCore.h>

@implementation UCHudV
- (void)dealloc{
    if (_actvit) {
        [_actvit stopAnimating];
    }
}
- (id)initWithFrame:(CGRect)frame withView:(UIView *)superV
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, 100, 100);
        self.center = superV.center;
        
        
        self.layer.cornerRadius = 8;
        self.layer.backgroundColor = [[UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f]CGColor];
        [self.layer setMasksToBounds:YES];
        
        _actvit =  [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_actvit setFrame:CGRectMake(100/2 - 35 /2 , 20, 35, 35)];
        [_actvit startAnimating];
        [self addSubview:_actvit];
        
        _titLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 100, 30)];
        _titLabel.textAlignment = NSTextAlignmentCenter;
        _titLabel.backgroundColor = [UIColor clearColor];
        _titLabel.textColor = [UIColor whiteColor];
        [_titLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self addSubview:_titLabel];
        
    }
    return self;
}

+(UCHudV *)showInView:(UIView *)view withText:(NSString *)text {
    UCHudV *customHudVA = [[UCHudV alloc] initWithFrame:CGRectMake(0, 0, 100, 100) withView:view];
    customHudVA.center = view.center;
    customHudVA.titLabel.text =  text;
    [view addSubview:customHudVA];
    [view bringSubviewToFront:customHudVA];
    
    return customHudVA;
}

+ (UCHudV *)showInView:(UIView *)view {
    UCHudV *customHudVA = [[UCHudV alloc] initWithFrame:CGRectMake(0, 0, 100, 70) withView:view];
    customHudVA.height = 75;
    customHudVA.center = view.center;
    [view addSubview:customHudVA];
    [view bringSubviewToFront:customHudVA];
    
    return customHudVA;
}

+(BOOL)hideForView:(UIView *)view {
    UCHudV *customHudVA = nil;
    for (UIView *aView in view.subviews) {
        if ([aView isKindOfClass:[UCHudV class]]) {
            customHudVA = (UCHudV *)aView;
        }
    }
    
    if(customHudVA) {
        [customHudVA removeFromSuperview];
        customHudVA = nil;
        return YES;
    }
    return NO;
}

@end
