//
//  CustomShowV.h
//  SMZDM
//
//  Created by 孙 浩明 on 13-12-9.
//
//

#import <UIKit/UIKit.h>

@interface CustomShowV : UIView
- (id)initWithFrame:(CGRect)frame withView:(UIView *)superV;
@property(nonatomic,retain)UILabel *titLabel;
@end
