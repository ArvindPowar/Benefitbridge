//
//  LoginViewController.m
//  demo
//
//  Created by Infinitum on 07/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "MainViewController.h"
#import "AsyncImageView.h"
#import "Reachability.h"
#import "ForgotpassViewController.h"
#import "ViewController.h"
#import "MainNavigationController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize usernameTxt,passwordTxt,goBtn,cancelBtn,forgotBtn,logoImg,tokenStr,activityIndicator,clientCodeToken,appDelegate,activityImageView,counter,AbbreviatedClientCode;
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
    titleLabel.text=@"Sign in";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:14.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;

    CGRect screenRect = [[UIScreen mainScreen] bounds];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //demo hospital banner image view
        UIImageView *bannerAsyncimg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.30, screenRect.size.height*.13, screenRect.size.width*.40, screenRect.size.height*.07)];
        [bannerAsyncimg.layer setMasksToBounds:YES];
        bannerAsyncimg.clipsToBounds=YES;
        [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];
        NSData *receivedData = (NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"clientlogo"];
        UIImage *image = [[UIImage alloc] initWithData:receivedData];
        bannerAsyncimg.image=image;
        [self.view addSubview:bannerAsyncimg];
    
    //benefit bridge logo bottom
    logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.92,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:14.0f];

    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];
    
    //user name text field
    [[UITextField appearance] setTintColor:[UIColor blackColor]];
    usernameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.32,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    usernameTxt.font=font1;
    usernameTxt.textAlignment=NSTextAlignmentLeft;
    usernameTxt.delegate = self;
    usernameTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders = [CALayer layer];
    bottomBorders.frame = CGRectMake(0.0f, usernameTxt.frame.size.height - 1, usernameTxt.frame.size.width, 1.0f);
    bottomBorders.backgroundColor = [UIColor lightGrayColor].CGColor;
    [usernameTxt.layer addSublayer:bottomBorders];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    usernameTxt.leftView = paddingView;
    usernameTxt.leftViewMode = UITextFieldViewModeAlways;
    //self.usernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: color}];
    NSMutableAttributedString * strings = [[NSMutableAttributedString alloc] initWithString:@"User Name*"];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,9)];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9,1)];
    self.usernameTxt.attributedPlaceholder=strings;
    [self.view addSubview:usernameTxt];

    //password text field
    passwordTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.41,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    passwordTxt.font=font1;
    passwordTxt.textAlignment=NSTextAlignmentLeft;
    passwordTxt.delegate = self;
    passwordTxt.secureTextEntry = YES;
 
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, passwordTxt.frame.size.height - 1, passwordTxt.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [passwordTxt.layer addSublayer:bottomBorder];
    UIView *paddingViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    passwordTxt.leftView = paddingViews;
    passwordTxt.leftViewMode = UITextFieldViewModeAlways;
    passwordTxt.textColor=[UIColor colorWithHexString:@"434444"];
    //self.passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    NSMutableAttributedString * stringss = [[NSMutableAttributedString alloc] initWithString:@"Password*"];
    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,8)];
    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8,1)];
    self.passwordTxt.attributedPlaceholder=stringss;
    [self.view addSubview:passwordTxt];

    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.035];

    //go button
    goBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.51,screenRect.size.height*0.50,screenRect.size.width*0.39,screenRect.size.height*0.05)];
    goBtn.layer.cornerRadius = 6.0f;
    [goBtn setTitle:@"Go" forState:UIControlStateNormal];
    [goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[goBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [goBtn setBackgroundColor:[UIColor colorWithHexString:@"d08c2a"]];
    [goBtn.titleLabel setFont:customFontdregs];
    [goBtn addTarget:self action:@selector(LoginGoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBtn];
    
    //cancel button
    cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.50,screenRect.size.width*0.39,screenRect.size.height*0.05)];
    cancelBtn.layer.cornerRadius = 6.0f;
    [cancelBtn setTitle:@"Back" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[cancelBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [cancelBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn.titleLabel setFont:customFontdregs];
    [self.view addSubview:cancelBtn];

    forgotBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.52,screenRect.size.height*0.53,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    forgotBtn.layer.cornerRadius = 6.0f;
    [forgotBtn setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    [forgotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgotBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[forgotBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [forgotBtn setBackgroundColor:[UIColor clearColor]];
    [forgotBtn.titleLabel setFont:customFontdregs];
    [forgotBtn addTarget:self action:@selector(ForgotAction:) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:forgotBtn];
    
    //touch id is enable then added this design
    NSString *strs=[prefs objectForKey:@"FingerLogin"];
    if ([strs isEqualToString:@"YES"] && strs !=nil){
        NSMutableAttributedString *yourString = [[NSMutableAttributedString alloc] initWithString:@"Sign in with Touch ID"];
        [yourString addAttribute:NSUnderlineStyleAttributeName
                           value:[NSNumber numberWithInt:1]
                           range:(NSRange){0,21}];
        
        UILabel *tuochTxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.56,screenRect.size.width*0.60,screenRect.size.height*0.05)];
        [tuochTxt setFont:customFontdregs];
        tuochTxt.attributedText=[yourString copy];
        tuochTxt.textAlignment=NSTextAlignmentCenter;
        [tuochTxt setBackgroundColor:[UIColor clearColor]];
        [tuochTxt setTextColor:[UIColor blackColor]];
        [self.view addSubview:tuochTxt];
        
        UIButton * tuochBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.56,screenRect.size.width*0.60,screenRect.size.height*0.05)];
        tuochBtn.layer.cornerRadius = 6.0f;
        [tuochBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tuochBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //[tuochBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
        [tuochBtn.titleLabel setFont:customFontdregs];
        
        [tuochBtn setBackgroundColor:[UIColor clearColor]];
        [tuochBtn addTarget:self action:@selector(TouchAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tuochBtn];
    }
    
    UIFont *customFontdreg = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.035];
    
    //term and condition button
//    NSMutableAttributedString *yourString = [[NSMutableAttributedString alloc] initWithString:@"Use your BenefitBridge login and password for this app"];
//    [yourString addAttribute:NSUnderlineStyleAttributeName
//                       value:[NSNumber numberWithInt:1]
//                       range:(NSRange){40,18}];
    
    UILabel *firsttTxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.80,screenRect.size.width*0.96,30)];
    [firsttTxt setFont:customFontdreg];
    firsttTxt.text=@"Use your BenefitBridge login and password for this app";
    firsttTxt.textAlignment=NSTextAlignmentCenter;
    [firsttTxt setBackgroundColor:[UIColor clearColor]];
    [firsttTxt setTextColor:[UIColor grayColor]];
    [self.view addSubview:firsttTxt];
    
//    UIButton * conditionBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.11,screenRect.size.height*0.86,screenRect.size.width*0.90,30)];
//    [conditionBtn setBackgroundColor:[UIColor clearColor]];
//    //[conditionBtn addTarget:self action:@selector(conditionAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:conditionBtn];

    
//    usernameTxt.text=@"Bsaoji@keenan.com";
//    passwordTxt.text=@"Butterfly123!";
}
- (NSUInteger)supportedInterfaceOrientations
{
    appDelegate.isLandscapeOK=NO;
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

//touch id  alert view
-(IBAction)TouchAction{
    NSError *error;
    NSString *onlock_reason=@"Login to view your benefits";
    cont=[[LAContext alloc]init];
    if ([cont canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

        [cont evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:onlock_reason reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
                    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
                    if(myStatus == NotReachable)
                    {
                        NSString *mode=[prefs objectForKey:@"mode"];
                        if ([mode isEqualToString:@"offline"]) {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Offline mode"
                                                                                message:@"Internet is not available continuing in offline mode"
                                                                               delegate:self
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil, nil];
                            [alertView show];
                            [prefs setObject:@"offline" forKey:@"modes"];
                            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                            appDelegate.index=0;
                            appDelegate.issingOut=NO;
                            [self.navigationController pushViewController:mainvc animated:YES];
                        }else{
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    }else{
                        [prefs setObject:@"online" forKey:@"modes"];
                        [self getClientLogoData];
                        appDelegate.issingOut=NO;
                    }
                    [prefs synchronize];
                });
            } else {
                NSString *str=error.description;
                NSLog(@"User error msg %@",str);
                
                if ([str rangeOfString:@"Fallback"].location != NSNotFound) {
                    NSLog(@"Fallback authentication mechanism selected");
                    counter=counter++;
                    if (counter==3 && [str rangeOfString:@"Biometry"].location == NSNotFound) {
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            NSLog(@"User don't Want");
                            
                        });
                    }
                    
                }else if ([str rangeOfString:@"canceled by system"].location != NSNotFound)
                {
                    
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSLog(@"User don't Want");
                        
                    });
                }
            }
        }];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:error.description
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        });
    }
}

-(IBAction)ForgotAction:(id)sender{
    ForgotpassViewController *forgot=[[ForgotpassViewController alloc] initWithNibName:@"ForgotpassViewController" bundle:nil];
    [self.navigationController pushViewController:forgot animated:YES];
    
}

-(IBAction)GoAction:(id)sender{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    [self.navigationController pushViewController:mainvc animated:YES];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void) threadStartAnimating:(id)data {
    UIImage *statusImage = [UIImage imageNamed:@"tmp-0.gif"];
    activityImageView = [[UIImageView alloc]
                                      initWithImage:statusImage];
    
    [activityImageView setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
    activityImageView.layer.cornerRadius=8.0f;
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"tmp-0.gif"],
                                         [UIImage imageNamed:@"tmp-1.gif"],
                                         [UIImage imageNamed:@"tmp-2.gif"],
                                         [UIImage imageNamed:@"tmp-3.gif"],
                                         [UIImage imageNamed:@"tmp-4.gif"],
                                         [UIImage imageNamed:@"tmp-5.gif"],
                                         [UIImage imageNamed:@"tmp-6.gif"],
                                         [UIImage imageNamed:@"tmp-7.gif"],
                                         [UIImage imageNamed:@"tmp-8.gif"],
                                         [UIImage imageNamed:@"tmp-9.gif"],
                                         [UIImage imageNamed:@"tmp-10.gif"],
                                         [UIImage imageNamed:@"tmp-11.gif"],
                                         [UIImage imageNamed:@"tmp-12.gif"],
                                         [UIImage imageNamed:@"tmp-13.gif"],
                                         [UIImage imageNamed:@"tmp-14.gif"],
                                         [UIImage imageNamed:@"tmp-15.gif"],
                                         [UIImage imageNamed:@"tmp-16.gif"],
                                         [UIImage imageNamed:@"tmp-17.gif"],
                                         [UIImage imageNamed:@"tmp-18.gif"],
                                         [UIImage imageNamed:@"tmp-19.gif"],
                                         [UIImage imageNamed:@"tmp-20.gif"],
                                         [UIImage imageNamed:@"tmp-21.gif"],
                                         [UIImage imageNamed:@"tmp-22.gif"],
                                         [UIImage imageNamed:@"tmp-23.gif"],
                                         [UIImage imageNamed:@"tmp-24.gif"],
                                         [UIImage imageNamed:@"tmp-25.gif"],
                                         [UIImage imageNamed:@"tmp-26.gif"],
                                         [UIImage imageNamed:@"tmp-27.gif"],
                                         [UIImage imageNamed:@"tmp-28.gif"],
                                         [UIImage imageNamed:@"tmp-29.gif"],
                                         [UIImage imageNamed:@"tmp-30.gif"],
                                         [UIImage imageNamed:@"tmp-31.gif"],
                                         [UIImage imageNamed:@"tmp-32.gif"],
                                         [UIImage imageNamed:@"tmp-33.gif"],
                                         [UIImage imageNamed:@"tmp-34.gif"],
                                         [UIImage imageNamed:@"tmp-35.gif"],
                                         [UIImage imageNamed:@"tmp-36.gif"],
                                         [UIImage imageNamed:@"tmp-37.gif"],
                                         [UIImage imageNamed:@"tmp-38.gif"],
                                         [UIImage imageNamed:@"tmp-39.gif"],
                                         [UIImage imageNamed:@"tmp-40.gif"],
                                         [UIImage imageNamed:@"tmp-41.gif"],
                                         [UIImage imageNamed:@"tmp-42.gif"],
                                         [UIImage imageNamed:@"tmp-43.gif"],
                                         [UIImage imageNamed:@"tmp-44.gif"],
                                         [UIImage imageNamed:@"tmp-45.gif"],
                                         [UIImage imageNamed:@"tmp-46.gif"],
                                         [UIImage imageNamed:@"tmp-47.gif"],
                                         [UIImage imageNamed:@"tmp-48.gif"],
                                         [UIImage imageNamed:@"tmp-49.gif"],
                                         [UIImage imageNamed:@"tmp-50.gif"],
                                         [UIImage imageNamed:@"tmp-51.gif"],
                                         [UIImage imageNamed:@"tmp-52.gif"],
                                         [UIImage imageNamed:@"tmp-53.gif"],
                                         [UIImage imageNamed:@"tmp-54.gif"],
                                         [UIImage imageNamed:@"tmp-55.gif"],
                                         [UIImage imageNamed:@"tmp-56.gif"],
                                         [UIImage imageNamed:@"tmp-57.gif"],
                                         [UIImage imageNamed:@"tmp-58.gif"],
                                         [UIImage imageNamed:@"tmp-59.gif"], nil];
    
    activityImageView.animationDuration = 1.5;
    activityImageView.frame = CGRectMake(
                                         self.view.frame.size.width/2
                                         -35,
                                         self.view.frame.size.height/2
                                         -35,70,
                                         70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
}

-(IBAction)LoginGoBtnClick:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // [self isPasswordValid:self.passwordtext.text];
        Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
        NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
        if(myStatus == NotReachable)
        {
            NSString *mode=[prefs objectForKey:@"mode"];
            if ([mode isEqualToString:@"offline"]) {
                if ([usernameTxt.text isEqualToString:@""]) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"User name is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }else{
                    NSString *username=[prefs objectForKey:@"username"];
                    if ([username isEqualToString:usernameTxt.text]) {
                        [prefs setObject:@"offline" forKey:@"modes"];
                        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                        appDelegate.index=0;
                        appDelegate.issingOut=NO;
                        [self.navigationController pushViewController:mainvc animated:YES];
                    }else{
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Offline information does not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else{
            if ([usernameTxt.text isEqualToString:@""] || [passwordTxt.text isEqualToString:@""]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"User name and Password are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else{
            [prefs setObject:@"online" forKey:@"modes"];
            [self getTokenData];
        }
    }
}

//generate token web service
-(void)getTokenData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

    }else{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];

        NSString *urlString = [[NSString alloc]initWithFormat:@"%@/SecurityAPI/Auth/GenerateToken/%@",appDelegate.UrlStringId,@"mobileapp"];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];

        }else{
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSString *messages = [[NSString alloc]init];
            messages = [userDict objectForKey:@"Password"];
            tokenStr = [[NSString alloc]init];
            NSString *str = [userDict objectForKey:@"Token"];
           tokenStr =[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"Token :%@",tokenStr);
            [self getLoginData];
        }
    }
}
//client code web service
-(void)getClientCode{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];
    }else{
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"https://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/User/UserDetails/%@/%@",usernameTxt.text,clientCodeToken];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@" User name : %@",[prefs objectForKey:@"username"]);
        NSLog(@"Token clientCodeToken : %@",clientCodeToken);
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                                            length:[mydata length] encoding: NSUTF8StringEncoding];
                              NSError *error;
                              if ([content isEqualToString:@""]) {
                                  [activityIndicator stopAnimating];
                                  [activityImageView removeFromSuperview];

                              }else{
                                  NSString *username=[prefs objectForKey:@"username"];
                                  if (username!=nil) {
                                      if (![username isEqualToString:usernameTxt.text] ) {
                                          NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                                          [prefs setObject:@"NO" forKey:@"FingerLogin"];
                                          [prefs setObject:@"Online" forKey:@"mode"];
                                          [prefs synchronize];
                                      }
                                  }
                                NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
                                  
                                  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                                  [prefs setObject:userDict forKey:@"AbbreviatedClientCode"];
                                  
                                  AbbreviatedClientCode=[[NSString alloc]init];
                    AbbreviatedClientCode = [userDict objectForKey:@"AbbreviatedClientCode"];
                                [prefs setObject:AbbreviatedClientCode forKey:@"AbbreviatedClientCode"];
                                  
                                  
                                  NSString *ClientName = [userDict objectForKey:@"ClientName"];
                                  [prefs setObject:ClientName forKey:@"ClientName"];
                                  
                                  NSString *ClietnCode = [userDict objectForKey:@"ClietnCode"];
                                  [prefs setObject:ClietnCode forKey:@"clientcode"];
                                  
                                  NSString *DisplayName = [userDict objectForKey:@"DisplayName"];
                                  [prefs setObject:DisplayName forKey:@"DisplayName"];
                                  
                                  NSString *EmailAddress = [userDict objectForKey:@"EmailAddress"];
                                  [prefs setObject:EmailAddress forKey:@"EmailAddress"];
                                  
                                  NSString *FirstName = [userDict objectForKey:@"FirstName"];
                                  [prefs setObject:FirstName forKey:@"FirstName"];
                                  
                                  NSString *LastName = [userDict objectForKey:@"LastName"];
                                  [prefs setObject:LastName forKey:@"LastName"];
                                  
                                  NSString *LoginId = [userDict objectForKey:@"LoginId"];
                                  [prefs setObject:LoginId forKey:@"LoginId"];
                                  
                                  NSString *SSN = [userDict objectForKey:@"SSN"];
                                  [prefs setObject:SSN forKey:@"SSN"];
                                  
                                  NSString *SubscriberCode = [userDict objectForKey:@"SubscriberCode"];
                                  [prefs setObject:SubscriberCode forKey:@"SubscriberCode"];
                                  
                                  NSString *UserId = [userDict objectForKey:@"UserId"];
                                  [prefs setObject:UserId forKey:@"UserId"];
                                  
                                  NSString *UserName = [userDict objectForKey:@"UserName"];
                                  [prefs setObject:UserName forKey:@"UserName"];
                                  
                                  [activityIndicator stopAnimating];
                                  [activityImageView removeFromSuperview];

                                  [prefs setObject:usernameTxt.text forKey:@"username"];
                                  [prefs synchronize];

                                  if ([AbbreviatedClientCode isEqualToString:appDelegate.keytext]) {
                                      MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                                      appDelegate.index=0;
                                      appDelegate.issingOut=NO;
                                      [self.navigationController pushViewController:mainvc animated:YES];

                                  }else{
                                      [self getClientLogoData];
                                      NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
                                      [prefsusername setObject:ClietnCode forKey:@"clientcode"];
                                      [prefsusername synchronize];
                        }
                }
        }
}

//client logo web service
-(void)getClientLogoData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

    }else{

        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString = [[NSString alloc]initWithFormat:@"%@/EmployeeSelfService/EmployeeSelfService/Employer/EmployerLogoPath/%@",appDelegate.UrlStringId,[prefs objectForKey:@"AbbreviatedClientCode"]];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid Employer Code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            NSString *newStr = [content substringFromIndex:1];
            NSString *newString = [newStr substringToIndex:[newStr length]-1];
            NSString *urlStr=[NSString stringWithFormat:@"https://www.benefitbridge.com/images/clientslogo/%@",newString];
            NSURL* url = [NSURL URLWithString:urlStr];
            NSData *receivedData = [NSData dataWithContentsOfURL:url];
            
            [prefsusername setObject:receivedData forKey:@"clientlogo"];
            [prefsusername synchronize];
            NSLog(@"clientlogo :%@",content);
            
            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            appDelegate.index=0;
            appDelegate.issingOut=NO;

            [self.navigationController pushViewController:mainvc animated:YES];

        }
    }
}
-(void)getLoginData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

        UIAlertView * alerts = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerts show];
        
    }else{
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UserName=%@&Password=%@",usernameTxt.text,passwordTxt.text]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/SecurityAPI/login/%@/",tokenStr];
        
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                [activityIndicator stopAnimating];
                [activityImageView removeFromSuperview];
                NSLog(@"Failed to submit request");
            }
            else
            {
                [activityIndicator stopAnimating];
                [activityImageView removeFromSuperview];
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                
                if ([content isEqualToString:@"false"]) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                }else if([content isEqualToString:@"true"]){
                    [self getToken];
                }
            }
        }];
    }
}
//regular token generater web service
-(void)getToken{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[activityIndicator stopAnimating];
        [activityImageView stopAnimating];
    }else{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/Auth/GenerateToken/mobileapp"];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView stopAnimating];
        }else{
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSString *messages = [[NSString alloc]init];
            messages = [userDict objectForKey:@"Password"];
            clientCodeToken = [[NSString alloc]init];
            clientCodeToken = [userDict objectForKey:@"Token"];
            NSLog(@"clientCodeToken :%@",clientCodeToken);
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:clientCodeToken forKey:@"Token"];
            [prefsusername synchronize];
            
            [self getClientCode];
        }
    }
}
-(void)viewDidAppear:(BOOL)animated{
    appDelegate.isLandscapeOK=NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(IBAction)CancelAction:(id)sender{
    ViewController *view=[[ViewController alloc] initWithNibName:nil bundle:nil];
    appDelegate.touchid=NO;
    appDelegate.issingOut=YES;
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
