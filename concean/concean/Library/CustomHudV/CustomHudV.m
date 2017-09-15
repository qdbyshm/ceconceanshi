//
//  CustomHudV.m
//  SMZDM
//
//  Created by shm on 13-7-9.
//
//

#import "CustomHudV.h"
#import <QuartzCore/QuartzCore.h>
@implementation CustomHudV


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
        
        
//        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isNightStyleMake"]) {
//            _titLabel.textColor = [CommUtls colorWithHexString:@"#868b98"];
//        }
//        else{
//        }
        [_actvit setFrame:CGRectMake(100/2 - 35 /2 , 20, 35, 35)];
        [_actvit startAnimating];
        [self addSubview:_actvit];
        
        _titLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 100, 30)];
        _titLabel.textAlignment = NSTextAlignmentCenter;
        _titLabel.backgroundColor = [UIColor clearColor];
        
       
//        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isNightStyleMake"]) {
//            _titLabel.textColor = [CommUtls colorWithHexString:@"#868b98"];
//        }
//        else{
            _titLabel.textColor=[UIColor whiteColor];
            
        
//        }
        [_titLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self addSubview:_titLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
