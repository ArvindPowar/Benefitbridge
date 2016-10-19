//
//  ViewController.m
//  demo
//
//  Created by Infinitum on 06/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Expanded.h"
#import "LoginViewController.h"
#import "Reachability.h"
#import "tuche_unlock_ViewController.h"
#import "UIColor+Expanded.h"
#import "ConditionTermViewController.h"
#import "MainViewController.h"
#import <UIKit/UIKit.h>
@interface ViewController ()
{
    BOOL CheckFlag;
}

@end

@implementation ViewController
@synthesize logoImg,nameImg,keyText,submitBtn,tokenStr,activityIndicator,appDelegate,activityImageView,scrollview,condtionAlertView,counter;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];

    appDelegate.UrlStringId=[[NSString alloc]init];
    appDelegate.UrlStringId=@"http://api.benefitbridge.com";
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBarHidden=YES;
    [activityIndicator stopAnimating];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIColor *darkOp = [self colorFromHexString:@"00697f"];  //03687f  3884ea  2a7ae5
    UIColor *lightOp = [self colorFromHexString:@"08819e"]; //05819d 2096d3   70c7f4
    CAGradientLayer *gradient = [CAGradientLayer layer];
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)darkOp.CGColor,
                       (id)lightOp.CGColor,
                       nil];
    
    // Set bounds
    gradient.frame = screenRect;
    // Add the gradient to the view
    [self.view.layer insertSublayer:gradient atIndex:0];

    //circle logo
    logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.375,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.width*0.25)];
    [logoImg setImage:[UIImage imageNamed:@"loading_logo.png"]];
    [self.view addSubview:logoImg];

    //benefitbridge white logo with white background
    UIImageView *nameImgwhite=[[UIImageView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.40,screenRect.size.width,screenRect.size.height*0.06)];
    [nameImgwhite setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:nameImgwhite];

    nameImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.40,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [nameImg setImage:[UIImage imageNamed:@"BenefitBridge_Logo_256X256_withborder.png"]];
    [self.view addSubview:nameImg];

    //check box button
    CheckFlag=NO;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        _CheckBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.485,screenRect.size.width*0.06,screenRect.size.width*0.06)];

    }else{
        _CheckBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.495,screenRect.size.width*0.06,screenRect.size.width*0.06)];
 
    }
    [_CheckBtn setBackgroundImage:[UIImage imageNamed:@"ic_check_box_outline_blank_white_2x.png"]forState:UIControlStateNormal];
    [_CheckBtn addTarget:self action:@selector(CheckBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //[_CheckBtn setBackgroundColor:[UIColor colorWithHexString:@"d08c2a"]];
    [self.view addSubview:_CheckBtn];
    
    UIFont *customFontdreg = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.03];

//term and condition button
    NSMutableAttributedString *yourString = [[NSMutableAttributedString alloc] initWithString:@"I have read and agreed to BenefitBridge terms & conditions"];
    [yourString addAttribute:NSUnderlineStyleAttributeName
                       value:[NSNumber numberWithInt:1]
                       range:(NSRange){40,18}];
    
    UILabel *firsttTxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.11,screenRect.size.height*0.49,screenRect.size.width*0.90,30)];
    [firsttTxt setFont:customFontdreg];
    firsttTxt.attributedText=[yourString copy];
    firsttTxt.textAlignment=NSTextAlignmentLeft;
    [firsttTxt setBackgroundColor:[UIColor clearColor]];
    [firsttTxt setTextColor:[UIColor whiteColor]];
    [self.view addSubview:firsttTxt];

    UIButton * conditionBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.11,screenRect.size.height*0.49,screenRect.size.width*0.90,30)];
    [conditionBtn setBackgroundColor:[UIColor clearColor]];
    [conditionBtn addTarget:self action:@selector(conditionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:conditionBtn];

    //employer text field
    keyText=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.55, screenRect.size.width*0.96, screenRect.size.height*0.06)];
    keyText.delegate = self;
    keyText.textAlignment=NSTextAlignmentLeft;
    keyText.textColor=[UIColor blackColor];
    [keyText setBackgroundColor:[UIColor whiteColor]];
    CALayer *bottomBorders = [CALayer layer];
    bottomBorders.frame = CGRectMake(0.0f, keyText.frame.size.height - 1, keyText.frame.size.width, 1.0f);
    bottomBorders.backgroundColor = [UIColor lightGrayColor].CGColor;
    [keyText.layer addSublayer:bottomBorders];
    [[UITextField appearance] setTintColor:[UIColor blackColor]];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    keyText.leftView = paddingView;
    keyText.leftViewMode = UITextFieldViewModeAlways;
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:18.0f];
    
    self.keyText.font = font1;
    UIColor *color = [UIColor colorWithHexString:@"ecfbff"];
    
    color = [color colorWithAlphaComponent:1.0f];
    
    NSMutableAttributedString * strings = [[NSMutableAttributedString alloc] initWithString:@"Enter your employer code*"];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,24)];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(24,1)];
    self.keyText.attributedPlaceholder=strings;

    //place holder color 57d0ff
    //keyText.text=@"Keenan";
    //keyText.text=@"demohospital";
    [self.view addSubview:keyText];

    //submit button
    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.035];
    submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.30,screenRect.size.height*0.64,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    submitBtn.layer.cornerRadius = 6.0f;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[submitBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [submitBtn.titleLabel setFont:customFontdregs];

    [submitBtn setBackgroundColor:[UIColor colorWithHexString:@"d08c2a"]];
    [submitBtn addTarget:self action:@selector(SubmitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    //touch id is enable then automatic touch id alert is open
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *str=[prefs objectForKey:@"FingerLogin"];
        if ([str isEqualToString:@"YES"] && str !=nil){

        if (appDelegate.touchid) {
                [self TouchAction];
        }
    
    NSMutableAttributedString *yourString = [[NSMutableAttributedString alloc] initWithString:@"Sign in with Touch ID"];
    [yourString addAttribute:NSUnderlineStyleAttributeName
                               value:[NSNumber numberWithInt:1]
                               range:(NSRange){0,21}];

    UILabel *tuochTxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.71,screenRect.size.width*0.60,screenRect.size.height*0.05)];
    [tuochTxt setFont:customFontdregs];
    tuochTxt.attributedText=[yourString copy];
    tuochTxt.textAlignment=NSTextAlignmentCenter;
    [tuochTxt setBackgroundColor:[UIColor clearColor]];
    [tuochTxt setTextColor:[UIColor whiteColor]];
    [self.view addSubview:tuochTxt];

   UIButton * tuochBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.71,screenRect.size.width*0.60,screenRect.size.height*0.05)];
    tuochBtn.layer.cornerRadius = 6.0f;
    [tuochBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tuochBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[tuochBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [tuochBtn.titleLabel setFont:customFontdregs];
    
    [tuochBtn setBackgroundColor:[UIColor clearColor]];
    [tuochBtn addTarget:self action:@selector(TouchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tuochBtn];

    }
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

//touch id method
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
                        }else
                        {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];

                        }
                    }else{
                        [prefs setObject:@"online" forKey:@"modes"];
                        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                        appDelegate.index=0;
                        appDelegate.issingOut=NO;
                        [self.navigationController pushViewController:mainvc animated:YES];
                    }
                });
                [prefs synchronize];
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

-(void)viewDidAppear:(BOOL)animated{
    appDelegate.isLandscapeOK=NO;

}

//term and condition alert information ui design
- (void)conditionAction
{
    [keyText resignFirstResponder];
    // Here we need to pass a full frame
    condtionAlertView = [[CustomIOS7AlertView alloc] init];
    // Add some custom content to the alert view
    [condtionAlertView setContainerView:[self defaultreportformatAlertView]];
    // Modify the parameters
    [condtionAlertView setDelegate:self];
    // You may use a Block, rather than a delegate.
    [condtionAlertView setUseMotionEffects:true];
    // And launch the dialog
    [condtionAlertView show];
}
-(UIView *)defaultreportformatAlertView{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *demoView;
    UILabel *firsttTxt,*firsttTxt1,*firsttTxt2,*firsttTxt3,*firsttTxt5,*firsttTxt6;
    UIButton *cancelBtn;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width*0.80,screenRect.size.height*0.80)];
        scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width*0.80,screenRect.size.height)];
        firsttTxt=[[UILabel alloc]initWithFrame:CGRectMake(5,0, screenRect.size.width*0.76,30)];
        firsttTxt1=[[UILabel alloc]initWithFrame:CGRectMake(5,30,screenRect.size.width*0.76,screenRect.size.height*0.70)];
        firsttTxt2=[[UILabel alloc]initWithFrame:CGRectMake(5,screenRect.size.height*0.75,screenRect.size.width*0.76,30)];
        firsttTxt3=[[UILabel alloc]initWithFrame:CGRectMake(5,screenRect.size.height*0.80,screenRect.size.width*0.76,screenRect.size.height*0.40)];
        firsttTxt5=[[UILabel alloc]initWithFrame:CGRectMake(5,screenRect.size.height*1.25,screenRect.size.width*0.76,30)];
        firsttTxt6=[[UILabel alloc]initWithFrame:CGRectMake(5,screenRect.size.height*1.30,screenRect.size.width*0.76,screenRect.size.height*0.20)];
        cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.74,screenRect.size.width*0.80,50)];

    }else{
        demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width*0.80,screenRect.size.height*0.80)];
        scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width*0.80,screenRect.size.height)];
        firsttTxt=[[UILabel alloc]initWithFrame:CGRectMake(5,0, screenRect.size.width*0.76,30)];
        firsttTxt1=[[UILabel alloc]initWithFrame:CGRectMake(5,30,screenRect.size.width*0.76,screenRect.size.height*0.80)];
        firsttTxt2=[[UILabel alloc]initWithFrame:CGRectMake(5,screenRect.size.height*0.85,screenRect.size.width*0.76,30)];
        firsttTxt3=[[UILabel alloc]initWithFrame:CGRectMake(5,screenRect.size.height*0.90,screenRect.size.width*0.76,screenRect.size.height*0.50)];
        firsttTxt5=[[UILabel alloc]initWithFrame:CGRectMake(5,screenRect.size.height*1.45,screenRect.size.width*0.76,30)];
        firsttTxt6=[[UILabel alloc]initWithFrame:CGRectMake(5,screenRect.size.height*1.50,screenRect.size.width*0.76,screenRect.size.height*0.20)];
        cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.75,screenRect.size.width*0.80,50)];

    }
    [demoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.PNG"]]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:scrollview];
    
    UIFont *customFontdreg = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.03];
    UIFont *customFontdregbold = [UIFont fontWithName:@"OpenSans-ExtraBold" size:screenRect.size.width*0.03];

    [firsttTxt setFont:customFontdregbold];
    firsttTxt.text=@"Collecting and using Personal Information";
    firsttTxt.textAlignment=NSTextAlignmentLeft;
    [firsttTxt setBackgroundColor:[UIColor clearColor]];
    [firsttTxt setTextColor:[UIColor blackColor]];
    [scrollview addSubview:firsttTxt];

    NSString * string=@"Welcome to the Keenan & Associates (hereinafter referred to as Keenan) mobile app. We will not collect personal information about you unless you provide us that information voluntarily. When you voluntarily provide us with any non-public personal information while visiting or communicating with us through our mobile app, that personal non-public information will be used only for the purposes required to provide you with a response to your inquiries. Keenan defines Personal Information as information that is non-public, individually identifiable information that is confidential, i.e. your name, address and/or social security number.\nKeenan will not sell, license, transmit or disclose this information outside of Keenan and its carriers, affiliated agents and vendors unless expressly authorized by you, or is necessary to enable Keenan's carriers, vendors and/or agents to perform certain functions for Keenan or as required by law. Under all circumstances, however, when disclosure is necessary, we will disclose this information in accordance with applicable laws and regulations and we will also require the recipient of this non-public, individually identifiable personal information to protect the information and use it only for the purpose for which it was provided.";

    
    NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
    paragraphStyles.alignment = NSTextAlignmentJustified;      //justified text
    paragraphStyles.firstLineHeadIndent = 10.0;                //must have a value to make it work

    NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyles};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString: string attributes: attributes];

    [firsttTxt1 setFont:customFontdreg];
    firsttTxt1.attributedText = attributedString;
    firsttTxt1.textAlignment=NSTextAlignmentLeft;
    firsttTxt1.lineBreakMode = NSLineBreakByWordWrapping;
    firsttTxt1.numberOfLines = 0;
    [firsttTxt1 setBackgroundColor:[UIColor clearColor]];
    [firsttTxt1 setTextColor:[UIColor blackColor]];
    firsttTxt1.textAlignment = NSTextAlignmentJustified;
    [scrollview addSubview:firsttTxt1];

    [firsttTxt2 setFont:customFontdregbold];
    firsttTxt2.text=@"Your Email";
    firsttTxt2.textAlignment=NSTextAlignmentLeft;
    [firsttTxt2 setBackgroundColor:[UIColor clearColor]];
    [firsttTxt2 setTextColor:[UIColor blackColor]];
    [scrollview addSubview:firsttTxt2];

    NSString * strings=@"Please note that your email is most likely non-encrypted. Non-encrypted Internet email communications, can and may be accessed and viewed by other Internet users, without your knowledge. Therefore, we recommend that you do not communicate to us information that you would consider to be confidential via Internet email. You can, however, contact us at the numbers provided at various locations on our sites or, in the case of our health plan members, at the Member Services toll free number that appears on your identification card.\nThere are some locations in Keenan's mobile app where we have, to protect your privacy, provided for a more secure environment for the exchange of non-public, confidential  information with you.";
    
    NSMutableParagraphStyle *paragraphStyless = [[NSMutableParagraphStyle alloc] init];
    paragraphStyless.alignment = NSTextAlignmentJustified;      //justified text
    paragraphStyless.firstLineHeadIndent = 10.0;                //must have a value to make it work
    
    NSDictionary *attributess = @{NSParagraphStyleAttributeName: paragraphStyless};
    NSAttributedString *attributedStrings = [[NSAttributedString alloc] initWithString: strings attributes: attributess];

       [firsttTxt3 setFont:customFontdreg];
    firsttTxt3.attributedText = attributedStrings;
    firsttTxt3.textAlignment=NSTextAlignmentLeft;
    firsttTxt3.lineBreakMode = NSLineBreakByWordWrapping;
    firsttTxt3.numberOfLines = 0;
    [firsttTxt3 setBackgroundColor:[UIColor clearColor]];
    [firsttTxt3 setTextColor:[UIColor blackColor]];
    firsttTxt3.textAlignment = NSTextAlignmentJustified;
    [scrollview addSubview:firsttTxt3];

    [firsttTxt5 setFont:customFontdregbold];
    firsttTxt5.text=@"Changes to this statement";
    firsttTxt5.textAlignment=NSTextAlignmentLeft;
    firsttTxt5.lineBreakMode = NSLineBreakByWordWrapping;
    firsttTxt5.numberOfLines = 0;
    [firsttTxt5 setBackgroundColor:[UIColor clearColor]];
    [firsttTxt5 setTextColor:[UIColor blackColor]];
    [scrollview addSubview:firsttTxt5];

    NSString * stringss=@"Keenan may change this Privacy Statement from time to time without notice. This Privacy Statement is not intended to and does not create any contractual or other legal rights in or on behalf of any party.";
    
    NSMutableParagraphStyle *paragraphStylesss = [[NSMutableParagraphStyle alloc] init];
    paragraphStylesss.alignment = NSTextAlignmentJustified;      //justified text
    paragraphStylesss.firstLineHeadIndent = 10.0;                //must have a value to make it work
    
    NSDictionary *attributesss = @{NSParagraphStyleAttributeName: paragraphStyless};
    NSAttributedString *attributedStringss = [[NSAttributedString alloc] initWithString: stringss attributes: attributesss];

    [firsttTxt6 setFont:customFontdreg];
    firsttTxt6.attributedText = attributedStringss;
    firsttTxt6.textAlignment=NSTextAlignmentLeft;
    firsttTxt6.lineBreakMode = NSLineBreakByWordWrapping;
    firsttTxt6.numberOfLines = 0;
    [firsttTxt6 setBackgroundColor:[UIColor clearColor]];
    [firsttTxt6 setTextColor:[UIColor blackColor]];
    firsttTxt6.textAlignment = NSTextAlignmentJustified;
    [scrollview addSubview:firsttTxt6];

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        scrollview.contentSize=CGSizeMake(300,screenRect.size.height*1.8);
    }else{
        scrollview.contentSize=CGSizeMake(300,screenRect.size.height*2);

    }
    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.045];

    [cancelBtn setTitle:@"Close" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn.titleLabel setFont:customFontdregs];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [demoView addSubview:cancelBtn];
    return demoView;
}
-(void)closeAlert:(id)sender{
    [condtionAlertView close];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"]){
        tuche_unlock_ViewController  *touch=[[tuche_unlock_ViewController alloc] initWithNibName:@"tuche_unlock_ViewController" bundle:nil];
        [self.navigationController pushViewController:touch animated:YES];
    }
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(IBAction)SubmitBtnAction:(id)sender{
   LoginViewController  *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:login animated:YES];
}
-(IBAction)CheckBtnClick:(id)sender
{
    if (CheckFlag==NO)
    {
        [self.CheckBtn setImage:[UIImage imageNamed:@"ic_check_box_white_2x.png"] forState:UIControlStateNormal];
        CheckFlag=YES;
    }
    else if (CheckFlag==YES)
    {
        [self.CheckBtn setImage:[UIImage imageNamed:@"ic_check_box_outline_blank_white_2x.png"] forState:UIControlStateNormal];
        CheckFlag=NO;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.keyText resignFirstResponder];
    return YES;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {   unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//token generate web services
-(void)getTokenData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[activityIndicator stopAnimating];
    }else{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];

        NSString *urlString = [[NSString alloc]initWithFormat:@"%@/EmployeeSelfService/EmployeeSelfService/Auth/GenerateToken/mobileapp",appDelegate.UrlStringId];
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
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:tokenStr forKey:@"Token"];
            [prefsusername synchronize];
            [self getClientLogoData];
        }
    }
}

//client logo web services
-(void)getClientLogoData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

    }else{
        appDelegate.keytext=[[NSString alloc]init];
        appDelegate.keytext=keyText.text;
        NSString *urlString = [[NSString alloc]initWithFormat:@"%@/EmployeeSelfService/EmployeeSelfService/Employer/EmployerLogoPath/%@",appDelegate.UrlStringId,keyText.text];
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
            [prefsusername setObject:keyText.text forKey:@"employeename"];
            [prefsusername synchronize];
            NSLog(@"clientlogo :%@",content);
            
            [self getClientCode];
        }
    }
}
//client code generate web service
-(void)getClientCode{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

    }else{
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"%@/EmployeeSelfService/EmployeeSelfService/User/GetClientCodeByAbbreviationCode/%@/%@",appDelegate.UrlStringId,keyText.text,tokenStr];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
        }else{
            NSLog(@"clientcode :%@",content);
            NSString *numberString;
            
            NSScanner *scanner = [NSScanner scannerWithString:content];
            NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            
            // Throw away characters before the first number.
            [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
            
            // Collect numbers.
            [scanner scanCharactersFromSet:numbers intoString:&numberString];
            NSLog(@"numberString :%@",numberString);
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:numberString forKey:@"clientcodes"];
            [prefsusername synchronize];
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
            LoginViewController  *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            appDelegate.offline=false;
            appDelegate.issingOut=YES;
            [self.navigationController pushViewController:login animated:YES];
            
        }
    }
}

//activity image view 
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

-(IBAction)SubmitClick:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (CheckFlag==YES) {
        if ([keyText.text isEqualToString:@""]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Employer code is mandatory" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
        }else{
            Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
            NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
            if(myStatus == NotReachable)
            {
                NSString *mode=[prefs objectForKey:@"mode"];
                if ([mode isEqualToString:@"offline"]) {
                    NSString *employeename=[prefs objectForKey:@"employeename"];
                    if ([employeename isEqualToString:keyText.text]) {
                        [prefs setObject:@"offline" forKey:@"modes"];
                        LoginViewController  *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        appDelegate.issingOut=YES;
                        [self.navigationController pushViewController:login animated:YES];
                    }else{
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Offline information does not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }

                }else{
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }else{
                [prefs setObject:@"online" forKey:@"modes"];
                [self getTokenData];
            }
        }
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please accept terms & conditions" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

@end
