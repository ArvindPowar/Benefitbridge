//
//  ConditionTermViewController.m
//  demo
//
//  Created by Infinitum on 25/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "ConditionTermViewController.h"
#import "AsyncImageView.h"
#import "UIColor+Expanded.h"
#import "ViewController.h"
@interface ConditionTermViewController ()

@end

@implementation ConditionTermViewController
@synthesize logoImg,activityIndicator,appDelegate,cancelBtn,scrollview;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [activityIndicator stopAnimating];
    appDelegate=[[UIApplication sharedApplication] delegate];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"Login";
    [titleLabel setTextColor: [self colorFromHexString:@"03687f"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AsyncImageView *bannerAsyncimg=[[AsyncImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.20, screenRect.size.height*.04, screenRect.size.width*.60, screenRect.size.height*.07)];
    [bannerAsyncimg.layer setMasksToBounds:YES];
    bannerAsyncimg.clipsToBounds=YES;
    [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];
    
    NSString *str = [prefs stringForKey:@"clientlogo"];
    NSString *newStr = [str substringFromIndex:1];
    NSString *newString = [newStr substringToIndex:[newStr length]-1];
    NSString *urlStr=[NSString stringWithFormat:@"https://www.benefitbridge.com/images/clientslogo/%@",newString];
    
    [bannerAsyncimg loadImageFromURL:[NSURL URLWithString:urlStr]];
    NSLog(@"image url %@",urlStr);
    [self.view addSubview:bannerAsyncimg];
    
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*.12, screenRect.size.width, screenRect.size.height*0.73)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollview];

    
    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.035];

    cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.30,screenRect.size.height*0.79,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    cancelBtn.layer.cornerRadius = 6.0f;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[cancelBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [cancelBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn.titleLabel setFont:customFontdregs];
    [self.view addSubview:cancelBtn];

    
    logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.85,screenRect.size.width*0.30,screenRect.size.height*0.05)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];
}
-(IBAction)CancelAction:(id)sender{
    ViewController *view=[[ViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
    
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
