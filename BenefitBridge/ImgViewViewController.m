//
//  ImgViewViewController.m
//  demo
//
//  Created by Infinitum on 22/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "ImgViewViewController.h"

@interface ImgViewViewController ()

@end

@implementation ImgViewViewController
@synthesize scrollFront,BackImgVw1,image,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.scrollFront=[[UIScrollView alloc]init];
    self.scrollFront.layer.frame=CGRectMake(0,screenRect.size.height*0.12,screenRect.size.width,screenRect.size.height*0.88);
    [self.scrollFront removeFromSuperview];
    [self.view addSubview:self.scrollFront];
    
    self.BackImgVw1 =[[UIImageView alloc]init];
    self.BackImgVw1.layer.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.25);
    [self.BackImgVw1 removeFromSuperview];
    [self.scrollFront addSubview:self.BackImgVw1];

    
    self.scrollFront.delegate=self;
    
    [BackImgVw1 setImage:image];
    BackImgVw1.image = image;
    
    BackImgVw1.frame = scrollFront.bounds;
    [BackImgVw1 setContentMode:UIViewContentModeScaleAspectFit];
    //scrollFront.contentSize = CGSizeMake(BackImgVw1.frame.size.width, BackImgVw1.frame.size.height);
    scrollFront.maximumZoomScale = 4.0;
    scrollFront.minimumZoomScale = 1.0;
    scrollFront.delegate = self;

}
- (NSUInteger)supportedInterfaceOrientations
{
    appDelegate.isLandscapeOK=YES;
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}


-(void)viewDidAppear:(BOOL)animated{
    appDelegate.isLandscapeOK=YES;

}

-(void)viewDidLayoutSubviews{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if(self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height))){
        appDelegate.isLandscapeOK=YES;
        self.scrollFront.layer.frame=CGRectMake(0,screenRect.size.height*0.12,screenRect.size.width,screenRect.size.height*0.88);
        self.BackImgVw1.layer.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height*0.25);
        
        BackImgVw1.frame = CGRectMake(scrollFront.bounds.size.width*0.05,70,scrollFront.bounds.size.width*0.87, scrollFront.bounds.size.height/2);

        [BackImgVw1 setContentMode:UIViewContentModeScaleAspectFit];
        scrollFront.maximumZoomScale = 4.0;
        scrollFront.minimumZoomScale = 1.0;
        scrollFront.delegate = self;

    }
    else{
        appDelegate.isLandscapeOK=NO;
        self.scrollFront.layer.frame=CGRectMake(0,screenRect.size.height*0.12,screenRect.size.width,screenRect.size.height*0.88);
       self.BackImgVw1.layer.frame=CGRectMake(screenRect.size.width*0.30,0,screenRect.size.width*0.30,screenRect.size.height*0.40);
        BackImgVw1.frame = CGRectMake(scrollFront.bounds.size.width*0.20,20,scrollFront.bounds.size.width*0.60, scrollFront.bounds.size.height/2);

        [BackImgVw1 setContentMode:UIViewContentModeScaleAspectFit];
        scrollFront.maximumZoomScale = 4.0;
        scrollFront.minimumZoomScale = 1.0;
        scrollFront.delegate = self;

    }
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
-(IBAction)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // return which subview we want to zoom
    
    if (scrollView==scrollFront) {
        
        return self.BackImgVw1;
    }
    return 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
