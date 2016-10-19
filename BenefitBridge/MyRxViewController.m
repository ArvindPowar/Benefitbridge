//
//  MyRxViewController.m
//  BenefitBridge
//
//  Created by Infinitum on 28/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import "MyRxViewController.h"
#import "UIColor+Expanded.h"
#import "MainViewController.h"
#import "DrugsFirstListViewController.h"
#import "DrugFirstVO.h"
#import "MyRxSearchViewController.h"
#import "DrugsDetalisViewController.h"
#import "DosageVO.h"
#import "Reachability.h"
@interface MyRxViewController ()

@end

@implementation MyRxViewController
@synthesize appDelegate,tableViewMain,searchBar,mainArray,msgLbl,activityImageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(BackAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    appDelegate=[[UIApplication sharedApplication] delegate];

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
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"My Rx";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;

    CGRect screenRect = [[UIScreen mainScreen] bounds];

//    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, screenRect.size.width*0.90, 44.0)];
//    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [searchBar setBackgroundColor:[UIColor clearColor]];
//    searchBar.placeholder=@"Search";
//    searchBar.tintColor=[UIColor clearColor];
//    searchBar.barTintColor = [UIColor whiteColor];
//    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, 60, screenRect.size.width*0.90, 44.0)];
//    searchBarView.autoresizingMask = 0;
//    searchBar.delegate = self;
//    [searchBarView addSubview:searchBar];
//    [searchBarView setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:searchBarView];
    
    appDelegate.mainArray=[[NSMutableArray alloc]init];

    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    tableViewMain.separatorInset = UIEdgeInsetsZero;
    tableViewMain.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:tableViewMain];

    dispatch_async(dispatch_get_main_queue(), ^(){
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *mode=[prefs objectForKey:@"mode"];
        if (![mode isEqualToString:@"offline"]) {
            [self performSelector:@selector(getMedicineData) withObject:nil afterDelay:1.0 ];
            NSLog(@"online mode");
        }else{
            NSString *modes=[prefs objectForKey:@"modes"];
            if (![modes isEqualToString:@"offline"]) {
                [self performSelector:@selector(getMedicineData) withObject:nil afterDelay:1.0 ];
                NSLog(@"online mode");
            }else{
                [self performSelector:@selector(offlinemodeview) withObject:nil afterDelay:1.0 ];
                NSLog(@"offline mode");
            }
        }
    });

}

-(IBAction)Addaction:(int)sender{
    DrugsFirstListViewController *search=[[DrugsFirstListViewController alloc] initWithNibName:@"DrugsFirstListViewController" bundle:nil];
    [self.navigationController pushViewController:search animated:YES];
}

//-(void)viewDidAppear:(BOOL)animated{
//    if ([appDelegate.mainArray count]>0) {
//        [msgLbl removeFromSuperview];
//    }else{
//        CGRect screenRect = [[UIScreen mainScreen] bounds];
//        [msgLbl removeFromSuperview];
//        msgLbl = [[UILabel alloc] init];
//        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.width*0.90, 35)];
//        msgLbl.textAlignment = NSTextAlignmentCenter;
//        //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
//        msgLbl.text=@"No medicine found";
//        [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
//        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
//        msgLbl.font=font1s;
//        [self.view addSubview:msgLbl];
//    }
//    [tableViewMain reloadData];
//}
-(void)viewDidAppear:(BOOL)animated{
    appDelegate.isLandscapeOK=NO;

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
    appDelegate.mainArray=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *mydata = [[NSData alloc] init];
    mydata=[prefs objectForKey:@"MedicineList"];
    NSError *error;
    if (mydata !=nil) {
        NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
        NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
        for (int count=0; count<[userArray count]; count++) {
            
            NSDictionary *activityData=[userArray objectAtIndex:count];
            DosageVO* dosVO=[[DosageVO alloc]init];
            dosVO.UserID=[[NSString alloc]init];
            dosVO.LoginID=[[NSString alloc]init];
            dosVO.SubscriberCode=[[NSString alloc]init];

            dosVO.dosageID=[[NSString alloc]init];
            dosVO.dosageNmae=[[NSString alloc]init];
            dosVO.nooftablet=[[NSString alloc]init];
            dosVO.timeName=[[NSString alloc]init];
            dosVO.captionName=[[NSString alloc]init];
            
            if ([activityData objectForKey:@"UserID"] != [NSNull null])
                dosVO.UserID=[activityData objectForKey:@"UserID"];
            
            if ([activityData objectForKey:@"LoginID"] != [NSNull null])
                dosVO.LoginID=[activityData objectForKey:@"LoginID"];
            
            if ([activityData objectForKey:@"SubscriberCode"] != [NSNull null])
                dosVO.SubscriberCode=[activityData objectForKey:@"SubscriberCode"];
            
            if ([activityData objectForKey:@"MedicineId"] != [NSNull null])
                dosVO.dosageID=[activityData objectForKey:@"MedicineId"];
            
            if ([activityData objectForKey:@"MedicineName"] != [NSNull null])
                dosVO.dosageNmae=[activityData objectForKey:@"MedicineName"];
            
            if ([activityData objectForKey:@"Quantity"] != [NSNull null])
                dosVO.nooftablet=[activityData objectForKey:@"Quantity"];
            
            if ([activityData objectForKey:@"Form"] != [NSNull null])
                dosVO.timeName=[activityData objectForKey:@"Form"];
            
            if ([activityData objectForKey:@"Frequency"] != [NSNull null])
                dosVO.captionName=[activityData objectForKey:@"Frequency"];
            
            [appDelegate.mainArray addObject:dosVO];
            
        }
        [msgLbl removeFromSuperview];
        [tableViewMain reloadData];

    }else{
        [activityImageView removeFromSuperview];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
                [msgLbl removeFromSuperview];
                msgLbl = [[UILabel alloc] init];
                [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.width*0.90, 35)];
                msgLbl.textAlignment = NSTextAlignmentCenter;
                //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                msgLbl.text=@"No medicine found";
                [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                msgLbl.font=font1s;
                [self.view addSubview:msgLbl];
        
    }
    [activityImageView removeFromSuperview];
}

-(void)getMedicineData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityImageView removeFromSuperview];
        
    }else{
        appDelegate.mainArray=[[NSMutableArray alloc]init];
        NSError *error;
        NSString *mode=[prefs objectForKey:@"mode"];
        NSData *mydata;
//        mydata=[prefs objectForKey:@"MedicineList"];
        NSString *content;
        if (mydata !=nil && [mode isEqualToString:@"offline"]) {
            NSLog(@"Loacl contact data");
        }else{
            NSString *urlString = [[NSString alloc]initWithFormat:@"http://192.168.0.33:9830/api/Medicine/GetAllMedicines?UserID=%@&LoginID=%@&SubscriberCode=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"]];
            mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            NSLog(@" User name : %@",[prefs objectForKey:@"username"]);
            
            content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                          length:[mydata length] encoding: NSUTF8StringEncoding];
            if ([content isEqualToString:@""] || [content isEqualToString:@"[]"]) {
                [activityImageView removeFromSuperview];
                [tableViewMain reloadData];

                        CGRect screenRect = [[UIScreen mainScreen] bounds];
                        [msgLbl removeFromSuperview];
                        msgLbl = [[UILabel alloc] init];
                        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.width*0.90, 35)];
                        msgLbl.textAlignment = NSTextAlignmentCenter;
                        //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                        msgLbl.text=@"No medicine found";
                        [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                        msgLbl.font=font1s;
                        [self.view addSubview:msgLbl];
            }
        }
        if (mydata != nil && ![content isEqualToString:@"[]"]) {
            [msgLbl removeFromSuperview];
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                DosageVO* dosVO=[[DosageVO alloc]init];
                dosVO.dosageID=[[NSString alloc]init];
                dosVO.dosageNmae=[[NSString alloc]init];
                dosVO.nooftablet=[[NSString alloc]init];
                dosVO.timeName=[[NSString alloc]init];
                dosVO.captionName=[[NSString alloc]init];
                dosVO.UserID=[[NSString alloc]init];
                dosVO.LoginID=[[NSString alloc]init];
                dosVO.SubscriberCode=[[NSString alloc]init];

                if ([activityData objectForKey:@"UserID"] != [NSNull null])
                    dosVO.UserID=[activityData objectForKey:@"UserID"];
                
                if ([activityData objectForKey:@"LoginID"] != [NSNull null])
                    dosVO.LoginID=[activityData objectForKey:@"LoginID"];
                
                if ([activityData objectForKey:@"SubscriberCode"] != [NSNull null])
                    dosVO.SubscriberCode=[activityData objectForKey:@"SubscriberCode"];
                
                if ([activityData objectForKey:@"MedicineId"] != [NSNull null])
                    dosVO.dosageID=[activityData objectForKey:@"MedicineId"];
                
                if ([activityData objectForKey:@"MedicineName"] != [NSNull null])
                    dosVO.dosageNmae=[activityData objectForKey:@"MedicineName"];
                
                if ([activityData objectForKey:@"Quantity"] != [NSNull null])
                    dosVO.nooftablet=[activityData objectForKey:@"Quantity"];

                if ([activityData objectForKey:@"Form"] != [NSNull null])
                    dosVO.timeName=[activityData objectForKey:@"Form"];
                
                if ([activityData objectForKey:@"Frequency"] != [NSNull null])
                    dosVO.captionName=[activityData objectForKey:@"Frequency"];
                
                [appDelegate.mainArray addObject:dosVO];
            }
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:mydata forKey:@"MedicineList"];
            [prefsusername synchronize];
            [activityImageView removeFromSuperview];
            [tableViewMain reloadData];
        }
    }
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

#pragma mark - Search Implementation
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    NSLog(@"Cancel clicked");
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [self.searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar {
    NSLog(@"Search Clicked");
    [self.searchBar resignFirstResponder];
    
    if ([searchBar.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please fill data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        DrugsFirstListViewController *search=[[DrugsFirstListViewController alloc] initWithNibName:@"DrugsFirstListViewController" bundle:nil];
        search.searchStr=[[NSString alloc]init];
        search.searchStr=searchBar.text;
        [self.navigationController pushViewController:search animated:YES];
    }
}

-(IBAction)BackAction:(id)sender
{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
    
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
    return [appDelegate.mainArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
        return screenRect.size.height*0.08;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UILabel *DrugNameLbl,*nooftabletNameLbl,*SearchMatchTypeLbl;
    UIView *backgroundView;
  
    DosageVO* dosVO=[appDelegate.mainArray objectAtIndex:indexPath.row];

    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01, 2, screenRect.size.width*0.98, screenRect.size.height*0.095)];
    [backgroundView setBackgroundColor:[UIColor colorWithHexString:@"f7f8f8"]];
    backgroundView.layer.cornerRadius=2.5f;
    backgroundView.layer.borderWidth=1.0f;
    backgroundView.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;
    //[cell.contentView addSubview:backgroundView];
    
    DrugNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,0, screenRect.size.width*0.90, screenRect.size.height*0.035)];
    DrugNameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    DrugNameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    DrugNameLbl.text=[NSString stringWithFormat:@"%@",dosVO.dosageNmae];
    DrugNameLbl.textAlignment = NSTextAlignmentLeft;
    DrugNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    DrugNameLbl.numberOfLines = 0;
    [cell.contentView addSubview:DrugNameLbl];
    
    nooftabletNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.035, screenRect.size.width*0.90, screenRect.size.height*0.035)];
    nooftabletNameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    nooftabletNameLbl.textColor=[UIColor colorWithHexString:@"#ce8b2a"];
    if ([dosVO.captionName isEqualToString:@"As needed"]) {
        nooftabletNameLbl.text=[NSString stringWithFormat:@"%@",dosVO.captionName];
    }else{
        nooftabletNameLbl.text=[NSString stringWithFormat:@"%@ %@ %@",dosVO.nooftablet,dosVO.timeName,dosVO.captionName];
    }
    nooftabletNameLbl.textAlignment = NSTextAlignmentLeft;
    nooftabletNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    nooftabletNameLbl.numberOfLines = 0;
    [cell.contentView addSubview:nooftabletNameLbl];

//    UIImageView *  logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.84,screenRect.size.height*0.02,35,35)];
//    [logoImg setImage:[UIImage imageNamed:@"font-awesome_4-6-3_trash_60_10_03687f_none.png"]];
//    [cell.contentView addSubview:logoImg];
//
//    UIButton *addpharmacycontactbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.85,0,screenRect.size.width*0.15,screenRect.size.height*0.12)];
//    [addpharmacycontactbtn addTarget:self
//                              action:@selector(DeleteDosageContact:)
//                    forControlEvents:UIControlEventTouchUpInside];
//    [addpharmacycontactbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    addpharmacycontactbtn.tag=indexPath.row;
//    //    [addpharmacycontactbtn setBackgroundImage:[UIImage imageNamed:@"user_plus.png"]forState:UIControlStateNormal];
//    [cell.contentView addSubview:addpharmacycontactbtn];

    UILabel * lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.075, screenRect.size.width*0.90,1)];
    [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
    [cell.contentView addSubview:lineLbl];

    tableView.backgroundColor=[UIColor clearColor];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}
-(void)DeleteDosageContact:(UIButton *)Btn{
    appDelegate.drugArrayindex=Btn.tag;
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Are you sure you want to delete?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil];
    [alert show];
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine deleted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [appDelegate.mainArray removeObjectAtIndex:appDelegate.drugArrayindex];
        [tableViewMain reloadData];
    }    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *mode=[prefs objectForKey:@"modes"];
    if (![mode isEqualToString:@"offline"]) {
        MyRxSearchViewController  *updatedosage=[[MyRxSearchViewController alloc] initWithNibName:@"MyRxSearchViewController" bundle:nil];
        DosageVO* pharVO=[appDelegate.mainArray objectAtIndex:indexPath.row];
        updatedosage.dosageVO=[[DosageVO alloc]init];
        updatedosage.dosageVO=pharVO;
        appDelegate.drugArrayindex=indexPath.row;
        [self.navigationController pushViewController:updatedosage animated:YES];
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
