//
//  ContactListViewController.m
//  demo
//
//  Created by Infinitum on 13/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "ContactListViewController.h"
#import "AsyncImageView.h"
#import "UIColor+Expanded.h"
#import "ContactViewController.h"
#import "MainViewController.h"
#import "Reachability.h"
#import "ContactVO.h"
#import "MYBenefitVO.h"

static NSString *kDeleteAllTitle = @"Delete All";
static NSString *kDeletePartialTitle = @"Delete (%d)";

@interface ContactListViewController (){
    NSMutableDictionary *sectionContentDict;
    NSMutableArray      *arrayForBool;
}


@end

@implementation ContactListViewController
@synthesize ContactListArray,tableViewMain,imgArray,activityIndicator,appDelegate,benefitTypeArray,index,activityImageView,tokenStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    [activityIndicator stopAnimating];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"Provider Contacts";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    appDelegate.contactsubmitdeleteupdate=false;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
    //[leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *mode=[prefs objectForKey:@"modes"];
    if (![mode isEqualToString:@"offline"]) {

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setFrame:CGRectMake(0, 0,30,30)];
    //[rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(Addaction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"font-awesome_4-6-3_user-plus_60_10_851c2b_none.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIFont * fonts =[UIFont fontWithName:@"OpenSans-ExtraBold" size:50.0f];
    rightBtn.titleLabel.font = fonts;
    [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
    [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIImageView *bannerAsyncimg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.30, screenRect.size.height*.13, screenRect.size.width*.40, screenRect.size.height*.07)];
    [bannerAsyncimg.layer setMasksToBounds:YES];
    bannerAsyncimg.clipsToBounds=YES;
    [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];
    NSData *receivedData = (NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"clientlogo"];
    UIImage *image = [[UIImage alloc] initWithData:receivedData];
    bannerAsyncimg.image=image;
    [self.view addSubview:bannerAsyncimg];
    
    imgArray=[[NSMutableArray alloc]initWithObjects:@"Medical_Icon.png",@"Dental_Icon.png",@"Vision_Icon.png",@"life_icon.png",@"life_icon.png",@"Accident_Ins_Icon.png" ,@"Critical_ins_Icon.png",@"Critical_ins_Icon.png",nil];

    // [self.view addSubview:bannerAsyncimg];
    // This code one another method get home data
    
    // [activityIndicator stopAnimating];
    [self setFontFamily:@"Open Sans" forView:self.view andSubViews:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.translucent = NO;
    
    //uitableview display
    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,screenRect.size.height*0.22,screenRect.size.width,screenRect.size.height*0.70);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableViewMain];
    
    //benefitbridge image view
    UIImageView * logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.92,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];
    appDelegate.contact=NO;
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
            if (!appDelegate.contact) {
                dispatch_async(dispatch_get_main_queue(), ^(){
                    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                    
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    NSString *mode=[prefs objectForKey:@"mode"];
                    if (![mode isEqualToString:@"offline"]) {
                        [self performSelector:@selector(getContactData) withObject:nil afterDelay:1.0 ];
                        NSLog(@"online mode");
                    }else{
                        NSString *modes=[prefs objectForKey:@"modes"];
                        if (![modes isEqualToString:@"offline"]) {
                            [self performSelector:@selector(getContactData) withObject:nil afterDelay:1.0 ];
                            NSLog(@"online mode");
                        }else{
                            [self performSelector:@selector(offlinemodeview) withObject:nil afterDelay:1.0 ];
                            NSLog(@"offline mode");
                        }
                    }
                });
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
    activityImageView.frame = CGRectMake(
                                         self.view.frame.size.width/2
                                         -35,
                                         self.view.frame.size.height/2
                                         -35,70,
                                         70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];

}
//offline mode disign
-(void)offlinemodeview{
    ContactListArray =[[NSMutableArray alloc]init];
    benefitTypeArray=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *mydata = [[NSData alloc] init];
    mydata=[prefs objectForKey:@"ContactList"];
        NSError *error;
        if (mydata !=nil) {
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
        }else{
            [activityImageView removeFromSuperview];
            [activityIndicator stopAnimating];
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtn setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.10, screenRect.size.width*0.90, 35)];
            [rightBtn setTitle:@"No providers contact available" forState:UIControlStateNormal];
            //[rightBtn addTarget:self action:@selector(Addaction:) forControlEvents:UIControlEventTouchUpInside];
            //[rightBtn setBackgroundImage:[UIImage imageNamed:@"user_plus.png"] forState:UIControlStateNormal];
            UIFont * fonts =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
            rightBtn.titleLabel.font = fonts;
            [rightBtn setTintColor:[self colorFromHexString:@"#03687f"]];
            [self.view addSubview:rightBtn];
            
        }
        
        appDelegate.benefitTypeArray=[[NSMutableArray alloc]init];
        
        NSData *mydatas = [[NSData alloc] init];
        mydatas=[prefs objectForKey:@"ContactCode"];
        if (mydatas !=nil) {
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydatas options:0 error:&error];
            NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                MYBenefitVO *mybvo=[[MYBenefitVO alloc] init];
                mybvo.Category=[[NSString alloc] init];
                mybvo.Ins_Type=[[NSString alloc] init];
                
                if ([activityData objectForKey:@"Ins_Type"] != [NSNull null])
                    mybvo.Ins_Type=[activityData objectForKey:@"Ins_Type"];
                
                if ([activityData objectForKey:@"Category"] != [NSNull null])
                    mybvo.Category=[activityData objectForKey:@"Category"];
                
                if (1 == [mybvo.Category intValue] || 2 == [mybvo.Category intValue]) {
                    [appDelegate.benefitTypeArray addObject:mybvo.Ins_Type];
                }
            }
            
            [self createArray];
            
        }else{
            [activityImageView removeFromSuperview];
            [activityIndicator stopAnimating];
            
        }
    [activityImageView removeFromSuperview];
    [activityIndicator stopAnimating];

}
//online mode with get contact web service
-(void)getContactData{
    ContactListArray =[[NSMutableArray alloc]init];
    benefitTypeArray=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
            NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
            if(myStatus == NotReachable)
            {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                            [activityIndicator stopAnimating];
                            [activityImageView removeFromSuperview];

        }else{
            NSError *error;
            NSString *mode=[prefs objectForKey:@"mode"];
            NSData *mydata = [[NSData alloc] init];
            mydata=[prefs objectForKey:@"ContactList"];

            if (mydata !=nil && [mode isEqualToString:@"offline"] && appDelegate.contactsubmitdeleteupdate==false) {
                NSLog(@"Loacl contact data");
            }else{
                NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/Contacts/GetAllContacts?UserID=%@&LoginID=%@&SubscriberCode=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"]];
                mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                
                NSLog(@" User name : %@",[prefs objectForKey:@"username"]);
                
                NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                              length:[mydata length] encoding: NSUTF8StringEncoding];
                if ([content isEqualToString:@""]) {
                    [activityIndicator stopAnimating];
                    [activityImageView removeFromSuperview];
                    
                    CGRect screenRect = [[UIScreen mainScreen] bounds];
                    
                    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    [rightBtn setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.10, screenRect.size.width*0.90, 35)];
                    [rightBtn setTitle:@"Add providers contact information here" forState:UIControlStateNormal];
                    [rightBtn addTarget:self action:@selector(Addaction:) forControlEvents:UIControlEventTouchUpInside];
                    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"user_plus.png"] forState:UIControlStateNormal];
                    UIFont * fonts =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                    rightBtn.titleLabel.font = fonts;
                    [rightBtn setTintColor:[self colorFromHexString:@"#03687f"]];
                    [self.view addSubview:rightBtn];
                }
            }

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
                [activityIndicator stopAnimating];

                [self getTokenData];
                }
            }
}
//get token ws
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
                    [self getClientCode];
                    
                });
                
            });
        }
    }
}

// get client code ws
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
        appDelegate.benefitTypeArray=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/Employee/CurrentBenefits/%@/%@",[prefs objectForKey:@"LoginId"],tokenStr];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@"Token test : %@",tokenStr);
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
            
        }else{
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                MYBenefitVO *mybvo=[[MYBenefitVO alloc] init];
                mybvo.Category=[[NSString alloc] init];
                mybvo.Ins_Type=[[NSString alloc] init];
                
                if ([activityData objectForKey:@"Ins_Type"] != [NSNull null])
                mybvo.Ins_Type=[activityData objectForKey:@"Ins_Type"];

                if ([activityData objectForKey:@"Category"] != [NSNull null])
                    mybvo.Category=[activityData objectForKey:@"Category"];
                    
                    if (1 == [mybvo.Category intValue] || 2 == [mybvo.Category intValue]) {
                        [appDelegate.benefitTypeArray addObject:mybvo.Ins_Type];
                    }
                }
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:mydata forKey:@"ContactCode"];
            [prefsusername synchronize];

            [self createArray];
            [activityImageView removeFromSuperview];
            [activityIndicator stopAnimating];
        }
    }
}

// sort the array to asceding order
-(void)createArray{
    NSMutableArray * array2=[[NSMutableArray alloc]init];
    
    for (int count=0; count<[benefitTypeArray count]; count++) {
        NSString *benefittype=[benefitTypeArray objectAtIndex:count];
        [array2 addObject:benefittype];
    }
    
    NSMutableArray * array2a=[[NSMutableArray alloc]init];
    array2a=array2;
    array2=[[NSMutableArray alloc]init];

    for (id obj in array2a)
    {
        if (![array2 containsObject:obj])
        {
            [array2 addObject: obj];
        }
    }
    benefitTypeArray=[[NSMutableArray alloc]init];
    for (int count=0; count<[array2 count]; count++) {
        NSString *benefittype=[array2 objectAtIndex:count];
        if ([benefittype isEqualToString:@"Medical"]) {
            [benefitTypeArray addObject:@"Medical"];
            [array2 removeObjectAtIndex:count];
        }
    }
    for (int counts=0; counts<[array2 count]; counts++) {
        NSString *benefittype=[array2 objectAtIndex:counts];
        if ([benefittype isEqualToString:@"Dental"]){
            [benefitTypeArray addObject:@"Dental"];
            [array2 removeObjectAtIndex:counts];
        }
    }
    for (int countss=0; countss<[array2 count]; countss++) {
        
        NSString *benefittype=[array2 objectAtIndex:countss];
        if ([benefittype isEqualToString:@"Vision"]){
            [benefitTypeArray addObject:@"Vision"];
            [array2 removeObjectAtIndex:countss];
        }
    }
    for (int countss=0; countss<[array2 count]; countss++) {
        
        NSString *benefittype=[array2 objectAtIndex:countss];
        if ([benefittype isEqualToString:@"Pharmacy"]){
            [benefitTypeArray addObject:@"Pharmacy"];
            [array2 removeObjectAtIndex:countss];
        }
    }

    for (int countsss=0; countsss<[array2 count]; countsss++) {
        NSSortDescriptor *priceDescriptor = [NSSortDescriptor
                                             sortDescriptorWithKey:@""
                                             ascending:YES
                                             selector:@selector(compare:)];
        NSArray *descriptors = @[priceDescriptor];
        [array2 sortUsingDescriptors:descriptors];
    }
    for (int counta=0; counta<[array2 count]; counta++) {
        NSString *benefittype=[array2 objectAtIndex:counta];
        [benefitTypeArray addObject:benefittype];
    }
    arrayForBool=[[NSMutableArray alloc]init];
    for (int count=0; count<[benefitTypeArray count]; count++) {
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
    }
    [activityImageView removeFromSuperview];
    [activityIndicator stopAnimating];

        [tableViewMain reloadData];
}
-(IBAction)CancelAction:(id)sender{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
    
}
-(IBAction)Addaction:(int)sender{
    ContactViewController *contact=[[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:nil];
    contact.editing=[[NSString alloc]init];
    contact.editing=@"YES";
    [self.navigationController pushViewController:contact animated:YES];
    
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }else if ([view isKindOfClass:[UIButton class]])
    {
        UIButton *btn = (UIButton *)view;
        btn.titleLabel.font = [UIFont fontWithName:fontFamily size:[[btn.titleLabel font] pointSize]];
    }else if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *textfield = (UITextField *)view;
        [textfield setFont:[UIFont fontWithName:fontFamily size:[[textfield font] pointSize]]];
    }else if ([view isKindOfClass:[UITextView class]])
    {
        UITextView *textfield = (UITextView *)view;
        [textfield setFont:[UIFont fontWithName:fontFamily size:[[textfield font] pointSize]]];
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marl - UITableView Data Source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [benefitTypeArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[arrayForBool objectAtIndex:section] boolValue]) {
        NSString *  personname;
        personname= [benefitTypeArray objectAtIndex:section];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"BenefitType = %@", personname];
        NSArray *filterArray = [ContactListArray filteredArrayUsingPredicate:predicate];
        
        return [filterArray count];
    }
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(10, 0, tableView.frame.size.width, 50.0)];
    
    [sectionHeaderView setBackgroundColor:[UIColor colorWithHexString:@"03687f"]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(50,10,sectionHeaderView.frame.size.width-90,30)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:15];
    headerLabel.textColor=[UIColor whiteColor];
    NSString *  personname;
    personname= [benefitTypeArray objectAtIndex:section];
    headerLabel.text=personname;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [sectionHeaderView addSubview:headerLabel];
    
    BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIImageView *dashboardImage=[[UIImageView alloc]initWithFrame:CGRectMake(10,10,20,20)];
    
    if (!manyCells) {
        [dashboardImage setImage:[UIImage imageNamed:@"plus.png"]];
        
    }else{
        [dashboardImage setImage:[UIImage imageNamed:@"minus.png"]];
    }
    [sectionHeaderView addSubview:dashboardImage];

    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionHeaderView addGestureRecognizer:headerTapped];
    sectionHeaderView.tag= section;

    return sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int height=45;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        int height=screenRect.size.height*0.10;
        return height;
    }
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];
    if (!manyCells) {
        [footer setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
        
    }else{
        [footer setBackgroundColor:[UIColor clearColor]];
        
    }
    
    return footer;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *NameLbl,*NameLbls;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
    if (!manyCells) {
        // cell.textLabel.text = @"click to enlarge";
    }
    else{

    NSString *  personname;
    personname= [benefitTypeArray objectAtIndex:indexPath.section];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"BenefitType = %@", personname];
    NSArray *filterArray = [ContactListArray filteredArrayUsingPredicate:predicate];
        
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"DrFirstName" ascending:YES];
    filterArray = [filterArray sortedArrayUsingDescriptors:@[sd]];
        
    ContactVO * contactVOs=[filterArray objectAtIndex:indexPath.row];
    
    NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(12, 0, screenRect.size.width*0.45,screenRect.size.height*0.10)];
    NameLbls=[[UILabel alloc] initWithFrame:CGRectMake(40, 32, screenRect.size.width*0.45, 25)];

    NameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:17];
    NameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
        if (contactVOs.DrLastName==nil || [contactVOs.DrLastName isEqualToString:@"(null)"]) {
            contactVOs.DrLastName=@"";
        }
    NSString *firstLastname=[NSString stringWithFormat:@"%@ %@",contactVOs.DrFirstName,contactVOs.DrLastName];
    NameLbl.text=firstLastname;
    NameLbl.textAlignment = NSTextAlignmentLeft;
    NameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    NameLbl.numberOfLines = 0;
    [cell.contentView addSubview:NameLbl];
        
        int len = [contactVOs.Speciality length];
        
        UILabel *feedtextLabel2=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.70,10, screenRect.size.width*0.27, 60)];
        UILabel  * SpecialityLbls;
        if (len > 25) {
            SpecialityLbls=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.52,0, screenRect.size.width*0.33, screenRect.size.height*0.10)];
            SpecialityLbls.font = [UIFont fontWithName:@"OpenSans-Bold" size:10];
        }else {
            SpecialityLbls=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.52,0, screenRect.size.width*0.33, screenRect.size.height*0.10)];
            SpecialityLbls.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
        }
        SpecialityLbls.font = [UIFont fontWithName:@"OpenSans-Bold" size:10];
        SpecialityLbls.textColor=[UIColor colorWithHexString:@"03687f"];
        SpecialityLbls.text=contactVOs.Speciality;
        SpecialityLbls.textAlignment = NSTextAlignmentLeft;
        SpecialityLbls.lineBreakMode = NSLineBreakByWordWrapping;
        SpecialityLbls.numberOfLines = 0;
        [cell.contentView addSubview:SpecialityLbls];
        
   UIButton * CallBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.86,screenRect.size.height*0.01,40,40)];
    CallBtn.layer.cornerRadius = 6.0f;
    [CallBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CallBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [CallBtn addTarget:self action:@selector(CallBtn:) forControlEvents:UIControlEventTouchUpInside];
    [CallBtn setBackgroundImage:[UIImage imageNamed:@"fa-phone_60_10_03687f_none.png"]forState:UIControlStateNormal];
    CallBtn.tag=indexPath.row;
    [cell.contentView addSubview:CallBtn];

        
        UILabel  * line=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.095, screenRect.size.width,1)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [cell.contentView addSubview:line];

    tableView.backgroundColor=[UIColor clearColor];
    //Your main thread code goes in here
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        for (int count=0; count<[arrayForBool count]; count++) {
            [arrayForBool replaceObjectAtIndex:count withObject:[NSNumber numberWithBool:NO]];
        }
        [tableViewMain reloadData];
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableViewMain reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)CallBtn:(UIButton *)Btn{
    
    UITableViewCell *projectcell=(UITableViewCell *)[Btn superview];
    NSIndexPath *indexPath = [tableViewMain indexPathForCell: projectcell.superview];
    NSLog(@"indexpath section and row %ld %ld",(long)indexPath.row,(long)indexPath.section);

    NSString *  personname;
    personname= [benefitTypeArray objectAtIndex:indexPath.section];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"BenefitType = %@", personname];
    NSArray *filterArray = [ContactListArray filteredArrayUsingPredicate:predicate];
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"DrFirstName" ascending:YES];
    filterArray = [filterArray sortedArrayUsingDescriptors:@[sd]];

    ContactVO * contactVOs=[filterArray objectAtIndex:indexPath.row];

    NSString* Strr2 = [contactVOs.PhNo stringByReplacingOccurrencesOfString:@"-"   withString:@""];
    NSLog(@"phone number :- %@",Strr2);
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        NSString *phoneNumber =Strr2;
        NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURLString]];
    } else {
        UIAlertView *warning =[[UIAlertView alloc] initWithTitle:@"Note" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [warning show];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        ContactViewController *contact=[[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:nil];
    contact.editing=[[NSString alloc]init];
    contact.editing=@"NO";
    
    NSString *  personname;
    personname= [benefitTypeArray objectAtIndex:indexPath.section];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"BenefitType = %@", personname];
    NSArray *filterArray = [ContactListArray filteredArrayUsingPredicate:predicate];
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"DrFirstName" ascending:YES];
    filterArray = [filterArray sortedArrayUsingDescriptors:@[sd]];
    ContactVO * contactVOs=[filterArray objectAtIndex:indexPath.row];

    contact.contactVOS=[[ContactVO alloc]init];
    contact.contactVOS=contactVOs;
        [self.navigationController pushViewController:contact animated:YES];
    
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
