//
//  MyBenefitViewController.m
//  demo
//
//  Created by Global Networking Resources on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "MyBenefitViewController.h"
#import "AsyncImageView.h"
#import "BenefitDetailsViewController.h"
#import "Reachability.h"
#import "MYBenefitVO.h"
#import "UIColor+Expanded.h"
#import "MainViewController.h"
#import "idCardsViewController.h"
@interface MyBenefitViewController ()

@end

@implementation MyBenefitViewController
@synthesize myBenefitArray,activityIndicator,tableViewMain,tokenStr,imgArray,idcardsYes,activityImageView,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f7f8f8"]];
   // [self.view setBackgroundColor:[UIColor whiteColor]];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    if ([idcardsYes isEqualToString:@"ID Cards"]) {
        titleLabel.text=@"ID Cards";
    }else{
        titleLabel.text=@"My Benefits";
    }
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
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    imgArray=[[NSMutableArray alloc]initWithObjects:@"Medical_Icon.png",@"Dental_Icon.png",@"Vision_Icon.png",@"life_icon.png",@"life_icon.png",@"Accident_Ins_Icon.png" ,@"Critical_ins_Icon.png",@"Critical_ins_Icon.png",nil];

    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,screenRect.size.height*0.13,screenRect.size.width,screenRect.size.height*0.79);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor colorWithHexString:@"f7f8f8"]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableViewMain];

    UIImageView * whiteback=[[UIImageView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.93,screenRect.size.width,screenRect.size.height*0.12)];
    [whiteback setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:whiteback];

    UIImageView * logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.94,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];
    myBenefitArray=[[NSMutableArray alloc]init];

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

    if ([myBenefitArray count]<=0 ) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        });
    }
}
-(void)getTokenData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
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

                if ([activityData objectForKey:@"Carrier_Logo"] != [NSNull null]){
                    mybvo.Carrier_Logo=[activityData objectForKey:@"Carrier_Logo"];
                    mybvo.Carrier_Name=[activityData objectForKey:@"Carrier_Name"];
                    mybvo.Group_ID=[activityData objectForKey:@"Group_ID"];
                    mybvo.Group_Name=[activityData objectForKey:@"Group_Name"];
                    mybvo.Ins_Type=[activityData objectForKey:@"Ins_Type"];
                    mybvo.Policy_Code=[activityData objectForKey:@"Policy_Code"];
                    mybvo.Band_Name=[activityData objectForKey:@"Band_Name"];
                    mybvo.Beneficiaries_Needed=[activityData objectForKey:@"Beneficiaries_Needed"];
                    mybvo.Benefit=[activityData objectForKey:@"Benefit"];
                    mybvo.Carrier_Code=[activityData objectForKey:@"Carrier_Code"];
                    mybvo.Carrier_Group_Num =[activityData objectForKey:@"Carrier_Group_Num"];
                    mybvo.Category=[activityData objectForKey:@"Category"];
                    mybvo.Client_Contribution=[activityData objectForKey:@"Client_Contribution"];
                    mybvo.Coverage=[activityData objectForKey:@"Coverage"];
                    mybvo.Descriptionstr =[activityData objectForKey:@"Description"];
                    mybvo.Div_Code=[activityData objectForKey:@"Div_Code"];
                    mybvo.Div_ID=[activityData objectForKey:@"Div_ID"];
                    mybvo.Div_Name=[activityData objectForKey:@"Div_Name"];
                    mybvo.Group_Code=[activityData objectForKey:@"Group_Code"];
                    mybvo.IncludePCP=[activityData objectForKey:@"IncludePCP"];
                    mybvo.IsCurrentPlan=[activityData objectForKey:@"IsCurrentPlan"];
                    mybvo.IsEnrolledPlan=[activityData objectForKey:@"IsEnrolledPlan"];
                    mybvo.IsPlanAvailableForNextYear=[activityData objectForKey:@"IsPlanAvailableForNextYear"];
                    mybvo.MemberCodes=[activityData objectForKey:@"MemberCodes"];
                    mybvo.MemberCoveragesv=[activityData objectForKey:@"MemberCoverages"];
                    mybvo.PayDeduction=[activityData objectForKey:@"PayDeduction"];
                    mybvo.SortOrder=[activityData objectForKey:@"SortOrder"];
                    mybvo.Sub_Contribution=[activityData objectForKey:@"Sub_Contribution"];
                    mybvo.Xband=[activityData objectForKey:@"Xband"];
                    mybvo.Y1band =[activityData objectForKey:@"Y1band"];
                    mybvo.Y2band=[activityData objectForKey:@"Y2band"];
                    
                    [myBenefitArray addObject:mybvo];
                    }
                }
            [tableViewMain reloadData];
            [activityImageView removeFromSuperview];
            [activityIndicator stopAnimating];
        }
    }
}
- (void) threadStartAnimating:(id)data {
    [activityImageView removeFromSuperview];
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
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self getTokenData];
    });
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
    
    return 177;
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

    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02, 0, screenRect.size.width*0.47, 170)];
    //[backgroundView setBackgroundColor:[UIColor colorWithHexString:@"f7f8f7"]];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    backgroundView.layer.cornerRadius=2.5f;
    backgroundView.layer.borderWidth=1.0f;
    backgroundView.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;

    [cell.contentView addSubview:backgroundView];
    UIImageView * logoImg;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.16,8,35,35)];

    }else{
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,5,35,35)];

    }
    if ([myBenVO.Ins_Type isEqualToString:@"Medical"]) {
        [logoImg setImage:[UIImage imageNamed:@"Medical_Icon.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Dental"]){
        [logoImg setImage:[UIImage imageNamed:@"Dental_Icon.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Vision"]){
        [logoImg setImage:[UIImage imageNamed:@"Vision_Icon.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Group Term Life"]){
        [logoImg setImage:[UIImage imageNamed:@"life_icon.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Voluntary Term Life"]){
        [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Accidental Death and Dismemberment"]){
        [logoImg setImage:[UIImage imageNamed:@"Accident_Ins_Icon.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Critical Illness"]){
        [logoImg setImage:[UIImage imageNamed:@"Critical_ins_Icon.png"]];
    }else if ([myBenVO.Ins_Type isEqualToString:@"Flexible Spending Account"]){
        [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
    }else{
        [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
    }
    [cell.contentView addSubview:logoImg];

    UILabel *feedtextLabel=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.22,10, screenRect.size.width*0.25, 60)];
    
    int len = [myBenVO.Ins_Type length];

    if (len < 10) {
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:16];
    }else if (len > 11 && len < 20){
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:14];
    }else if (len > 21 && len < 30){
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:12];
    }else if (len > 31 && len < 40){
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:10];
    }else{
        feedtextLabel.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:8];

    }
    feedtextLabel.textColor=[UIColor colorWithHexString:@"03687F"];
    feedtextLabel.text=myBenVO.Ins_Type;
    feedtextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    feedtextLabel.numberOfLines = 3;
    feedtextLabel.textAlignment = NSTextAlignmentCenter;
    [feedtextLabel sizeToFit];
    [cell.contentView addSubview:feedtextLabel];

    AsyncImageView *mediaImage=[[AsyncImageView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.075,55, screenRect.size.width*0.35, 75)];
    [mediaImage setBackgroundColor:[UIColor clearColor]];
    NSString *urlStr=[NSString stringWithFormat:@"https://www.benefitbridge.com/images/carrierlogo/%@",myBenVO.Carrier_Logo];
    [mediaImage loadImageFromURL:[NSURL URLWithString:urlStr]];
    //mediaImage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"feed1.png"]];
    [mediaImage.layer setMasksToBounds:YES];
    mediaImage.clipsToBounds=YES;
    [cell.contentView addSubview:mediaImage];


    UILabel *feedtimeLabel=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,100, screenRect.size.width*0.44,85)];
    feedtimeLabel.font = [UIFont fontWithName:@"Open Sans" size:10];
    feedtimeLabel.textColor=[UIColor blackColor];
    feedtimeLabel.text=myBenVO.Group_Name;
    feedtimeLabel.textAlignment = NSTextAlignmentCenter;
    feedtimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    feedtimeLabel.numberOfLines = 0;
    [cell.contentView addSubview:feedtimeLabel];

    UIButton *transperentBtn=[[UIButton alloc] initWithFrame:CGRectMake(2, 0, screenRect.size.width*0.49, 170)];
    transperentBtn.tag=row-1;
    [transperentBtn setBackgroundColor:[UIColor clearColor]];
    [transperentBtn addTarget:self action:@selector(videoAlertDialog:) forControlEvents:UIControlEventTouchUpInside];
   [cell.contentView addSubview:transperentBtn];

    if([myBenefitArray count]>row){
        
        //mediaVO=[mediaArray objectAtIndex:row];
        MYBenefitVO *myBenVO=[myBenefitArray objectAtIndex:row];
        UIView *backgroundView1=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.51, 0, screenRect.size.width*0.47, 170)];
        //[backgroundView1 setBackgroundColor:[UIColor colorWithHexString:@"f7f8f7"]];
        [backgroundView1 setBackgroundColor:[UIColor whiteColor]];

        backgroundView1.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;
        backgroundView1.layer.cornerRadius=2.5f;
        backgroundView1.layer.borderWidth=1.0f;
        [cell.contentView addSubview:backgroundView1];
        UIImageView * logoImg;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.65,8,35,35)];
            
        }else{
            logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.60,5,35,35)];
            
        }

        if ([myBenVO.Ins_Type isEqualToString:@"Medical"]) {
            [logoImg setImage:[UIImage imageNamed:@"Medical_Icon.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Dental"]){
            [logoImg setImage:[UIImage imageNamed:@"Dental_Icon.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Vision"]){
            [logoImg setImage:[UIImage imageNamed:@"Vision_Icon.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Group Term Life"]){
            [logoImg setImage:[UIImage imageNamed:@"life_icon.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Voluntary Term Life"]){
            [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Accidental Death and Dismemberment"]){
            [logoImg setImage:[UIImage imageNamed:@"Accident_Ins_Icon.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Critical Illness"]){
            [logoImg setImage:[UIImage imageNamed:@"Critical_ins_Icon.png"]];
        }else if ([myBenVO.Ins_Type isEqualToString:@"Flexible Spending Account"]){
            [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
        }else{
            [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
        }
        [cell.contentView addSubview:logoImg];

        int len = [myBenVO.Ins_Type length];

        UILabel *feedtextLabel2=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.70,10, screenRect.size.width*0.27, 60)];
        if (len < 10) {
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:16];
        }else if (len > 11 && len < 20){
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:14];
        }else if (len > 21 && len < 30){
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:12];
        }else if (len > 31 && len < 40){
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:10];
        }else{
            feedtextLabel2.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:8];
 
        }
        feedtextLabel2.textColor=[UIColor colorWithHexString:@"03687F"];
        feedtextLabel2.text=myBenVO.Ins_Type;
        feedtextLabel2.lineBreakMode = NSLineBreakByWordWrapping;
        feedtextLabel2.numberOfLines = 3;
        feedtextLabel2.textAlignment = NSTextAlignmentCenter;
        [feedtextLabel2 sizeToFit];
        [cell.contentView addSubview:feedtextLabel2];

        AsyncImageView *mediaImage2=[[AsyncImageView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.575, 60, screenRect.size.width*0.35, 75)];
        [mediaImage2 setBackgroundColor:[UIColor clearColor]];
        NSString *urlStr=[NSString stringWithFormat:@"https://www.benefitbridge.com/images/carrierlogo/%@",myBenVO.Carrier_Logo];
        [mediaImage2 loadImageFromURL:[NSURL URLWithString:urlStr]];
        [cell.contentView addSubview:mediaImage2];


        UILabel *feedtimeLabel2=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.52, 100, screenRect.size.width*0.44,85)];
        feedtimeLabel2.textColor=[UIColor blackColor];
        feedtimeLabel2.font = [UIFont fontWithName:@"Open Sans" size:10];
        feedtimeLabel2.text=myBenVO.Group_Name;
        feedtimeLabel2.textAlignment = NSTextAlignmentCenter;
        feedtimeLabel2.lineBreakMode = NSLineBreakByWordWrapping;
        feedtimeLabel2.numberOfLines = 0;
        [cell.contentView addSubview:feedtimeLabel2];

        UIButton *transperentBtn2=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.502, 0, screenRect.size.width*0.49, 170)];
        transperentBtn2.tag=row;
        [transperentBtn setBackgroundColor:[UIColor clearColor]];
        [transperentBtn2 addTarget:self action:@selector(videoAlertDialog:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:transperentBtn2];

    }
    
    
    [cell setBackgroundColor:[UIColor colorWithHexString:@"f7f8f8"]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

-(void)videoAlertDialog:(UIButton*)btn{
    UIButton *button = (UIButton *)btn;
    [button setBackgroundColor:[UIColor colorWithHexString:@"D9D9D9"]];
    button.alpha = 0.9; //Alpha runs from 0.0 to 1.0

    if ([idcardsYes isEqualToString:@"ID Cards"]) {
        MYBenefitVO *mvo=[myBenefitArray objectAtIndex:btn.tag];
        idCardsViewController *myBenefit=[[idCardsViewController alloc] initWithNibName:@"idCardsViewController" bundle:nil];
        myBenefit.myBenesVO=[[MYBenefitVO alloc ]init];
        myBenefit.myBenesVO=mvo;
        [self.navigationController pushViewController:myBenefit animated:YES];
    }else{
    NSLog(@"Button tag : %ld",(long)btn.tag);
    MYBenefitVO *mvo=[myBenefitArray objectAtIndex:btn.tag];
    BenefitDetailsViewController *myBenefit=[[BenefitDetailsViewController alloc] initWithNibName:@"BenefitDetailsViewController" bundle:nil];
    myBenefit.myBeneVO=[[MYBenefitVO alloc ]init];
    myBenefit.myBeneVO=mvo;
    [self.navigationController pushViewController:myBenefit animated:YES];
    }
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
