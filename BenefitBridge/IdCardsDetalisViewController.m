//
//  IdCardsDetalisViewController.m
//  demo
//
//  Created by Infinitum on 16/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "IdCardsDetalisViewController.h"
#import "AsyncImageView.h"
#import "BenefitDetailsViewController.h"
#import "Reachability.h"
#import "MYBenefitVO.h"
#import "UIColor+Expanded.h"
#import "MainViewController.h"
#import "idCardsViewController.h"

@interface IdCardsDetalisViewController ()

@end

@implementation IdCardsDetalisViewController
@synthesize myBenefitArray,activityIndicator,tableViewMain,tokenStr,imgArray,idcardsYes,appDelegate,activityImageView,transperentBtn,transperentBtn2;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    appDelegate=[[UIApplication sharedApplication] delegate];
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
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"ID Cards";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
    [leftBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    //[leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    
    imgArray=[[NSMutableArray alloc]initWithObjects:@"Medical_Icon.png",@"Dental_Icon.png",@"Vision_Icon.png",@"life_icon.png",@"life_icon.png",@"Accident_Ins_Icon.png" ,@"Critical_ins_Icon.png",@"Critical_ins_Icon.png",nil];
    
    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,screenRect.size.height*0.13,screenRect.size.width,screenRect.size.height*0.79);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableViewMain];
    
    
    UIImageView * whiteback=[[UIImageView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.92,screenRect.size.width,screenRect.size.height*0.12)];
    [whiteback setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:whiteback];

    UIImageView * logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.93,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *mode=[prefs objectForKey:@"mode"];
    if (![mode isEqualToString:@"offline"]) {
    [self getTokenData];
        NSLog(@"online mode");
    }else{
        NSString *modes=[prefs objectForKey:@"modes"];
        if (![modes isEqualToString:@"offline"]) {
            [self getTokenData];
            NSLog(@"online mode");
        }else{
            [self offlinedata];
            NSLog(@"offline mode");
        }

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

-(void)viewDidAppear:(BOOL)animated{

    appDelegate.isLandscapeOK=NO;
    [tableViewMain reloadData];
}
-(void)getTokenData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *mode=[prefs objectForKey:@"modes"];
        if (![mode isEqualToString:@"offline"]) {

        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

        }else{
        //[activityIndicator stopAnimating];
        [self getClientCode];
    }
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
                    [self getClientCode];
                });
                
            });

        }
    }
}

-(void)offlinedata{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    myBenefitArray=[[NSMutableArray alloc]init];
    NSError *error;
    NSData *mydata = [[NSData alloc] init];
    mydata=[prefs objectForKey:@"IDCards"];
    if (mydata !=nil) {
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
            
            [myBenefitArray addObject:mybvo];
            
        }
        
        [tableViewMain reloadData];
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
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
            }else{
                
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/Employee/CurrentBenefits/%@/%@",[prefs objectForKey:@"LoginId"],tokenStr];
       mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@"Token test : %@",tokenStr);
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];

        }else{
                if (mydata !=nil) {
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
                    
                    [myBenefitArray addObject:mybvo];
                    
                }
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:mydata forKey:@"IDCards"];
            [prefsusername synchronize];

            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];

            [tableViewMain reloadData];
                }else{
                    [activityIndicator stopAnimating];
                    [activityImageView removeFromSuperview];
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

-(IBAction)CancelAction:(id)sender{
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
#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    NSLog(@"%lu",[myBenefitArray count]/2);
    
    if([myBenefitArray count]%2==0)
        
        return [myBenefitArray count]/2;
    
    else
        
        return ([myBenefitArray count]/2)+1;
    
    return 0;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height*0.195;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = 0;
    if(indexPath.row==0)
    {
        
        row=1;
        
    }else{
        
        row=((indexPath.row+1)*2)-1;
        
    }
    MYBenefitVO *myBenVO=[myBenefitArray objectAtIndex:row-1];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.495,screenRect.size.height*0.02,1, screenRect.size.height*0.15)];
    [backgroundView setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
    [cell.contentView addSubview:backgroundView];
    
    
//    if (indexPath.row!=([myBenefitArray count]/2)) {
//        UIView *backgroundViewvir=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.19,screenRect.size.width*0.44,1)];
//        [backgroundViewvir setBackgroundColor:[UIColor whiteColor]];
//        [cell.contentView addSubview:backgroundViewvir];
//    }

    int i=indexPath.row;
        if (indexPath.row>=1) {
            UIView *backgroundViewvir=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.03,0,screenRect.size.width*0.44,1)];
            [backgroundViewvir setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
            [cell.contentView addSubview:backgroundViewvir];
        }
    
    if (indexPath.row>=1) {
        UIView *backgroundViewvir=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.53,0,screenRect.size.width*0.44,1)];
        [backgroundViewvir setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [cell.contentView addSubview:backgroundViewvir];
    }

//    }else{
//        if (indexPath.row!=([myBenefitArray count]/2)) {
//            UIView *backgroundViewvir=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.19,screenRect.size.width*0.44,1)];
//            [backgroundViewvir setBackgroundColor:[UIColor whiteColor]];
//            [cell.contentView addSubview:backgroundViewvir];
//        }
//
//    }

    UIImageView * logoImg;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,10,50,41)];
        
    }else{
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.175,10,50,41)];
        
    }
    if ([myBenVO.Ins_Type isEqualToString:@"Medical"]) {
        [logoImg setImage:[UIImage imageNamed:@"medical_white.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Dental"]){
        [logoImg setImage:[UIImage imageNamed:@"dental_white.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Vision"]){
        [logoImg setImage:[UIImage imageNamed:@"vision_white.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Group Term Life"]){
        [logoImg setImage:[UIImage imageNamed:@"life_white.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Voluntary Term Life"]){
        [logoImg setImage:[UIImage imageNamed:@"default_icon_white.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Accidental Death and Dismemberment"]){
        [logoImg setImage:[UIImage imageNamed:@"accident_insurance_white.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Critical Illness"]){
        [logoImg setImage:[UIImage imageNamed:@"critical_insu_white.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Flexible Spending Account"]){
        [logoImg setImage:[UIImage imageNamed:@"default_icon_white.png"]];
    }else{
        [logoImg setImage:[UIImage imageNamed:@"default_icon_white.png"]];
    }
    [cell.contentView addSubview:logoImg];
    
    UIImage *statusImage = [UIImage imageNamed:@"medical_white.png"];
    NSLog(@"image frame size %f,%f",statusImage.size.width,statusImage.size.height);

    UILabel *feedtextLabel=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,52, screenRect.size.width*0.30, 60)];
    
    int len = [myBenVO.Ins_Type length];
    
    if (len < 10) {
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:16];
    }else if (len > 11 && len < 20){
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:14];
    }else if (len > 21 && len < 30){
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:12];
    }else if (len > 31 && len < 40){
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:10];
    }
    feedtextLabel.textColor=[UIColor whiteColor];
    feedtextLabel.text=myBenVO.Ins_Type;
    feedtextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    feedtextLabel.numberOfLines = 3;
    feedtextLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:feedtextLabel];
    
    
    transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(2, 5, screenRect.size.width*0.47, screenRect.size.height*0.18)];
    transperentBtn.tag=row-1;
    NSLog(@"tag first button%ld",row-1);
    [transperentBtn setBackgroundColor:[UIColor clearColor]];
    [transperentBtn addTarget:self action:@selector(videoAlertDialog:) forControlEvents:UIControlEventTouchUpInside];
    [transperentBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [cell.contentView addSubview:transperentBtn];
    
    if([myBenefitArray count]>row){
        
        //mediaVO=[mediaArray objectAtIndex:row];
        MYBenefitVO *myBenVO=[myBenefitArray objectAtIndex:row];
//        if (indexPath.row!=([myBenefitArray count]/2)-1) {
//
//        UIView *backgroundViewvir=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.53,screenRect.size.height*0.193,screenRect.size.width*0.44,1)];
//        [backgroundViewvir setBackgroundColor:[UIColor whiteColor]];
//        [cell.contentView addSubview:backgroundViewvir];
//        }
        
//        int arrycount=[myBenefitArray count];
//        if (arrycount >=3) {
//            if (indexPath.row>=1) {
//
//            UIView *backgroundViewvir=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.53,0,screenRect.size.width*0.44,1)];
//            [backgroundViewvir setBackgroundColor:[UIColor whiteColor]];
//            [cell.contentView addSubview:backgroundViewvir];
//            }else{
//                        UIView *backgroundViewvir=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.53,screenRect.size.height*0.193,screenRect.size.width*0.44,1)];
//                        [backgroundViewvir setBackgroundColor:[UIColor whiteColor]];
//                        [cell.contentView addSubview:backgroundViewvir];
//
//            }
//        }
//

        UIImageView * logoImg;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.70,10,50,41)];
            
        }else{
            logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.675,10,50,41)];
            
        }
        
        if ([myBenVO.Ins_Type isEqualToString:@"Medical"]) {
            [logoImg setImage:[UIImage imageNamed:@"medical_white.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Dental"]){
            [logoImg setImage:[UIImage imageNamed:@"dental_white.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Vision"]){
            [logoImg setImage:[UIImage imageNamed:@"vision_white.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Group Term Life"]){
            [logoImg setImage:[UIImage imageNamed:@"life_white.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Voluntary Term Life"]){
            [logoImg setImage:[UIImage imageNamed:@"default_icon_white.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Accidental Death and Dismemberment"]){
            [logoImg setImage:[UIImage imageNamed:@"accident_insurance_white.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Critical Illness"]){
            [logoImg setImage:[UIImage imageNamed:@"critical_insu_white.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Flexible Spending Account"]){
            [logoImg setImage:[UIImage imageNamed:@"default_icon_white.png"]];
        }else{
            [logoImg setImage:[UIImage imageNamed:@"default_icon_white.png"]];
        }
        [cell.contentView addSubview:logoImg];
        
        int len = [myBenVO.Ins_Type length];
        
        UILabel *feedtextLabel2=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.60,52, screenRect.size.width*0.30,60)];
        if (len < 10) {
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:16];
        }else if (len > 11 && len < 20){
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:14];
        }else if (len > 21 && len < 30){
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:12];
        }else if (len > 31 && len < 40){
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:10];
        }
        feedtextLabel2.textColor=[UIColor whiteColor];
        feedtextLabel2.text=myBenVO.Ins_Type;
        feedtextLabel2.lineBreakMode = NSLineBreakByWordWrapping;
        feedtextLabel2.numberOfLines = 3;
        feedtextLabel2.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:feedtextLabel2];
        
        transperentBtn2=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.502,5, screenRect.size.width*0.47, screenRect.size.height*0.18)];
        transperentBtn2.tag=row;
        [transperentBtn setBackgroundColor:[UIColor clearColor]];
        [transperentBtn2 addTarget:self action:@selector(videoAlertDialog:) forControlEvents:UIControlEventTouchUpInside];
        [transperentBtn2 setBackgroundImage:[UIImage imageNamed:@"ic_check_box_outline_blank_white_2x.png"]forState:UIControlStateSelected];
        [cell.contentView addSubview:transperentBtn2];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

-(void)videoAlertDialog:(UIButton*)btn{
    
    UIButton *button = (UIButton *)btn;
    [button setBackgroundColor:[UIColor colorWithHexString:@"D9D9D9"]];
    button.alpha = 0.8; //Alpha runs from 0.0 to 1.0

        MYBenefitVO *mvo=[myBenefitArray objectAtIndex:btn.tag];
        idCardsViewController *myBenefit=[[idCardsViewController alloc] initWithNibName:@"idCardsViewController" bundle:nil];
        myBenefit.myBenesVO=[[MYBenefitVO alloc ]init];
        myBenefit.myBenesVO=mvo;
        [self.navigationController pushViewController:myBenefit animated:YES];
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
