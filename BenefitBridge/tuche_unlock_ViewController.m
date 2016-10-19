//
//  tuche_unlock_ViewController.m
//  demo
//
//  Created by Infinitum on 18/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "tuche_unlock_ViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "UIColor+Expanded.h"
#import "ViewController.h"
@interface tuche_unlock_ViewController ()
{
    BOOL CheckFlag;
}

@end

@implementation tuche_unlock_ViewController
@synthesize appDelegate,logoImg,nameImg,FingurBtn,CheckBtn,enterpasswordBtn,counter;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
//    UILabel *titleLabel = [[UILabel alloc] init];
//    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
//    titleLabel.text=@"Touch Login";
//    [titleLabel setTextColor: [self colorFromHexString:@"03687f"]];
//    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
//    titleLabel.font=font1s;
//    self.navigationItem.titleView = titleLabel;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CheckFlag=NO;
    counter=0;
    UIColor *darkOp = [self colorFromHexString:@"03687f"];  //03687f
    UIColor *lightOp = [self colorFromHexString:@"05819d"]; //05819d
    
    // Create the gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)lightOp.CGColor,
                       (id)darkOp.CGColor,
                       nil];
    
    // Set bounds
    gradient.frame = screenRect;

    // Add the gradient to the view
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.375,screenRect.size.height*0.22,screenRect.size.width*0.25,screenRect.size.width*0.25)];
    [logoImg setImage:[UIImage imageNamed:@"loading_logo.png"]];
    [self.view addSubview:logoImg];
    
    nameImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.40,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [nameImg setImage:[UIImage imageNamed:@"BenefitBridge_Logo_256X256_withborder.png"]];
    [self.view addSubview:nameImg];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.04];
    FingurBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.54,screenRect.size.width*0.86,screenRect.size.height*0.05)];
    FingurBtn.layer.cornerRadius = 6.0f;
    [FingurBtn setTitle:@"Finger Scan" forState:UIControlStateNormal];
    [FingurBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    FingurBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[submitBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [FingurBtn.titleLabel setFont:customFontdregs];
    [FingurBtn setBackgroundColor:[UIColor colorWithHexString:@"d08c2a"]];
    [FingurBtn addTarget:self action:@selector(FingerTouchAction) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:FingurBtn];

    enterpasswordBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.70,screenRect.size.width*0.86,screenRect.size.height*0.05)];
    enterpasswordBtn.layer.cornerRadius = 6.0f;
    [enterpasswordBtn setTitle:@"Offline Password" forState:UIControlStateNormal];
    [enterpasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    enterpasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[submitBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [enterpasswordBtn.titleLabel setFont:customFontdregs];
    [enterpasswordBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [enterpasswordBtn addTarget:self action:@selector(enterpasswordAction) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:enterpasswordBtn];

    
    NSError *error;
    NSString *onlock_reason=@"Touchid is required to open app";
    cont=[[LAContext alloc]init];
    
    if ([cont canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
    {
        [cont evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:onlock_reason reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    appDelegate.offline=false;
                    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                    [self.navigationController pushViewController:mainvc animated:YES];
                });
            } else {
                                NSString *str=error.description;
                NSLog(@"User error msg %@",str);
                
                if ([str rangeOfString:@"Fallback"].location != NSNotFound) {
                    NSLog(@"Fallback authentication mechanism selected");
                    counter=counter++;
                    if (counter==3 && [str rangeOfString:@"Biometry"].location == NSNotFound) {
                        ViewController *view=[[ViewController alloc] initWithNibName:nil bundle:nil];
                        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
                        
                        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:view];
                        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
                        window.rootViewController=navController;
                        [window makeKeyAndVisible];

                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BenefitBridge"
                            //                                                                        message:@"Please try again"
                            //                                                                       delegate:self
                            //                                                              cancelButtonTitle:@"Try Again"
                            //                                                              otherButtonTitles:@"Cancel", nil];
                            //                    [alertView show];
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                message:error.description
                                                                               delegate:self
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:@"Try Again", nil];
                            [alertView show];
                            
                            NSLog(@"User don't Want");
                            
                        });
                    }

                }else if ([str rangeOfString:@"canceled by system"].location != NSNotFound)
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:error.description
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:@"Try Again", nil];
                    [alertView show];

                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BenefitBridge"
                        //                                                                        message:@"Please try again"
                        //                                                                       delegate:self
                        //                                                              cancelButtonTitle:@"Try Again"
                        //                                                              otherButtonTitles:@"Cancel", nil];
                        //                    [alertView show];
                        ViewController *view=[[ViewController alloc] initWithNibName:nil bundle:nil];
                        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
                        
                        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:view];
                        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
                        window.rootViewController=navController;
                        [window makeKeyAndVisible];
                        
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
            // Rather than show a UIAlert here, use the error to determine if you should push to a keypad for PIN entry.
        });
    }

    // Do any additional setup after loading the view from its nib.
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(void)enterpasswordAction{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BenefitBridge" message:@"Enter Offline Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
                            alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
                            [alertView show];
    UITextField *textfield = [alertView textFieldAtIndex:0];

}
-(void)FingerTouchAction
{
    NSError *error;
    NSString *onlock_reason=@"Touchid is required to open app";
    cont=[[LAContext alloc]init];
    if ([cont canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
    {
        [cont evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:onlock_reason reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    appDelegate.offline=false;
                    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                    [self.navigationController pushViewController:mainvc animated:YES];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BenefitBridge"
//                                                                        message:@"Please try again"
//                                                                       delegate:self
//                                                              cancelButtonTitle:@"Try Again"
//                                                              otherButtonTitles:@"Cancel", nil];
//                    [alertView show];
                    ViewController *view=[[ViewController alloc] initWithNibName:nil bundle:nil];
                    UIWindow* window = [[UIApplication sharedApplication] keyWindow];

                    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:view];
                    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
                    window.rootViewController=navController;
                    [window makeKeyAndVisible];

                    NSLog(@"User don't Want");
                    
                });
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
            // Rather than show a UIAlert here, use the error to determine if you should push to a keypad for PIN entry.
        });
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Try Again"]){
        [self FingerTouchAction];
    }
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
