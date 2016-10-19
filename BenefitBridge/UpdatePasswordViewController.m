//
//  UpdatePasswordViewController.m
//  demo
//
//  Created by Infinitum on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "MainViewController.h"
#import "UIColor+Expanded.h"
#import "LoginViewController.h"
#import "AsyncImageView.h"
@interface UpdatePasswordViewController ()

@end

@implementation UpdatePasswordViewController
@synthesize oldpassLbl,newpassLbl,confirmpassLbl,oldTxt,newsTxt,confirmtxt,updateBtn,cancelBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"Update Password";
    [titleLabel setTextColor: [self colorFromHexString:@"#03687f"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,40,40)];
    //[leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:20.0f];
    [leftBtn addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    
   // [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    AsyncImageView *bannerAsyncimg=[[AsyncImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.20, screenRect.size.height*.10, screenRect.size.width*.60, screenRect.size.height*.07)];
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
    
    
    UIImageView * logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.90,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];

    oldpassLbl = [[UILabel alloc] init];
    [oldpassLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.25, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    oldpassLbl.textAlignment = NSTextAlignmentLeft;
    oldpassLbl.text=@"Old Password";
    [oldpassLbl setTextColor: [UIColor blackColor]];
    oldpassLbl.font=fonts;
    [self.view addSubview:oldpassLbl];
    
    oldTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.31, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    oldTxt.delegate = self;
    oldTxt.textAlignment=NSTextAlignmentLeft;
    oldTxt.textColor=[UIColor blackColor];
    [oldTxt setBackgroundColor:[UIColor clearColor]];
    self.oldTxt.font = fonts;
    UIColor *color = [UIColor grayColor];
    color = [color colorWithAlphaComponent:1.0f];
    self.oldTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Old Password" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:oldTxt];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.oldTxt.bounds.size.height - 1, self.oldTxt.bounds.size.width, 1.0f);
    bottomBorder.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.oldTxt.layer addSublayer:bottomBorder];
    self.oldTxt.layer.shadowOpacity = 0.5;
    self.oldTxt.alpha=0.5;
    
    CALayer *bottomBorders = [CALayer layer];
    bottomBorders.frame = CGRectMake(0.0f,0,2,self.oldTxt.bounds.size.height);
    bottomBorders.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.oldTxt.layer addSublayer:bottomBorders];
    self.oldTxt.layer.shadowOpacity = 0.5;
    self.oldTxt.alpha=0.5;
    
    self.oldTxt.layer.shadowRadius = 5.0;
    self.oldTxt.layer.shadowColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    self.oldTxt.layer.shadowOffset = CGSizeMake(1.0,1.0);
    
    newpassLbl = [[UILabel alloc] init];
    [newpassLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.37, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    newpassLbl.textAlignment = NSTextAlignmentLeft;
    newpassLbl.text=@"New Password";
    [newpassLbl setTextColor: [UIColor blackColor]];
    newpassLbl.font=fonts;
    [self.view addSubview:newpassLbl];
    
    
    newsTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.43, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    newsTxt.delegate = self;
    newsTxt.textAlignment=NSTextAlignmentLeft;
    newsTxt.textColor=[UIColor blackColor];
    [newsTxt setBackgroundColor:[UIColor clearColor]];
    self.newsTxt.font = fonts;
    color = [color colorWithAlphaComponent:1.0f];
    self.newsTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"New Password" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:newsTxt];
    
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, self.newsTxt.bounds.size.height - 1, self.newsTxt.bounds.size.width, 1.0f);
    bottomBorder1.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.newsTxt.layer addSublayer:bottomBorder1];
    self.newsTxt.layer.shadowOpacity = 0.5;
    self.newsTxt.alpha=0.5;
    
    bottomBorders.frame = CGRectMake(0.0f,0,2,self.newsTxt.bounds.size.height);
    bottomBorders.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.newsTxt.layer addSublayer:bottomBorders];
    self.newsTxt.layer.shadowOpacity = 0.5;
    self.newsTxt.alpha=0.5;
    
    self.newsTxt.layer.shadowRadius = 5.0;
    self.newsTxt.layer.shadowColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    self.newsTxt.layer.shadowOffset = CGSizeMake(1.0,1.0);
    
    confirmpassLbl = [[UILabel alloc] init];
    [confirmpassLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.49, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    confirmpassLbl.textAlignment = NSTextAlignmentLeft;
    confirmpassLbl.text=@"Confirm Password";
    [confirmpassLbl setTextColor: [UIColor blackColor]];
    confirmpassLbl.font=fonts;
    [self.view addSubview:confirmpassLbl];
    
    confirmtxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.55, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    confirmtxt.delegate = self;
    confirmtxt.textAlignment=NSTextAlignmentLeft;
    confirmtxt.textColor=[UIColor blackColor];
    [confirmtxt setBackgroundColor:[UIColor clearColor]];
    self.confirmtxt.font = fonts;
    color = [color colorWithAlphaComponent:1.0f];
    self.confirmtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:confirmtxt];
    
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0f, self.confirmtxt.bounds.size.height - 1, self.confirmtxt.bounds.size.width, 1.0f);
    bottomBorder2.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.confirmtxt.layer addSublayer:bottomBorder2];
    self.confirmtxt.layer.shadowOpacity = 0.5;
    self.confirmtxt.alpha=0.5;
    
    bottomBorders.frame = CGRectMake(0.0f,0,2,self.confirmtxt.bounds.size.height);
    bottomBorders.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.confirmtxt.layer addSublayer:bottomBorders];
    self.confirmtxt.layer.shadowOpacity = 0.5;
    self.confirmtxt.alpha=0.5;
    
    self.confirmtxt.layer.shadowRadius = 5.0;
    self.confirmtxt.layer.shadowColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    self.confirmtxt.layer.shadowOffset = CGSizeMake(1.0,1.0);
    
    updateBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.62,screenRect.size.width*0.40,screenRect.size.height*0.06)];
    updateBtn.layer.cornerRadius = 6.0f;
    [updateBtn setTitle:@"Update" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[updateBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [updateBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [updateBtn addTarget:self action:@selector(updateActions:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
    
    
    cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.62,screenRect.size.width*0.40,screenRect.size.height*0.06)];
    cancelBtn.layer.cornerRadius = 6.0f;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[cancelBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [cancelBtn addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];

}

-(IBAction)updateActions:(id)sender{
    LoginViewController *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:login animated:YES];

}
-(void)BackAction{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
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
