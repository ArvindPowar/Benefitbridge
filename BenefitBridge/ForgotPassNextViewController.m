//
//  ForgotPassNextViewController.m
//  demo
//
//  Created by Infinitum on 11/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "ForgotPassNextViewController.h"
#import "AsyncImageView/AsyncImageView.h"
#import "ForgotpassViewController.h"
#import "LoginViewController.h"
#import "UIColor+Expanded.h"
#import "ForgotpassViewController.h"
@interface ForgotPassNextViewController ()

@end

@implementation ForgotPassNextViewController
@synthesize Usernametext,Passwordtext,ConfirmPasstext,EmailAddtext,GoBtn,CancelBtn,logoImg,usernameLbl,passwordLbl,confirmLbl,emailLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"Forgot Password";
    [titleLabel setTextColor: [self colorFromHexString:@"03687f"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    
    
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
    
    
    logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.85,screenRect.size.width*0.50,screenRect.size.height*0.05)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];
    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];

    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    usernameLbl = [[UILabel alloc] init];
    [usernameLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.16, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    usernameLbl.textAlignment = NSTextAlignmentLeft;
    usernameLbl.text=@"Username	";
    [usernameLbl setTextColor: [UIColor blackColor]];
    usernameLbl.font=fonts;
    [self.view addSubview:usernameLbl];

    
    Usernametext = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.22,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    Usernametext.font=font1;
    Usernametext.textAlignment=NSTextAlignmentLeft;
    Usernametext.delegate = self;
    Usernametext.text=@"smithj";
    Usernametext.textColor=[UIColor colorWithHexString:@"434444"];
    self.Usernametext.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:Usernametext];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.Usernametext.bounds.size.height - 1, self.Usernametext.bounds.size.width, 1.0f);
    bottomBorder.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.Usernametext.layer addSublayer:bottomBorder];
    self.Usernametext.layer.shadowOpacity = 0.5;
    self.Usernametext.alpha=0.5;
    
    CALayer *bottomBorders = [CALayer layer];
    bottomBorders.frame = CGRectMake(0.0f,0,2,self.Usernametext.bounds.size.height);
    bottomBorders.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.Usernametext.layer addSublayer:bottomBorders];
    self.Usernametext.layer.shadowOpacity = 0.5;
    self.Usernametext.alpha=0.5;
    
    self.Usernametext.layer.shadowRadius = 5.0;
    self.Usernametext.layer.shadowColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    self.Usernametext.layer.shadowOffset = CGSizeMake(1.0,1.0);
    
    passwordLbl = [[UILabel alloc] init];
    [passwordLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.27, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    passwordLbl.textAlignment = NSTextAlignmentLeft;
    passwordLbl.text=@"Password";
    [passwordLbl setTextColor: [UIColor blackColor]];
    passwordLbl.font=fonts;
    [self.view addSubview:passwordLbl];

    Passwordtext = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.33,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    Passwordtext.font=font1;
    Passwordtext.textAlignment=NSTextAlignmentLeft;
    Passwordtext.delegate = self;
    Passwordtext.textColor=[UIColor colorWithHexString:@"434444"];
    self.Passwordtext.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:Passwordtext];
    
    CALayer *bottomBorpass = [CALayer layer];
    bottomBorpass.frame = CGRectMake(0.0f, self.Passwordtext.bounds.size.height - 1, self.Passwordtext.bounds.size.width, 1.0f);
    bottomBorpass.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.Passwordtext.layer addSublayer:bottomBorpass];
    self.Passwordtext.layer.shadowOpacity = 0.5;
    self.Passwordtext.alpha=0.5;
    
    CALayer *bottomBorderpass = [CALayer layer];
    bottomBorderpass.frame = CGRectMake(0.0f,0,2,self.Passwordtext.bounds.size.height);
    bottomBorderpass.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.Passwordtext.layer addSublayer:bottomBorderpass];
    self.Passwordtext.layer.shadowOpacity = 0.5;
    self.Passwordtext.alpha=0.5;
    
    self.Passwordtext.layer.shadowRadius = 5.0;
    self.Passwordtext.layer.shadowColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    self.Passwordtext.layer.shadowOffset = CGSizeMake(1.0,1.0);
    
    confirmLbl = [[UILabel alloc] init];
    [confirmLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.38, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    confirmLbl.textAlignment = NSTextAlignmentLeft;
    confirmLbl.text=@"Confirm Password";
    [confirmLbl setTextColor: [UIColor blackColor]];
    confirmLbl.font=fonts;
    [self.view addSubview:confirmLbl];

    ConfirmPasstext = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.43,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    ConfirmPasstext.font=font1;
    ConfirmPasstext.textAlignment=NSTextAlignmentLeft;
    ConfirmPasstext.delegate = self;
    ConfirmPasstext.textColor=[UIColor colorWithHexString:@"434444"];
    self.ConfirmPasstext.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:ConfirmPasstext];
    
    CALayer *bottomBorss = [CALayer layer];
    bottomBorss.frame = CGRectMake(0.0f, self.ConfirmPasstext.bounds.size.height - 1, self.ConfirmPasstext.bounds.size.width, 1.0f);
    bottomBorss.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.ConfirmPasstext.layer addSublayer:bottomBorss];
    self.ConfirmPasstext.layer.shadowOpacity = 0.5;
    self.ConfirmPasstext.alpha=0.5;
    
    CALayer *bottomBordss = [CALayer layer];
    bottomBordss.frame = CGRectMake(0.0f,0,2,self.ConfirmPasstext.bounds.size.height);
    bottomBordss.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.ConfirmPasstext.layer addSublayer:bottomBordss];
    self.ConfirmPasstext.layer.shadowOpacity = 0.5;
    self.ConfirmPasstext.alpha=0.5;
    
    self.ConfirmPasstext.layer.shadowRadius = 5.0;
    self.ConfirmPasstext.layer.shadowColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    self.ConfirmPasstext.layer.shadowOffset = CGSizeMake(1.0,1.0);
    
    emailLbl = [[UILabel alloc] init];
    [emailLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.49, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    emailLbl.textAlignment = NSTextAlignmentLeft;
    emailLbl.text=@"Email Address";
    [emailLbl setTextColor: [UIColor blackColor]];
    emailLbl.font=fonts;
    [self.view addSubview:emailLbl];

    EmailAddtext = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.55,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    EmailAddtext.font=font1;
    EmailAddtext.textAlignment=NSTextAlignmentLeft;
    EmailAddtext.delegate = self;
    EmailAddtext.textColor=[UIColor colorWithHexString:@"434444"];
    self.EmailAddtext.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:EmailAddtext];
    
    CALayer *bottomBorsss = [CALayer layer];
    bottomBorsss.frame = CGRectMake(0.0f, self.EmailAddtext.bounds.size.height - 1, self.EmailAddtext.bounds.size.width, 1.0f);
    bottomBorsss.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.ConfirmPasstext.layer addSublayer:bottomBorsss];
    self.ConfirmPasstext.layer.shadowOpacity = 0.5;
    self.ConfirmPasstext.alpha=0.5;
    
    CALayer *bottomBordsss = [CALayer layer];
    bottomBordsss.frame = CGRectMake(0.0f,0,2,self.EmailAddtext.bounds.size.height);
    bottomBordsss.backgroundColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    [self.EmailAddtext.layer addSublayer:bottomBordsss];
    self.EmailAddtext.layer.shadowOpacity = 0.5;
    self.EmailAddtext.alpha=0.5;
    
    self.EmailAddtext.layer.shadowRadius = 5.0;
    self.EmailAddtext.layer.shadowColor = [self colorFromHexString:@"#e4e3e2"].CGColor;
    self.EmailAddtext.layer.shadowOffset = CGSizeMake(1.0,1.0);

    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.04];
    
    GoBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.65,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    GoBtn.layer.cornerRadius = 6.0f;
    [GoBtn setTitle:@"Go" forState:UIControlStateNormal];
    [GoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    GoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[GoBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [GoBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [GoBtn.titleLabel setFont:customFontdregs];
    [GoBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GoBtn];
    
    
    CancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.65,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    CancelBtn.layer.cornerRadius = 6.0f;
    [CancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [CancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[CancelBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [CancelBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [CancelBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [CancelBtn.titleLabel setFont:customFontdregs];
    [self.view addSubview:CancelBtn];
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
-(IBAction)nextAction:(id)sender{
    LoginViewController *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:login animated:YES];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)CancelAction:(id)sender{
    ForgotpassViewController *forgot=[[ForgotpassViewController alloc] initWithNibName:@"ForgotpassViewController" bundle:nil];
    [self.navigationController pushViewController:forgot animated:YES];
 
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
