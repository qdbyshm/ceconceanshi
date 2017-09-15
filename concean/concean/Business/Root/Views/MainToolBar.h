//
//  MainToolBar.h
//  SMZDM
//
//  Created by sunhaoming on 15/6/1.
//
//

#import <UIKit/UIKit.h>
@protocol MAINTOOLBARDELEGATE<NSObject>
- (void)seletedNum:(int )num;
- (void)seletedADNum:(int)adNum;
@end
@interface MainToolBar : UIView
{
    
}
@property (nonatomic,strong)UIView  *separatorLine;
@property (nonatomic,assign)int lastNum;
@property (nonatomic,assign)int nowNum;
@property (nonatomic,assign)id<MAINTOOLBARDELEGATE>delegate;
@property (nonatomic,strong)UIImageView *ltRedImg;
@property (nonatomic,strong)UIImageView *lineImg;
@property (nonatomic,strong)NSMutableArray *bgArrays;

- (void)setSelectIndex:(NSInteger)index;
- (void)getNewMessageStatus:(UIButton*)sender;//获取小红点
@end
