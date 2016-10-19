//
//  AppDelegate.m
//  BenefitBridge
//
//  Created by Infinitum on 17/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "tuche_unlock_ViewController.h"
#import "MainNavigationController.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


@synthesize navController,UrlStringId,touchid,shouldRotate,counter,index;

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (_isLandscapeOK){
        return UIInterfaceOrientationMaskAll;
        
    }
    
    else{
        return UIInterfaceOrientationMaskPortrait;
        
    }
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // in this example, the URL from which the user came is http://example.com/profile/?12345
    // determine if the user was viewing a profile
    if ([[url path] isEqualToString:@"/profile"]) {
        // switch to profile view controller
        // [self.tabBarController setSelectedViewController:profileViewController];
        // pull the profile id number found in the query string
        NSString *profileID = [url query];
        // pass profileID to profile view controller
        //[profileViewController loadProfile:profileID];
    }
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Census" message:@"paramters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    return YES;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *viewController;
    tuche_unlock_ViewController *touch;
    //_isLandscapeOK=NO;
    touchid=YES;
    
    //    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //    NSString *str=[prefs objectForKey:@"FingerLogin"];
    //    if ([str isEqualToString:@"YES"] && str !=nil){
    //    touch=[[tuche_unlock_ViewController alloc] initWithNibName:@"tuche_unlock_ViewController" bundle:nil];
    //        self.navController = [[UINavigationController alloc] initWithRootViewController:touch];
    //
    //    }else{
    //        viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    //        self.navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    //    }
    viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.window.rootViewController=navController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *str=[prefs objectForKey:@"FingerLogin"];
    if ([str isEqualToString:@"YES"] && str !=nil){
        
        if (_issingOut) {
            _issingOut=NO;
            [self TouchAction];
        }
    }
    //    ViewController *viewController;
    //    tuche_unlock_ViewController *touch;
    //
    //    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //    NSString *str=[prefs objectForKey:@"FingerLogin"];
    //    if ([str isEqualToString:@"YES"] && str !=nil){
    //        touch=[[tuche_unlock_ViewController alloc] initWithNibName:@"tuche_unlock_ViewController" bundle:nil];
    //        self.navController = [[UINavigationController alloc] initWithRootViewController:touch];
    //
    //    }else{
    //        viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    //        self.navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    //    }
    //
    //    self.window.rootViewController = self.navController;
    //    [self.window makeKeyAndVisible];
    
}
-(IBAction)TouchAction{
    NSError *error;
    NSString *onlock_reason=@"Login to view your benefits";
    cont=[[LAContext alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if ([cont canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
    {
        [cont evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:onlock_reason reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _offline=false;
                    
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
                            _issingOut=NO;
                            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                            index=0;
                            MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:mainvc];
                            navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
                            [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
                            [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
                            
                        }else
                        {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            
                        }
                    }else{
                        [self getClientLogoData];
                    }
                    
                    NSLog(@"User error msg %@",@"appdelegate");
                    
                });
            } else {
                NSString *str=error.description;
                NSLog(@"User error msg %@",str);
                
                if ([str rangeOfString:@"Fallback"].location != NSNotFound) {
                    NSLog(@"Fallback authentication mechanism selected");
                    counter=counter++;
                    if (counter==3 && [str rangeOfString:@"Biometry"].location == NSNotFound) {
                        //                        ViewController *view=[[ViewController alloc] initWithNibName:nil bundle:nil];
                        //                        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
                        //
                        //                        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:view];
                        //                        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
                        //                        window.rootViewController=navController;
                        //                        [window makeKeyAndVisible];
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BenefitBridge"
                            //                                                                        message:@"Please try again"
                            //                                                                       delegate:self
                            //                                                              cancelButtonTitle:@"Try Again"
                            //                                                              otherButtonTitles:@"Cancel", nil];
                            //                    [alertView show];
                            //                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                            //                                                                                message:error.description
                            //                                                                               delegate:self
                            //                                                                      cancelButtonTitle:@"OK"
                            //                                                                      otherButtonTitles:@"Try Again", nil];
                            //                            [alertView show];
                            
                            NSLog(@"User don't Want");
                            
                        });
                    }
                    
                }else if ([str rangeOfString:@"canceled by system"].location != NSNotFound)
                {
                    //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                    //                                                                        message:error.description
                    //                                                                       delegate:self
                    //                                                              cancelButtonTitle:@"OK"
                    //                                                              otherButtonTitles:@"Try Again", nil];
                    //                    [alertView show];
                    
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BenefitBridge"
                        //                                                                        message:@"Please try again"
                        //                                                                       delegate:self
                        //                                                              cancelButtonTitle:@"Try Again"
                        //                                                              otherButtonTitles:@"Cancel", nil];
                        //                    [alertView show];
                        //                        ViewController *view=[[ViewController alloc] initWithNibName:nil bundle:nil];
                        //                        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
                        //
                        //                        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:view];
                        //                        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
                        //                        window.rootViewController=navController;
                        //                        [window makeKeyAndVisible];
                        
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
}
-(void)getClientLogoData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[activityIndicator stopAnimating];
        //[activityImageView removeFromSuperview];
        
    }else{
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString = [[NSString alloc]initWithFormat:@"%@/EmployeeSelfService/EmployeeSelfService/Employer/EmployerLogoPath/%@",UrlStringId,[prefs objectForKey:@"AbbreviatedClientCode"]];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            //[activityIndicator stopAnimating];
            //[activityImageView removeFromSuperview];
            
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
            index=0;
            MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:mainvc];
            navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
            [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
            [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
            
            //            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            //            index=0;
            //            [self.navigationController pushViewController:mainvc animated:YES];
            
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
