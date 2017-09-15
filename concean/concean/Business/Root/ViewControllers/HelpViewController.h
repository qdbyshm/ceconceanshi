//
//  HelpViewController.h
//  SMZDM
//
//  Created by Sun Faxin on 13-6-15.
//
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"
@protocol HelpVCDeletage <NSObject>

- (void)roadOver;

@end

@interface HelpViewController : BaseViewController<UIScrollViewDelegate> {
    
    
@private
    
    UIScrollView * scroll_;
    NSArray * imageArray;
    SMPageControl *_pageControl;

}

@property (nonatomic,assign) id<HelpVCDeletage>deletage;
@property (nonatomic,strong) SMPageControl * pageControl;
@end


