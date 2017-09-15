//
//  MainToolBar.m
//  SMZDM
//
//  Created by sunhaoming on 15/6/1.
//
//

#import "MainToolBar.h"
#import "SMConstantHeader.h"
@interface MainToolBar()
{
    
}
@end
@implementation MainToolBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lastNum = 1;
        _nowNum = 1;
        
        
        NSString * device = @"5";
        if (DEVICE6P) {
            device = @"6p";
        }else if(DEVICESIX)
        {
            device = @"6";
        }
        
  
        _bgArrays = [[NSMutableArray alloc]init];
        for (int i = 0;i<5;i++) {
            
            UIImage * image1 = nil;
            UIImage * image2 = nil;

     
            NSString * name1 = [NSString stringWithFormat:@"icon_bg_%@_%d",device,i+1];
            NSString * name2 = [NSString stringWithFormat:@"icon_bg_act_%@_%d",device,i+1];

            image1 = [UIImage imageNamed:name1];
            image2 = [UIImage imageNamed:name2];
            
            
            UIButton * bgBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*(frame.size.width/5), 0.0, frame.size.width/5, frame.size.height)];
            bgBtn.tag = i+1;
            [bgBtn setBackgroundImage:image1 forState:UIControlStateNormal];
            [bgBtn setBackgroundImage:image2 forState:UIControlStateSelected];
            bgBtn.adjustsImageWhenHighlighted = NO;
            
            [bgBtn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:bgBtn];
            [_bgArrays addObject:bgBtn];

            if (i==4) {//
                _ltRedImg =[[UIImageView alloc]initWithFrame:CGRectMake(bgBtn.frame.size.width-6-6, 12, 6, 6)];
                
                _ltRedImg.image = [UIImage imageNamed:@"ic_user_new_icon"];
                _ltRedImg.hidden = YES;
                [bgBtn addSubview:_ltRedImg];
            }
            
        }        
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}

- (void)buttonPress:(UIButton *)sender
{
    [self setSelectIndex:sender.tag];
    _nowNum = (int)sender.tag;
    [self.delegate seletedNum:(int)sender.tag];
    _lastNum = (int)sender.tag;
    
}

- (void)setSelectIndex:(NSInteger)index
{
    for (UIButton *element in self.subviews) {
        if ([element isKindOfClass:[UIButton class]]) {
            element.selected = NO;
        }
    }
    
    UIButton *button = (UIButton *)[self viewWithTag:index];
    button.selected = YES;
    
}

#pragma mark - 个人中心|订阅是否有消息
//获取小红点
- (void)getNewMessageStatus:(UIButton*)sender
{
}

@end
