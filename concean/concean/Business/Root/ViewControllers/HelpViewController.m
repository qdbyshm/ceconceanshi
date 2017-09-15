//
//  HelpViewController.m
//  SMZDM
//
//  Created by Sun Faxin on 13-6-15.
//
//

#import "HelpViewController.h"
#import "UIImage+MultiFormat.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
//#define Array_Pic1 @[HOME,PRICE,COUPON,JINGXUAN,YOUHUI,HAITAO,FAXIAN,XIANZHI,ARTICLE,YUANCHUAN,ZIXUN,PINGCE,@"wiki_topic",HAOWU,ZHONGCE,@"user"]
#define Array_Count 4


@interface HelpViewController ()
{
    NSString    * device;
}
@property (nonatomic,strong) NSMutableArray * btn_arrays;
@property (nonatomic,strong) UIButton * button_inter;

@end

@implementation HelpViewController
@synthesize deletage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//
//    return UIStatusBarStyleDefault;
//}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"OldUserUp"];
    [[NSUserDefaults standardUserDefaults] setValue:@"help81" forKey:@"OldUserVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    CGFloat bottom = 0;
    CGFloat page_bottom = 30;
    CGFloat page_offset = 26;

    if (DEVICEFOUR) {
        device = @"4";
        bottom = 63.0f;
    }else if (DEVICEFIVE)
    {
        device = @"5";
        bottom = 75.0f;
    }else if (DEVICESIX)
    {
        device = @"6";
        bottom = 90.0f;
        page_bottom = 40.0f;
        page_offset = 30.0f;
    }else
    {
        device = @"6p";
        bottom = 99.0f;
        page_bottom = 40.0f;
        page_offset = 34.0f;
    }
    
    _btn_arrays = [[NSMutableArray alloc]init];
    
    NSString * image_name = [NSString stringWithFormat:@"help_%@_zhi",device];
    UIImage * center_image = [UIImage imageNamed:image_name];
    UIImageView * center_view = [[UIImageView alloc]initWithImage:center_image];
    center_view.width = center_image.size.width;
    center_view.height = center_image.size.height;
    center_view.left = 0;
    center_view.top = 0;
    center_view.userInteractionEnabled = NO;
    [self.view addSubview:center_view];

    scroll_ = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scroll_.backgroundColor =[UIColor clearColor];
    scroll_.pagingEnabled = YES;
    scroll_.showsHorizontalScrollIndicator = NO;
    scroll_.bounces = NO;
    
    [scroll_ setContentSize:CGSizeMake(SCREEN_WIDTH*Array_Count, 0)];
    [scroll_ setDelegate:self];
    [self.view addSubview:scroll_];
    
    //
    for (int i=0; i<Array_Count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSString * name = [NSString stringWithFormat:@"help_%@_%d",device,i+1];
        [imageView setImage:[UIImage imageNamed:name]];
        imageView.userInteractionEnabled = YES;
        [scroll_ addSubview:imageView];
        
        NSString * btn_name1 = [NSString stringWithFormat:@"page_%@_emp_%d",device,i+1];
        NSString * btn_name2 = [NSString stringWithFormat:@"page_%@_sto_%d",device,i+1];
        UIImage * image1 = [UIImage imageNamed:btn_name1];
        UIImage * image2 = [UIImage imageNamed:btn_name2];
        CGFloat left = SCREEN_WIDTH/2-(image1.size.width*Array_Count+page_offset*3)/2;
        UIButton * btn_imageView = [[UIButton alloc]initWithFrame:CGRectMake(left+i*(image1.size.width+page_offset), SCREEN_HEIGHT-page_bottom-image1.size.height, image1.size.width, image1.size.height)];
        [btn_imageView setImage:image1 forState:UIControlStateNormal];
        [btn_imageView setImage:image2 forState:UIControlStateSelected];
        [self.view addSubview:btn_imageView];
        if (i==0) {
            btn_imageView.selected = YES;
        }
        [_btn_arrays addObject:btn_imageView];

        
        //
        if (i==Array_Count-1) {
            NSString * btn_name = [NSString stringWithFormat:@"help_%@_btn",device];
            UIImage * image = [UIImage imageNamed:btn_name];

            _button_inter = [UIButton buttonWithType:UIButtonTypeCustom];
            _button_inter.frame = CGRectMake(SCREEN_WIDTH/2-image.size.width/2, SCREEN_HEIGHT-bottom-image.size.height, image.size.width, image.size.height);
            [_button_inter setImage:image forState:UIControlStateNormal];
            [_button_inter addTarget:self action:@selector(didMove) forControlEvents:UIControlEventTouchUpInside];
            _button_inter.alpha = 0.0;
            [imageView addSubview:_button_inter];

        }
        
    }
    
}


-(void)didMove
{
    if (deletage) {
        if ([deletage respondsToSelector:@selector(roadOver)]) {
            [deletage roadOver];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x==0) {
        [self changeBtnStatus:0];
    }else if (scrollView.contentOffset.x==SCREEN_WIDTH) {
        [self changeBtnStatus:1];
    }else if (scrollView.contentOffset.x==SCREEN_WIDTH*2) {
        [self changeBtnStatus:2];
    }else if (scrollView.contentOffset.x==SCREEN_WIDTH*3) {
        [self changeBtnStatus:3];
    }
    if (scrollView.contentOffset.x<SCREEN_WIDTH*2) {
        _button_inter.alpha = 0.0;
    }else
    {
        _button_inter.alpha =(scrollView.contentOffset.x-SCREEN_WIDTH*2)/SCREEN_WIDTH;
    }
}

- (void)changeBtnStatus:(NSInteger)index
{
    for (UIButton *button in self.btn_arrays) {
        button.selected = NO;
    }
    UIButton * button = self.btn_arrays[index];
    button.selected = YES;

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
