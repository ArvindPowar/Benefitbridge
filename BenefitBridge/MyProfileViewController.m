//
//  MyProfileViewController.m
//  demo
//
//  Created by Infinitum on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MainViewController.h"
#import "AsyncImageView/AsyncImageView.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Reachability.h"
#import "MYBenefitVO.h"
#import "UIColor+Expanded.h"
#import "ContactVO.h"
@interface MyProfileViewController ()

@end

@implementation MyProfileViewController
@synthesize firstnameLbl,lastnameLbl,emailLbl,firstnameTxt,lastnameTxt,emailtxt,fingerLogin,appDelegate,offlineSwitch,activityIndicator,activityImageView,tokenStr,idcardsYes,myBenefitArray,imgArray,frontImaStr,BackImaStr,ContactListArray,benefitTypeArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.translucent = NO;
    appDelegate=[[UIApplication sharedApplication] delegate];

//    UIColor *darkOp = [self colorFromHexString:@"03687f"];  //03687f
//    UIColor *lightOp = [self colorFromHexString:@"05819d"]; //05819d
//    
//    // Create the gradient
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    
//    // Set colors
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)lightOp.CGColor,
//                       (id)darkOp.CGColor,
//                       nil];
//    
//    // Set bounds
    CGRect screenRect = [[UIScreen mainScreen] bounds];
//
//    gradient.frame = screenRect;
//    
//    
//    // Add the gradient to the view
//    [self.view.layer insertSublayer:gradient atIndex:0];

    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"My Profile";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
    //[leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    UIFont * fontss =[UIFont fontWithName:@"OpenSans-Bold" size:15.0f];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    UIImageView *bannerAsyncimg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.30, screenRect.size.height*.13, screenRect.size.width*.40, screenRect.size.height*.07)];
    [bannerAsyncimg.layer setMasksToBounds:YES];
    bannerAsyncimg.clipsToBounds=YES;
    [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];
    NSData *receivedData = (NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"clientlogo"];
    UIImage *image = [[UIImage alloc] initWithData:receivedData];
    bannerAsyncimg.image=image;
    [self.view addSubview:bannerAsyncimg];
    
    UIImageView * whiteback=[[UIImageView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.81,screenRect.size.width,screenRect.size.height*0.12)];
    [whiteback setBackgroundColor:[UIColor whiteColor]];
    //[self.view addSubview:whiteback];
    
    UIImageView * logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.92,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];

    
    
    firstnameLbl = [[UILabel alloc] init];
    [firstnameLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.25, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    firstnameLbl.textAlignment = NSTextAlignmentLeft;
    firstnameLbl.text=@"First Name";
    [firstnameLbl setTextColor: [UIColor blackColor]];
    firstnameLbl.font=fontss;
    [self.view addSubview:firstnameLbl];

    firstnameTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.31, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    firstnameTxt.delegate = self;
    firstnameTxt.textAlignment=NSTextAlignmentLeft;
    firstnameTxt.textColor=[UIColor blackColor];
    [firstnameTxt setBackgroundColor:[UIColor clearColor]];
    self.firstnameTxt.font = fonts;
//    [[firstnameTxt layer] setBorderWidth:1.0f];
//    [[firstnameTxt layer] setBorderColor:[UIColor lightGrayColor].CGColor];
//    firstnameTxt.layer.cornerRadius=8.0f;
//    UIView *paddingViewssss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    firstnameTxt.leftView = paddingViewssss;
//    firstnameTxt.leftViewMode = UITextFieldViewModeAlways;

    UIColor *color = [UIColor grayColor];
    color = [color colorWithAlphaComponent:1.0f];
    self.firstnameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:firstnameTxt];

    lastnameLbl = [[UILabel alloc] init];
    [lastnameLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.37, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    lastnameLbl.textAlignment = NSTextAlignmentLeft;
    lastnameLbl.text=@"Last Name";
    [lastnameLbl setTextColor: [UIColor blackColor]];
    lastnameLbl.font=fontss;
    [self.view addSubview:lastnameLbl];
    
    
    lastnameTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.43, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    lastnameTxt.delegate = self;
    lastnameTxt.textAlignment=NSTextAlignmentLeft;
    lastnameTxt.textColor=[UIColor blackColor];
    [lastnameTxt setBackgroundColor:[UIColor clearColor]];
    self.lastnameTxt.font = fonts;
//    [[lastnameTxt layer] setBorderWidth:1.0f];
//    [[lastnameTxt layer] setBorderColor:[UIColor lightGrayColor].CGColor];
//    lastnameTxt.layer.cornerRadius=8.0f;
//    UIView *paddingViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    lastnameTxt.leftView = paddingViews;
//    lastnameTxt.leftViewMode = UITextFieldViewModeAlways;
    color = [color colorWithAlphaComponent:1.0f];
    self.lastnameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:lastnameTxt];

    emailLbl = [[UILabel alloc] init];
    [emailLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.49, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    emailLbl.textAlignment = NSTextAlignmentLeft;
    emailLbl.text=@"Email";
    [emailLbl setTextColor: [UIColor blackColor]];
    emailLbl.font=fontss;
    [self.view addSubview:emailLbl];
    
    emailtxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.55, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    emailtxt.delegate = self;
    emailtxt.textAlignment=NSTextAlignmentLeft;
    emailtxt.textColor=[UIColor blackColor];
    [emailtxt setBackgroundColor:[UIColor clearColor]];
    self.emailtxt.font = fonts;
//    [[emailtxt layer] setBorderWidth:1.0f];
//    [[emailtxt layer] setBorderColor:[UIColor lightGrayColor].CGColor];
//    emailtxt.layer.cornerRadius=8.0f;
//    UIView *paddingViewsss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    emailtxt.leftView = paddingViewsss;
//    emailtxt.leftViewMode = UITextFieldViewModeAlways;
    color = [color colorWithAlphaComponent:1.0f];
    self.emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:emailtxt];

    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        UILabel * fingerToLogin = [[UILabel alloc] init];
        [fingerToLogin setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.63, screenRect.size.width*0.60, screenRect.size.height*0.05)];
        fingerToLogin.textAlignment = NSTextAlignmentLeft;
        fingerToLogin.text=@"Touch ID Sign-In";
        [fingerToLogin setTextColor: [UIColor blackColor]];
        fingerToLogin.font=fontss;
        [self.view addSubview:fingerToLogin];
        
        fingerLogin =[[UISwitch alloc]init];
        NSString *strlo=[prefs objectForKey:@"FingerLogin"];
        if ([strlo isEqualToString:@"YES"] && strlo !=nil){
            fingerLogin.on=YES;
        }
        else{
            fingerLogin.on=NO;
        }
        NSString *modes=[prefs objectForKey:@"modes"];
        if ([modes isEqualToString:@"offline"]) {
            
            fingerLogin.userInteractionEnabled = NO;
            
        }else{
            fingerLogin.userInteractionEnabled = YES;
        }

        [fingerLogin.layer setFrame:CGRectMake(screenRect.size.width*0.70,screenRect.size.height*0.63,screenRect.size.width*0.20,40)];
        [fingerLogin addTarget:self action:@selector(lockappOnOff) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:fingerLogin];
    }
    
    UILabel * fingerToLogin = [[UILabel alloc] init];
    [fingerToLogin setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.73, screenRect.size.width*0.60, screenRect.size.height*0.05)];
    fingerToLogin.textAlignment = NSTextAlignmentLeft;
    fingerToLogin.text=@"Offline mode";
    [fingerToLogin setTextColor: [UIColor blackColor]];
    fingerToLogin.font=fontss;
    [self.view addSubview:fingerToLogin];

    offlineSwitch=[[UISwitch alloc]init];
    [offlineSwitch.layer setFrame:CGRectMake(screenRect.size.width*0.70,screenRect.size.height*0.73,screenRect.size.width*0.20,40)];
    [offlineSwitch addTarget:self action:@selector(OnOfflineMode) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:offlineSwitch];
    NSString *modes=[prefs objectForKey:@"modes"];
    if ([modes isEqualToString:@"offline"]) {
    offlineSwitch.userInteractionEnabled = NO;
    }else{
        offlineSwitch.userInteractionEnabled = YES;
      }
    NSString *mode=[prefs objectForKey:@"mode"];
    if ([mode isEqualToString:@"offline"]) {
        offlineSwitch.on=YES;
    }else{
        offlineSwitch.on=NO;
    }
    NSString *FirstName=[prefs objectForKey:@"FirstName"];
    firstnameTxt.text=FirstName;
    NSString *LastName=[prefs objectForKey:@"LastName"];
    lastnameTxt.text=LastName;
    NSString *EmailAddress=[prefs objectForKey:@"EmailAddress"];
    emailtxt.text=EmailAddress;

    firstnameTxt.enabled = NO;
    lastnameTxt.enabled = NO;
    emailtxt.enabled = NO;
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

-(void)viewDidAppear:(BOOL)animated{
    appDelegate.isLandscapeOK=NO;
}

-(IBAction)lockappOnOff{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(fingerLogin.on == YES)
    {
        [prefs setObject:@"YES" forKey:@"FingerLogin"];
        NSLog(@"FingerLogin YES");
    }else{
        [prefs setObject:@"NO" forKey:@"FingerLogin"];
        NSLog(@"FingerLogin NO");

    }
    [prefs synchronize];
}
-(IBAction)OnOfflineMode{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(offlineSwitch.on == YES)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"This may take a few moments" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }else{
        [prefs setObject:@"online" forKey:@"mode"];
        appDelegate.offline=NO;
    }
    [prefs synchronize];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    [alertView dismissWithClickedButtonIndex:0 animated:NO];
    [alertView dismissWithClickedButtonIndex:1 animated:NO];

    if([title isEqualToString:@"OK"]){
        [self performSelector:@selector(getTokenData) withObject:nil afterDelay:1.0 ];
        appDelegate.offline=YES;
        [prefs setObject:@"offline" forKey:@"mode"];

    }else if([title isEqualToString:@"Cancel"]){
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        offlineSwitch.on=NO;
        [prefs setObject:@"online" forKey:@"mode"];
        appDelegate.offline=NO;
    }
}


-(void)BackAction{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
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
-(void)getTokenData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        offlineSwitch.on=NO;
        [prefs setObject:@"online" forKey:@"mode"];
        appDelegate.offline=NO;
    }else{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/Auth/GenerateToken/mobileapp"];
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
            tokenStr = [userDict objectForKey:@"Token"];
            NSLog(@"Token :%@",tokenStr);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^(){
                   
                    NSLog(@"call contact method");

                    [self getContactData];
                });
            });
        }
    }
}

-(void)getClientCode{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    myBenefitArray=[[NSMutableArray alloc]init];
 
        NSData *mydata;
        NSError *error;
        
        Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
        NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
        if(myStatus == NotReachable){
            
        }else{
            
            NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/Employee/CurrentBenefits/%@/%@",[prefs objectForKey:@"LoginId"],tokenStr];
            mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            NSLog(@"Token test : %@",tokenStr);
            
            NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                          length:[mydata length] encoding: NSUTF8StringEncoding];
            if ([content isEqualToString:@""]) {
                [activityIndicator stopAnimating];
                [activityImageView removeFromSuperview];
            }
        else
        {
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                MYBenefitVO *mybvo=[[MYBenefitVO alloc] init];
                mybvo.Carrier_Logo=[[NSString alloc] init];
                mybvo.Carrier_Name=[[NSString alloc] init];
                mybvo.Group_ID=[[NSString alloc] init];
                mybvo.Group_Name=[[NSString alloc] init];
                mybvo.Ins_Type=[[NSString alloc] init];
                mybvo.Policy_Code=[[NSString alloc] init];
                mybvo.Band_Name=[[NSString alloc] init];
                mybvo.Beneficiaries_Needed=[[NSString alloc] init];
                mybvo.Benefit=[[NSString alloc] init];
                mybvo.Carrier_Code=[[NSString alloc] init];
                mybvo.Carrier_Group_Num=[[NSString alloc] init];
                mybvo.Category=[[NSString alloc] init];
                mybvo.Client_Contribution=[[NSString alloc] init];
                mybvo.Coverage=[[NSString alloc] init];
                mybvo.Descriptionstr=[[NSString alloc] init];
                mybvo.Div_Code=[[NSString alloc] init];
                mybvo.Div_ID=[[NSString alloc] init];
                mybvo.Div_Name=[[NSString alloc] init];
                mybvo.Group_Code=[[NSString alloc] init];
                mybvo.IncludePCP=[[NSString alloc] init];
                mybvo.IsCurrentPlan=[[NSString alloc] init];
                mybvo.IsEnrolledPlan=[[NSString alloc] init];
                mybvo.IsPlanAvailableForNextYear=[[NSString alloc] init];
                mybvo.MemberCodes=[[NSString alloc] init];
                mybvo.MemberCoveragesv=[[NSString alloc] init];
                mybvo.PayDeduction=[[NSString alloc] init];
                mybvo.SortOrder=[[NSString alloc] init];
                mybvo.Sub_Contribution=[[NSString alloc] init];
                mybvo.Xband=[[NSString alloc] init];
                mybvo.Y1band=[[NSString alloc] init];
                mybvo.Y2band=[[NSString alloc] init];
                
                if ([activityData objectForKey:@"Carrier_Logo"] != [NSNull null])
                    mybvo.Carrier_Logo=[activityData objectForKey:@"Carrier_Logo"];
                
                if ([activityData objectForKey:@"Carrier_Name"] != [NSNull null])
                    mybvo.Carrier_Name=[activityData objectForKey:@"Carrier_Name"];
                
                if ([activityData objectForKey:@"Group_ID"] != [NSNull null])
                    mybvo.Group_ID=[activityData objectForKey:@"Group_ID"];
                
                if ([activityData objectForKey:@"Group_Name"] != [NSNull null])
                    mybvo.Group_Name=[activityData objectForKey:@"Group_Name"];
                
                if ([activityData objectForKey:@"Ins_Type"] != [NSNull null])
                    mybvo.Ins_Type=[activityData objectForKey:@"Ins_Type"];
                
                if ([activityData objectForKey:@"Policy_Code"] != [NSNull null])
                    mybvo.Policy_Code=[activityData objectForKey:@"Policy_Code"];
                
                if ([activityData objectForKey:@"Band_Name"] != [NSNull null])
                    mybvo.Band_Name=[activityData objectForKey:@"Band_Name"];
                
                if ([activityData objectForKey:@"Beneficiaries_Needed"] != [NSNull null])
                    mybvo.Beneficiaries_Needed=[activityData objectForKey:@"Beneficiaries_Needed"];
                
                if ([activityData objectForKey:@"Benefit"] != [NSNull null])
                    mybvo.Benefit=[activityData objectForKey:@"Benefit"];
                
                if ([activityData objectForKey:@"Carrier_Code"] != [NSNull null])
                    mybvo.Carrier_Code=[activityData objectForKey:@"Carrier_Code"];
                
                if ([activityData objectForKey:@"Carrier_Group_Num"] != [NSNull null])
                    mybvo.Carrier_Group_Num =[activityData objectForKey:@"Carrier_Group_Num"];
                
                if ([activityData objectForKey:@"Category"] != [NSNull null])
                    mybvo.Category=[activityData objectForKey:@"Category"];
                
                if ([activityData objectForKey:@"Client_Contribution"] != [NSNull null])
                    mybvo.Client_Contribution=[activityData objectForKey:@"Client_Contribution"];
                
                if ([activityData objectForKey:@"Coverage"] != [NSNull null])
                    mybvo.Coverage=[activityData objectForKey:@"Coverage"];
                
                if ([activityData objectForKey:@"Description"] != [NSNull null])
                    mybvo.Descriptionstr =[activityData objectForKey:@"Description"];
                
                if ([activityData objectForKey:@"Div_Code"] != [NSNull null])
                    mybvo.Div_Code=[activityData objectForKey:@"Div_Code"];
                
                if ([activityData objectForKey:@"Div_ID"] != [NSNull null])
                    mybvo.Div_ID=[activityData objectForKey:@"Div_ID"];
                
                if ([activityData objectForKey:@"Div_Name"] != [NSNull null])
                    mybvo.Div_Name=[activityData objectForKey:@"Div_Name"];
                
                if ([activityData objectForKey:@"Group_Code"] != [NSNull null])
                    mybvo.Group_Code=[activityData objectForKey:@"Group_Code"];
                
                if ([activityData objectForKey:@"IncludePCP"] != [NSNull null])
                    mybvo.IncludePCP=[activityData objectForKey:@"IncludePCP"];
                
                if ([activityData objectForKey:@"IsCurrentPlan"] != [NSNull null])
                    mybvo.IsCurrentPlan=[activityData objectForKey:@"IsCurrentPlan"];
                
                if ([activityData objectForKey:@"IsEnrolledPlan"] != [NSNull null])
                    mybvo.IsEnrolledPlan=[activityData objectForKey:@"IsEnrolledPlan"];
                
                if ([activityData objectForKey:@"IsPlanAvailableForNextYear"] != [NSNull null])
                    mybvo.IsPlanAvailableForNextYear=[activityData objectForKey:@"IsPlanAvailableForNextYear"];
                
                if ([activityData objectForKey:@"MemberCodes"] != [NSNull null])
                    mybvo.MemberCodes=[activityData objectForKey:@"MemberCodes"];
                
                if ([activityData objectForKey:@"MemberCoverages"] != [NSNull null])
                    mybvo.MemberCoveragesv=[activityData objectForKey:@"MemberCoverages"];
                
                if ([activityData objectForKey:@"PayDeduction"] != [NSNull null])
                    mybvo.PayDeduction=[activityData objectForKey:@"PayDeduction"];
                
                if ([activityData objectForKey:@"SortOrder"] != [NSNull null])
                    mybvo.SortOrder=[activityData objectForKey:@"SortOrder"];
                
                if ([activityData objectForKey:@"Sub_Contribution"] != [NSNull null])
                    mybvo.Sub_Contribution=[activityData objectForKey:@"Sub_Contribution"];
                
                if ([activityData objectForKey:@"Xband"] != [NSNull null])
                    mybvo.Xband=[activityData objectForKey:@"Xband"];
                
                if ([activityData objectForKey:@"Y1band"] != [NSNull null])
                    mybvo.Y1band =[activityData objectForKey:@"Y1band"];
                
                if ([activityData objectForKey:@"Y2band"] != [NSNull null])
                    mybvo.Y2band=[activityData objectForKey:@"Y2band"];
                
                [self getIDcardsData:mybvo.Ins_Type];
                [myBenefitArray addObject:mybvo];
                
            }
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:mydata forKey:@"IDCards"];
            [prefsusername setObject:mydata forKey:@"ContactCode"];
            [prefsusername synchronize];
            
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
        }
    }
}


-(void)getIDcardsData:(NSString *)ins_type{
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
    NSData *mydata;
    NSString *content;
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/IDCard/GetAllIdCard?UserID=%@&LoginID=%@&SubscriberCode=%@&BenefitType=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"],ins_type];
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@" User name : %@",[prefs objectForKey:@"username"]);
        
        content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                            length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
            
        }else{
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            if ([userArray count]>0) {
                
                NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
                NSDictionary *activityData=[userArray objectAtIndex:0];
                
                frontImaStr=[[NSString alloc]init];
                BackImaStr=[[NSString alloc]init];
                if ([activityData objectForKey:@"IdCardFront"] != [NSNull null]){
                    frontImaStr=[activityData objectForKey:@"IdCardFront"];
                    NSData *nsdatafrontBase64String = [[NSData alloc] initWithBase64EncodedString:frontImaStr options:0];
                    NSString * forntimgName=[NSString stringWithFormat:@"%@_%@_Frontimage.png",[prefs objectForKey:@"UserId"],ins_type];
                    [[NSUserDefaults standardUserDefaults] setObject:nsdatafrontBase64String forKey:forntimgName];

                }
                if ([activityData objectForKey:@"IdCardBack"] != [NSNull null]){
                    BackImaStr=[activityData objectForKey:@"IdCardBack"];
                    NSData *nsdataBackBase64String = [[NSData alloc] initWithBase64EncodedString:BackImaStr options:0];
                    NSString *  BackimgName=[NSString stringWithFormat:@"%@_%@_Backimage.png",[prefs objectForKey:@"UserId"],ins_type];
                    [[NSUserDefaults standardUserDefaults] setObject:nsdataBackBase64String forKey:BackimgName];

                }
                
                }
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
        }
    }
}

-(void)getContactData{
    ContactListArray =[[NSMutableArray alloc]init];
    benefitTypeArray=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    //if ([mode isEqualToString:@"offline"]) {
        Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
        NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
        if(myStatus == NotReachable)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
            
        }else{
            NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/Contacts/GetAllContacts?UserID=%@&LoginID=%@&SubscriberCode=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"]];
            NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            NSLog(@" User name : %@",[prefs objectForKey:@"username"]);
            
            NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                          length:[mydata length] encoding: NSUTF8StringEncoding];
            NSError *error;
            if ([content isEqualToString:@""]) {
                [activityIndicator stopAnimating];
                [activityImageView removeFromSuperview];
                
            }else{
                if (mydata != nil) {
                    NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
                    NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
                    for (int count=0; count<[userArray count]; count++) {
                        
                        NSDictionary *activityData=[userArray objectAtIndex:count];
                        ContactVO *ContactVo=[[ContactVO alloc] init];
                        ContactVo.UserID=[[NSString alloc] init];
                        ContactVo.LoginID=[[NSString alloc] init];
                        ContactVo.SubscriberCode=[[NSString alloc] init];
                        ContactVo.ContactId=[[NSString alloc] init];
                        ContactVo.DrFirstName=[[NSString alloc] init];
                        ContactVo.DrLastName=[[NSString alloc] init];
                        ContactVo.Address=[[NSString alloc] init];
                        ContactVo.City=[[NSString alloc] init];
                        ContactVo.State=[[NSString alloc] init];
                        ContactVo.Country=[[NSString alloc] init];
                        ContactVo.Zip=[[NSString alloc] init];
                        ContactVo.PhNo=[[NSString alloc] init];
                        
                        if ([activityData objectForKey:@"UserID"] != [NSNull null])
                            ContactVo.UserID=[activityData objectForKey:@"UserID"];
                        
                        if ([activityData objectForKey:@"LoginID"] != [NSNull null])
                            ContactVo.LoginID=[activityData objectForKey:@"LoginID"];
                        
                        if ([activityData objectForKey:@"SubscriberCode"] != [NSNull null])
                            ContactVo.SubscriberCode=[activityData objectForKey:@"SubscriberCode"];
                        
                        if ([activityData objectForKey:@"ContactId"] != [NSNull null])
                            ContactVo.ContactId=[activityData objectForKey:@"ContactId"];
                        
                        if ([activityData objectForKey:@"DrFirstName"] != [NSNull null])
                            ContactVo.DrFirstName=[activityData objectForKey:@"DrFirstName"];
                        
                        if ([activityData objectForKey:@"DrLastName"] != [NSNull null])
                            ContactVo.DrLastName=[activityData objectForKey:@"DrLastName"];
                        
                        if ([activityData objectForKey:@"Address"] != [NSNull null])
                            ContactVo.Address=[activityData objectForKey:@"Address"];
                        
                        if ([activityData objectForKey:@"City"] != [NSNull null])
                            ContactVo.City=[activityData objectForKey:@"City"];
                        
                        if ([activityData objectForKey:@"State"] != [NSNull null])
                            ContactVo.State=[activityData objectForKey:@"State"];
                        
                        if ([activityData objectForKey:@"Country"] != [NSNull null])
                            ContactVo.Country=[activityData objectForKey:@"Country"];
                        
                        if ([activityData objectForKey:@"Zip"] != [NSNull null])
                            ContactVo.Zip =[activityData objectForKey:@"Zip"];
                        
                        if ([activityData objectForKey:@"PhNo"] != [NSNull null])
                            ContactVo.PhNo=[activityData objectForKey:@"PhNo"];
                        
                        if ([activityData objectForKey:@"Speciality"] != [NSNull null])
                            ContactVo.Speciality=[activityData objectForKey:@"Speciality"];
                        
                        if ([activityData objectForKey:@"BenefitType"] != [NSNull null])
                            ContactVo.BenefitType=[activityData objectForKey:@"BenefitType"];
                        [benefitTypeArray addObject:ContactVo.BenefitType];
                        [ContactListArray addObject:ContactVo];
                        
                    }
                    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
                    [prefsusername setObject:mydata forKey:@"ContactList"];
                    [prefsusername synchronize];
                    NSLog(@"call benefit type method");

                    [self getClientCode];
                }
            }
    }
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
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    activityImageView.frame = CGRectMake(
                                         screenRect.size.width/2
                                         -35,
                                         screenRect.size.height/2
                                         -85,70,
                                         70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
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
