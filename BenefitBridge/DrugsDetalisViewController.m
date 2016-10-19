//
//  DrugsDetalisViewController.m
//  BenefitBridge
//
//  Created by Infinitum on 22/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import "DrugsDetalisViewController.h"
#import "Reachability.h"
#import "UIColor+Expanded.h"
#import "DrugDetalisVO.h"
#import "DosageVO.h"
#import "MyRxViewController.h"
#define MAX_LENGTH 2

@interface DrugsDetalisViewController ()

@end

@implementation DrugsDetalisViewController
@synthesize drugIDStr,appDelegate,tokenStr,msgLbl,activityImageView,DrugsDetailsArray,tableViewMain,pharVO,dosageBtn,dosageBtn1,dosageBtn2,dosageBtn3,dosageBtn4,nooftabletTxt,tabletnameLbl,parweekBtn,parmonthBtn,asneededBtn,numberToolbar,height,perdayLbl,perweekLbl,permonthLbl,asneededLbl,tabletNameStr,submitBtn,captionnameStr,lableNameStr,dosageBtn5,scrollView,dosageIDStr,dosageBtn6,dosageBtn7,dosageBtn8,dosageBtn9,dosageBtn10,dosageBtn11,dosageBtn12,dosageBtn13,dosageBtn14,dosageBtn15,dosageBtn16,dosageBtn17,dosageBtn18,dosageBtn19,dosageBtn20,pardayBtnOne,pardayBtntwo,pardayBtnthree,pardayBtnfour,perdaytwoLbl,perdaythreeLbl,perdayfourLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Select a Dosage and Quantity";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    
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
    
    if (appDelegate.drugAdd==YES) {
        UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    UIButton *rightBtnDelete = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtnDelete setFrame:CGRectMake(30, 0,30,30)];
    //[rightBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [rightBtnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtnDelete setBackgroundImage:[UIImage imageNamed:@"font-awesome_4-6-3_trash_60_10_851c2b_none.png"] forState:UIControlStateNormal];
        rightBtnDelete.tag=appDelegate.drugArrayindex;
    UIBarButtonItem *btnsdel = [[UIBarButtonItem alloc]initWithCustomView:rightBtnDelete];
    rightBtnDelete.titleLabel.font = fontss;
    
    [rightBtnDelete setTintColor:[self colorFromHexString:@"#03687f"]];
    [self.navigationItem setRightBarButtonItems:@[btnsdel] animated:NO];
    }
    DrugsDetailsArray=[[NSMutableArray alloc]init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    tableViewMain=[[UITableView alloc]init];
//    tableViewMain.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height);
//    tableViewMain.dataSource = self;
//    tableViewMain.delegate = self;
//    [tableViewMain setBackgroundColor:[UIColor clearColor]];
//    self.tableViewMain.separatorColor = [UIColor clearColor];
//    tableViewMain.separatorInset = UIEdgeInsetsZero;
//    tableViewMain.layoutMargins = UIEdgeInsetsZero;
//    [self.view addSubview:tableViewMain];
//
    
   UILabel * DrugNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.12, screenRect.size.width*0.90, screenRect.size.height*0.05)];
    DrugNameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    DrugNameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    DrugNameLbl.text=[NSString stringWithFormat:@"%@",pharVO.DrugName];
    DrugNameLbl.textAlignment = NSTextAlignmentLeft;
    DrugNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    DrugNameLbl.numberOfLines = 0;
    //[self.view addSubview:DrugNameLbl];

    tabletNameStr=[[NSString alloc]init];
    captionnameStr=[[NSString alloc]init];
    lableNameStr=[[NSString alloc]init];
    dosageIDStr=[[NSString alloc]init];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, screenRect.size.width, screenRect.size.height)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    scrollView.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height);

    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    [self performSelector:@selector(SearchData) withObject:nil afterDelay:1.0 ];
    
}
-(IBAction)deleteAction:(UIButton *)sender{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Are you sure you want to delete?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil];
    [alert show];

}
-(IBAction)CancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine deleted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [appDelegate.mainArray removeObjectAtIndex:appDelegate.drugArrayindex];

    }
    if([title isEqualToString:@"OK"]){
//        [self.navigationController popViewControllerAnimated:YES];
//        appDelegate.backBool=YES;
        MyRxViewController  *myRXview=[[MyRxViewController alloc] initWithNibName:@"MyRxViewController" bundle:nil];
        [self.navigationController pushViewController:myRXview animated:YES];
    }
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
-(void)SearchData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        NSString *title = @"BenefitBridge";
        NSString *message = @"No internet connection available";
        NSString *buttonTitle = @"OK";
        if (NSClassFromString(@"UIAlertController") != Nil) // Yes, Nil
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        [self dismissViewControllerAnimated:YES completion:nil];
                                                    }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:title
                                        message:message
                                       delegate:self
                              cancelButtonTitle:buttonTitle
                              otherButtonTitles:nil] show];
        }
        [activityImageView removeFromSuperview];
    }else{
        
        NSString *object=@"grant_type=client_credentials";
        NSData *postData = [object dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSError *error;
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //[request setURL:[NSURL URLWithString:@"http://192.168.0.192:9810/api/IdCard/UpdateImages"]];
        [request setURL:[NSURL URLWithString:@"https://auth.drxwebservices.com/v1/auth/token?format=json"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"Basic UFIxcUxCYnlFZWFBMndBazZGcEtmUTprL3ZFZ0ZaNFRzLzdreUhtbzlFYWdjZWxNTmVVZEF5WkN6MzBQamxNSW1n" forHTTPHeaderField:@"Authorization"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"UTF-8" forHTTPHeaderField:@"Accept-Charset"];
        [request setHTTPBody:postData];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                NSLog(@"Failed to submit request");
                [activityImageView removeFromSuperview];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            else
            {
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                
                NSLog(@"rerturn response %@",content);
                if (![content isEqualToString:@""]) {
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    tokenStr = [[NSString alloc]init];
                    tokenStr = [userDict objectForKey:@"access_token"];
                    [self getAllData];
                }else{
                    if (NSClassFromString(@"UIAlertController") != Nil) // Yes, Nil
                    {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"BenefitBridge" message:@"Internet error" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
                                                                    [self dismissViewControllerAnimated:YES completion:nil];
                                                                }]];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    else
                    {
                        
                        
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [alert show];
                    }
                    
                }
            }
        }];
    }
}
-(void)getAllData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityImageView removeFromSuperview];
        
    }else{
        DrugsDetailsArray=[[NSMutableArray alloc]init];
        
        NSString *token=[NSString stringWithFormat:@"Bearer %@",tokenStr];
        NSError *error;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //[request setURL:[NSURL URLWithString:@"http://192.168.0.192:9810/api/IdCard/UpdateImages"]];
        
        NSString *url=[NSString stringWithFormat:@"https://www.drxwebservices.com/APITools/v1/Drugs/%@",drugIDStr];
        [request setURL:[NSURL URLWithString:url]];
        
        [request setHTTPMethod:@"GET"];
        [request setValue:token forHTTPHeaderField:@"Authorization"];
        [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                NSLog(@"Failed to submit request");
                [activityImageView removeFromSuperview];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            else
            {
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                if (![content isEqualToString:@""]) {
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSArray *activityArray=[userDict objectForKey:@"Dosages"];
                    for (int count=0; count<[activityArray count]; count++) {
                        NSDictionary *activityData=[activityArray objectAtIndex:count];
                        DrugDetalisVO *Pvo=[[DrugDetalisVO alloc] init];
                        Pvo.DosageID=[[NSString alloc] init];
                        Pvo.ReferenceNDC=[[NSString alloc] init];
                        Pvo.LabelName=[[NSString alloc] init];
                        Pvo.CommonUserQuantity=[[NSString alloc] init];
                        Pvo.CommonMetricQuantity=[[NSString alloc] init];
                        Pvo.CommonDaysOfSupply=[[NSString alloc] init];
                        Pvo.IsCommonDosage=[[NSString alloc] init];
                        Pvo.GenericDosageID=[[NSString alloc] init];

                        if ([activityData objectForKey:@"DosageID"] != [NSNull null])
                            Pvo.DosageID=[activityData objectForKey:@"DosageID"];
                        
                        if ([activityData objectForKey:@"ReferenceNDC"] != [NSNull null])
                            Pvo.ReferenceNDC=[activityData objectForKey:@"ReferenceNDC"];
                        
                        if ([activityData objectForKey:@"LabelName"] != [NSNull null])
                            Pvo.LabelName=[activityData objectForKey:@"LabelName"];
                        
                        if ([activityData objectForKey:@"CommonUserQuantity"] != [NSNull null])
                            Pvo.CommonUserQuantity=[activityData objectForKey:@"CommonUserQuantity"];
                        
                        if ([activityData objectForKey:@"CommonMetricQuantity"] != [NSNull null])
                            Pvo.CommonMetricQuantity=[activityData objectForKey:@"CommonMetricQuantity"];
                        
                        if ([activityData objectForKey:@"CommonDaysOfSupply"] != [NSNull null])
                            Pvo.CommonDaysOfSupply=[activityData objectForKey:@"CommonDaysOfSupply"];
                        
                        if ([activityData objectForKey:@"IsCommonDosage"] != [NSNull null])
                            Pvo.IsCommonDosage=[activityData objectForKey:@"IsCommonDosage"];
                        
                        if ([activityData objectForKey:@"GenericDosageID"] != [NSNull null])
                            Pvo.GenericDosageID=[activityData objectForKey:@"GenericDosageID"];

                        NSArray *activityArraypack=[activityData objectForKey:@"Packages"];
                        for (int count=0; count<[activityArraypack count]; count++) {
                            NSDictionary *activityDatap=[activityArraypack objectAtIndex:count];
                            Pvo.PackageDescription=[[NSString alloc] init];
                            Pvo.PackageSize=[[NSString alloc] init];
                            Pvo.PackageSizeUnitOfMeasure=[[NSString alloc] init];
                            Pvo.PackageQuantity=[[NSString alloc] init];
                            Pvo.TotalPackageQuantity=[[NSString alloc] init];

                            if ([activityDatap objectForKey:@"PackageDescription"] != [NSNull null])
                                Pvo.PackageDescription=[activityDatap objectForKey:@"PackageDescription"];
                            
                            if ([activityDatap objectForKey:@"PackageSize"] != [NSNull null])
                                Pvo.PackageSize=[activityDatap objectForKey:@"PackageSize"];
                            
                            if ([activityDatap objectForKey:@"PackageSizeUnitOfMeasure"] != [NSNull null])
                                Pvo.PackageSizeUnitOfMeasure=[activityDatap objectForKey:@"PackageSizeUnitOfMeasure"];
                            
                            if ([activityDatap objectForKey:@"PackageQuantity"] != [NSNull null])
                                Pvo.PackageQuantity=[activityDatap objectForKey:@"PackageQuantity"];
                            
                            if ([activityDatap objectForKey:@"TotalPackageQuantity"] != [NSNull null])
                                Pvo.TotalPackageQuantity=[activityDatap objectForKey:@"TotalPackageQuantity"];
                        }
                        
                        [DrugsDetailsArray addObject:Pvo];
                    }
                }
                CGRect screenRect = [[UIScreen mainScreen] bounds];
                if ([DrugsDetailsArray count]>0) {
                    [msgLbl removeFromSuperview];
                    if ([DrugsDetailsArray count]<5 ) {
                        scrollView.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height);
                    }else if ([DrugsDetailsArray count]>5 && [DrugsDetailsArray count]<10) {
                        scrollView.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height*1.3);
                    }else if([DrugsDetailsArray count]<15){
                        scrollView.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height*1.5);
                    }else if([DrugsDetailsArray count]>15){
                        scrollView.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height*1.9);
                    }
                    [self DispayView];
                }else{
                    [msgLbl removeFromSuperview];
                    msgLbl = [[UILabel alloc] init];
                    [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.width*0.90, 35)];
                    msgLbl.textAlignment = NSTextAlignmentCenter;
                    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                    msgLbl.text=@"No medicine detalis found";
                    [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                    msgLbl.font=font1s;
                    [self.view addSubview:msgLbl];
                }
                [activityImageView removeFromSuperview];
                //[tableViewMain reloadData];
            }
        }];
    }
}

-(void)DispayView{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    height=screenRect.size.height*0.01;
    for (int co=0; co<[DrugsDetailsArray count]; co++) {
        DrugDetalisVO *pVOS=[DrugsDetailsArray objectAtIndex:co];
        if (co==0) {
            dosageBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn.layer.cornerRadius = 6.0f;
            [dosageBtn setTag:co];
            [dosageBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn];
            dosageBtn.selected=YES;
            lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            dosageIDStr=pVOS.DosageID;
        }else if (co==1){
            dosageBtn1=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn1 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn1 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn1.layer.cornerRadius = 6.0f;
            [dosageBtn1 setTag:co];
            [dosageBtn1 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn1];
        }else if (co==2){
            dosageBtn2=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn2 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn2 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn2.layer.cornerRadius = 6.0f;
            [dosageBtn2 setTag:co];
            [dosageBtn2 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn2];
        }else if (co==3){
            dosageBtn3=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn3 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn3 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn3.layer.cornerRadius = 6.0f;
            [dosageBtn3 setTag:co];
            [dosageBtn3 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn3];
        }else if (co==4){
            dosageBtn4=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn4 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn4 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn4.layer.cornerRadius = 6.0f;
            [dosageBtn4 setTag:co];
            [dosageBtn4 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn4];
        }else if (co==5){
            dosageBtn5=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn5 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn5 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn5.layer.cornerRadius = 6.0f;
            [dosageBtn5 setTag:co];
            [dosageBtn5 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn5];
        }else if (co==6){
            dosageBtn6=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn6 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn6 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn6.layer.cornerRadius = 6.0f;
            [dosageBtn6 setTag:co];
            [dosageBtn6 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn6];
        }else if (co==7){
            dosageBtn7=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn7 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn7 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn7.layer.cornerRadius = 6.0f;
            [dosageBtn7 setTag:co];
            [dosageBtn7 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn7];
        }else if (co==8){
            dosageBtn8=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn8 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn8 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn8.layer.cornerRadius = 6.0f;
            [dosageBtn8 setTag:co];
            [dosageBtn8 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn8];
        }else if (co==9){
            dosageBtn9=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn9 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn9 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn9.layer.cornerRadius = 6.0f;
            [dosageBtn9 setTag:co];
            [dosageBtn9 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn9];
        }else if (co==10){
            dosageBtn10=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn10 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn10 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn10.layer.cornerRadius = 6.0f;
            [dosageBtn10 setTag:co];
            [dosageBtn10 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn10];
        }else if (co==11){
            dosageBtn11=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn11 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn11 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn11.layer.cornerRadius = 6.0f;
            [dosageBtn11 setTag:co];
            [dosageBtn11 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn11];
        }else if (co==12){
            dosageBtn12=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn12 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn12 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn12.layer.cornerRadius = 6.0f;
            [dosageBtn12 setTag:co];
            [dosageBtn12 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn12];
        }else if (co==13){
            dosageBtn13=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn13 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn13 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn13.layer.cornerRadius = 6.0f;
            [dosageBtn13 setTag:co];
            [dosageBtn13 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn13];
        }else if (co==14){
            dosageBtn14=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn14 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn14 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn14.layer.cornerRadius = 6.0f;
            [dosageBtn14 setTag:co];
            [dosageBtn14 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn14];
        }else if (co==15){
            dosageBtn15=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn15.layer.cornerRadius = 6.0f;
            [dosageBtn15 setTag:co];
            [dosageBtn15 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn15];
        }else if (co==16){
            dosageBtn15=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn15.layer.cornerRadius = 6.0f;
            [dosageBtn15 setTag:co];
            [dosageBtn15 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn15];
        }else if (co==17){
            dosageBtn15=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn15.layer.cornerRadius = 6.0f;
            [dosageBtn15 setTag:co];
            [dosageBtn15 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn15];
        }else if (co==18){
            dosageBtn15=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn15.layer.cornerRadius = 6.0f;
            [dosageBtn15 setTag:co];
            [dosageBtn15 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn15];
        }else if (co==19){
            dosageBtn15=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn15.layer.cornerRadius = 6.0f;
            [dosageBtn15 setTag:co];
            [dosageBtn15 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn15];
        }else if (co==20){
            dosageBtn15=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,height,30,30)];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
            [dosageBtn15 setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
            dosageBtn15.layer.cornerRadius = 6.0f;
            [dosageBtn15 setTag:co];
            [dosageBtn15 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:dosageBtn15];
        }
    
        if ([DrugsDetailsArray count]<=20) {
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    UILabel *firstnameLbl1= [[UILabel alloc] init];
    [firstnameLbl1 setFrame:CGRectMake(screenRect.size.width*0.15, height, screenRect.size.width*0.83, screenRect.size.height*0.04)];
    firstnameLbl1.textAlignment = NSTextAlignmentLeft;
    firstnameLbl1.text=[NSString stringWithFormat:@"%@",pVOS.LabelName];
    firstnameLbl1.font=fonts;
    firstnameLbl1.lineBreakMode = NSLineBreakByWordWrapping;
    firstnameLbl1.numberOfLines = 0;
    [scrollView addSubview:firstnameLbl1];
            
    height=height+screenRect.size.height*0.07;

        }
    }
    height=height+screenRect.size.height*0.02;

    DrugDetalisVO *pVOS=[DrugsDetailsArray objectAtIndex:0];
    if ([pVOS.LabelName rangeOfString:@"SOL"].location != NSNotFound) {
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Drops"];
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"SYP"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Ml"];
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"TAB"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Tablets"];
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"CAP"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Capsules"];
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"INJ"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Injections"];
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"CON"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Ml"];
        [self displayFirstview:height];
    }else
//        if ([pVOS.LabelName rangeOfString:@"CRE"].location != NSNotFound || [pVOS.LabelName rangeOfString:@"GEL"].location != NSNotFound || [pVOS.LabelName rangeOfString:@"LOT"].location != NSNotFound || [pVOS.LabelName rangeOfString:@"OIN"].location != NSNotFound || [pVOS.LabelName rangeOfString:@"NEB"].location != NSNotFound)
        {
        [self displaysecondview:height];
    }
}
-(void)displayFirstview:(int)heights{
    [submitBtn removeFromSuperview];
    [pardayBtnOne removeFromSuperview];
    [pardayBtntwo removeFromSuperview];
    [pardayBtnthree removeFromSuperview];
    [pardayBtnfour removeFromSuperview];
    [parweekBtn removeFromSuperview];
    [parmonthBtn removeFromSuperview];
    [asneededBtn removeFromSuperview];
    [perdayLbl removeFromSuperview];
    [perweekLbl removeFromSuperview];
    [permonthLbl removeFromSuperview];
    [asneededLbl removeFromSuperview];
    [nooftabletTxt removeFromSuperview];
    [tabletnameLbl removeFromSuperview];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];

    nooftabletTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heights,screenRect.size.width*0.30,screenRect.size.height*0.05)];
    nooftabletTxt.font=font1;
    nooftabletTxt.textAlignment=NSTextAlignmentLeft;
    nooftabletTxt.delegate = self;
    nooftabletTxt.textColor=[UIColor colorWithHexString:@"434444"];
    nooftabletTxt.textColor=[UIColor colorWithHexString:@"#32333"];
    nooftabletTxt.layer.borderWidth=1.0;
    nooftabletTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
    nooftabletTxt.tag=6;
    UIView *paddingViewsb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    nooftabletTxt.leftView = paddingViewsb;
    [nooftabletTxt setTintColor:[UIColor lightGrayColor]];
    nooftabletTxt.leftViewMode = UITextFieldViewModeAlways;
    [nooftabletTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackOpaque;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    numberToolbar.tintColor=[UIColor whiteColor];
    nooftabletTxt.inputAccessoryView = numberToolbar;
    nooftabletTxt.returnKeyType=UIReturnKeyNext;
    [scrollView addSubview:nooftabletTxt];
    nooftabletTxt.text=@"1";
    
    tabletnameLbl= [[UILabel alloc] init];
    [tabletnameLbl setFrame:CGRectMake(screenRect.size.width*0.50, heights, screenRect.size.width*0.50, screenRect.size.height*0.04)];
    tabletnameLbl.textAlignment = NSTextAlignmentLeft;
    tabletnameLbl.font=font1;
    tabletnameLbl.text=tabletNameStr;
    [scrollView addSubview:tabletnameLbl];
    
    heights=heights+screenRect.size.height*0.07;
    
    pardayBtnOne=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [pardayBtnOne setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [pardayBtnOne setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    pardayBtnOne.layer.cornerRadius = 6.0f;
    [pardayBtnOne setTag:1];
    [pardayBtnOne addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:pardayBtnOne];
    pardayBtnOne.selected=YES;
    captionnameStr=@"Per day once";
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    perdayLbl= [[UILabel alloc] init];
    [perdayLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    perdayLbl.textAlignment = NSTextAlignmentLeft;
    perdayLbl.text=[NSString stringWithFormat:@"Per day once"];
    perdayLbl.font=fonts;
    [scrollView addSubview:perdayLbl];
    
    heights=heights+screenRect.size.height*0.07;
    
    pardayBtntwo=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [pardayBtntwo setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [pardayBtntwo setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    pardayBtntwo.layer.cornerRadius = 6.0f;
    [pardayBtntwo setTag:2];
    [pardayBtntwo addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:pardayBtntwo];
    perdaytwoLbl= [[UILabel alloc] init];
    [perdaytwoLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    perdaytwoLbl.textAlignment = NSTextAlignmentLeft;
    perdaytwoLbl.text=[NSString stringWithFormat:@"Per day twice"];
    perdaytwoLbl.font=fonts;
    [scrollView addSubview:perdaytwoLbl];
    
    heights=heights+screenRect.size.height*0.07;
    
    pardayBtnthree=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [pardayBtnthree setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [pardayBtnthree setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    pardayBtnthree.layer.cornerRadius = 6.0f;
    [pardayBtnthree setTag:3];
    [pardayBtnthree addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:pardayBtnthree];
    perdaythreeLbl= [[UILabel alloc] init];
    [perdaythreeLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    perdaythreeLbl.textAlignment = NSTextAlignmentLeft;
    perdaythreeLbl.text=[NSString stringWithFormat:@"Per day thrice"];
    perdaythreeLbl.font=fonts;
    [scrollView addSubview:perdaythreeLbl];
    
    heights=heights+screenRect.size.height*0.07;

    pardayBtnfour=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [pardayBtnfour setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [pardayBtnfour setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    pardayBtnfour.layer.cornerRadius = 6.0f;
    [pardayBtnfour setTag:4];
    [pardayBtnfour addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:pardayBtnfour];
    perdayfourLbl= [[UILabel alloc] init];
    [perdayfourLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    perdayfourLbl.textAlignment = NSTextAlignmentLeft;
    perdayfourLbl.text=[NSString stringWithFormat:@"Per day four times"];
    perdayfourLbl.font=fonts;
    [scrollView addSubview:perdayfourLbl];
    
    heights=heights+screenRect.size.height*0.07;

    parweekBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [parweekBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [parweekBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    parweekBtn.layer.cornerRadius = 6.0f;
    [parweekBtn setTag:5];
    [parweekBtn addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:parweekBtn];
    
    perweekLbl= [[UILabel alloc] init];
    [perweekLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    perweekLbl.textAlignment = NSTextAlignmentLeft;
    perweekLbl.text=[NSString stringWithFormat:@"Per week"];
    perweekLbl.font=fonts;
    [scrollView addSubview:perweekLbl];
    
    heights=heights+screenRect.size.height*0.07;
    
    parmonthBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [parmonthBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [parmonthBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    parmonthBtn.layer.cornerRadius = 6.0f;
    [parmonthBtn setTag:6];
    [parmonthBtn addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:parmonthBtn];
    
    permonthLbl= [[UILabel alloc] init];
    [permonthLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    permonthLbl.textAlignment = NSTextAlignmentLeft;
    permonthLbl.text=[NSString stringWithFormat:@"Per month"];
    permonthLbl.font=fonts;
    [scrollView addSubview:permonthLbl];
    
    heights=heights+screenRect.size.height*0.07;
    
    asneededBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [asneededBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [asneededBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    asneededBtn.layer.cornerRadius = 6.0f;
    [asneededBtn setTag:7];
    [asneededBtn addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:asneededBtn];
    
    asneededLbl= [[UILabel alloc] init];
    [asneededLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    asneededLbl.textAlignment = NSTextAlignmentLeft;
    asneededLbl.text=[NSString stringWithFormat:@"As needed"];
    asneededLbl.font=fonts;
    [scrollView addSubview:asneededLbl];

    heights=heights+screenRect.size.height*0.07;

    submitBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30, heights, screenRect.size.width*0.40, screenRect.size.height*0.05)];
    [submitBtn setBackgroundColor:[UIColor clearColor]];
    submitBtn.layer.cornerRadius = 6.0f;
    [submitBtn addTarget:self action:@selector(submitDosageContact:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [scrollView addSubview:submitBtn];
}
-(void)displaysecondview:(int)heights{
    [submitBtn removeFromSuperview];
    [pardayBtnOne removeFromSuperview];
    [pardayBtntwo removeFromSuperview];
    [pardayBtnthree removeFromSuperview];
    [pardayBtnfour removeFromSuperview];

    [parweekBtn removeFromSuperview];
    [parmonthBtn removeFromSuperview];
    [asneededBtn removeFromSuperview];
    [perdayLbl removeFromSuperview];
    [perweekLbl removeFromSuperview];
    [permonthLbl removeFromSuperview];
    [asneededLbl removeFromSuperview];
    [nooftabletTxt removeFromSuperview];
    [tabletnameLbl removeFromSuperview];
    nooftabletTxt=nil;
    tabletnameLbl=nil;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];

    asneededBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [asneededBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [asneededBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    asneededBtn.layer.cornerRadius = 6.0f;
    [asneededBtn setTag:4];
    [asneededBtn addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:asneededBtn];
    asneededBtn.selected=YES;
    captionnameStr=@"As needed";

    asneededLbl= [[UILabel alloc] init];
    [asneededLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    asneededLbl.textAlignment = NSTextAlignmentLeft;
    asneededLbl.text=[NSString stringWithFormat:@"As needed"];
    asneededLbl.font=fonts;
    [scrollView addSubview:asneededLbl];

    heights=heights+screenRect.size.height*0.07;

    submitBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30, heights, screenRect.size.width*0.40, screenRect.size.height*0.05)];
    [submitBtn setBackgroundColor:[UIColor clearColor]];
    submitBtn.layer.cornerRadius = 6.0f;
    [submitBtn addTarget:self action:@selector(submitDosageContact:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [scrollView addSubview:submitBtn];
}
-(void)submitDosageContact:(UIButton *)Btn{
        if (appDelegate.mainArray==nil) {
            appDelegate.mainArray=[[NSMutableArray alloc]init];
        }
    if ([appDelegate.mainArray count]<=0) {
        if ([captionnameStr isEqualToString:@"As needed"]) {
            nooftabletTxt=[[UITextField alloc]init];
            tabletnameLbl=[[UILabel alloc]init];

            nooftabletTxt.text=@"1";
            tabletnameLbl.text=@"";
//            DosageVO* dosVO=[[DosageVO alloc]init];
//            dosVO.dosageNmae=[[NSString alloc]init];
//            dosVO.nooftablet=[[NSString alloc]init];
//            dosVO.timeName=[[NSString alloc]init];
//            dosVO.captionName=[[NSString alloc]init];
//            dosVO.dosageNmae=lableNameStr;
//            dosVO.nooftablet=nooftabletTxt.text;
//            dosVO.timeName=tabletnameLbl.text;
//            dosVO.captionName=captionnameStr;
//            dosVO.dosageID=dosageIDStr;
//            
//            [appDelegate.mainArray addObject:dosVO];

            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            [self performSelector:@selector(submit) withObject:nil afterDelay:1.0 ];
            
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine added successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
        }else{
            int nooftab=[nooftabletTxt.text intValue];

            if ([nooftabletTxt.text isEqualToString:@""]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please enter a number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [nooftabletTxt becomeFirstResponder];

            }
            else if (nooftab<=0){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [nooftabletTxt becomeFirstResponder];

            }
            else
            {
//                DosageVO* dosVO=[[DosageVO alloc]init];
//                dosVO.dosageNmae=[[NSString alloc]init];
//                dosVO.nooftablet=[[NSString alloc]init];
//                dosVO.timeName=[[NSString alloc]init];
//                dosVO.captionName=[[NSString alloc]init];
//                dosVO.dosageNmae=lableNameStr;
//                dosVO.nooftablet=nooftabletTxt.text;
//                dosVO.timeName=tabletnameLbl.text;
//                dosVO.captionName=captionnameStr;
//                dosVO.dosageID=dosageIDStr;
//                [appDelegate.mainArray addObject:dosVO];

                    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                    [self performSelector:@selector(submit) withObject:nil afterDelay:1.0 ];

//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine added successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
            }
        }
    }else{
        bool alrd=NO;

    for (int co=0; co<[appDelegate.mainArray count]; co++) {
        DosageVO *dosVOS=[appDelegate.mainArray objectAtIndex:co];
        if ([dosVOS.dosageID isEqualToString:dosageIDStr]) {
            alrd=YES;
            break;
        }else{
            alrd=NO;
        }
    }
        if (alrd==NO) {
            if ([captionnameStr isEqualToString:@"As needed"]) {
                nooftabletTxt=[[UITextField alloc]init];
                tabletnameLbl=[[UILabel alloc]init];

                nooftabletTxt.text=@"1";
                tabletnameLbl.text=@"";
//                DosageVO* dosVO=[[DosageVO alloc]init];
//                dosVO.dosageNmae=[[NSString alloc]init];
//                dosVO.nooftablet=[[NSString alloc]init];
//                dosVO.timeName=[[NSString alloc]init];
//                dosVO.captionName=[[NSString alloc]init];
//                dosVO.dosageNmae=lableNameStr;
//                dosVO.nooftablet=nooftabletTxt.text;
//                dosVO.timeName=tabletnameLbl.text;
//                dosVO.captionName=captionnameStr;
//                dosVO.dosageID=dosageIDStr;
//                
//                [appDelegate.mainArray addObject:dosVO];

                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                [self performSelector:@selector(submit) withObject:nil afterDelay:1.0 ];

//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine added successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
                
            }else{
                int nooftab=[nooftabletTxt.text intValue];
                if ([nooftabletTxt.text isEqualToString:@""]) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please enter a number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [nooftabletTxt becomeFirstResponder];

                }
                else if (nooftab<=0){
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [nooftabletTxt becomeFirstResponder];

                }
                else{
//                    DosageVO* dosVO=[[DosageVO alloc]init];
//                    dosVO.dosageNmae=[[NSString alloc]init];
//                    dosVO.nooftablet=[[NSString alloc]init];
//                    dosVO.timeName=[[NSString alloc]init];
//                    dosVO.captionName=[[NSString alloc]init];
//                    dosVO.dosageNmae=lableNameStr;
//                    dosVO.nooftablet=nooftabletTxt.text;
//                    dosVO.timeName=tabletnameLbl.text;
//                    dosVO.captionName=captionnameStr;
//                    dosVO.dosageID=dosageIDStr;
//                    [appDelegate.mainArray addObject:dosVO];
                    
                    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                    [self performSelector:@selector(submit) withObject:nil afterDelay:1.0 ];

//                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine added successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
                }
            }
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine already exits" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

-(void)submit{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://192.168.0.33:9830/api/Medicine/InsertMedicines?UserID=%@&LoginID=%@&SubscriberCode=%@&MedicineId=%@&MedicineName=%@&Quantity=%@&Form=%@&Frequency=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"],dosageIDStr, lableNameStr,nooftabletTxt.text,tabletnameLbl.text,captionnameStr];
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    if ([content isEqualToString:@"true"]) {
//        [activityImageView removeFromSuperview];
//        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine added successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
        //appDelegate.contactsubmitdeleteupdate=true;
        [self getMedicineData];
    }else{
        [activityImageView removeFromSuperview];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
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
        NSError *error;
        NSString *mode=[prefs objectForKey:@"mode"];
        NSData *mydata = [[NSData alloc] init];
        mydata=[prefs objectForKey:@"MedicineList"];
        
        if (mydata !=nil && [mode isEqualToString:@"offline"]) {
            NSLog(@"Loacl contact data");
        }else{
            NSString *urlString = [[NSString alloc]initWithFormat:@"http://192.168.0.33:9830/api/Medicine/GetAllMedicines?UserID=%@&LoginID=%@&SubscriberCode=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"]];
            mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            NSLog(@" User name : %@",[prefs objectForKey:@"username"]);
            
            NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                          length:[mydata length] encoding: NSUTF8StringEncoding];
            if ([content isEqualToString:@""]) {
                [activityImageView removeFromSuperview];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

            }
        }
        if (mydata != nil) {
            appDelegate.mainArray=[[NSMutableArray alloc]init];
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
            [tableViewMain reloadData];
            
                    [activityImageView removeFromSuperview];
            
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine added successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
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
    activityImageView.frame = CGRectMake(
                                         self.view.frame.size.width/2
                                         -35,
                                         self.view.frame.size.height/2
                                         -35,70,
                                         70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
    
}

-(void)doneWithNumberPad{
    [nooftabletTxt resignFirstResponder];
    //[self animateTextField:nooftabletTxt up:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==nooftabletTxt){

    //[self animateTextField:textField up:NO];
}
    return YES;
}
-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    int movementDistance=0;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if (height<screenRect.size.height*0.40) {
        movementDistance = -130; // tweak as needed
    }else if (height<screenRect.size.height*0.50){
    movementDistance = -230;
    }else if (height<screenRect.size.height*0.60){
        movementDistance = -270;
    }else if (height>screenRect.size.height*0.70){
        movementDistance = -330;
    }
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==nooftabletTxt){
        
        if (nooftabletTxt.text.length >= MAX_LENGTH && range.length == 0)
        {
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==nooftabletTxt)
    {
    //[self animateTextField:textField up:YES];
    }
        return YES;
}

-(IBAction)redioBtnAction:(UIButton *)sender{
    NSLog(@"Button tag %ld",(long)sender.tag);
    DrugDetalisVO *pVOS=[DrugsDetailsArray objectAtIndex:sender.tag];
    if ([pVOS.LabelName rangeOfString:@"SOL"].location != NSNotFound) {
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Drops"];
    }else if ([pVOS.LabelName rangeOfString:@"SYP"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Ml"];
    }else if ([pVOS.LabelName rangeOfString:@"TAB"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Tablets"];
    }else if ([pVOS.LabelName rangeOfString:@"CAP"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Capsules"];
    }else if ([pVOS.LabelName rangeOfString:@"INJ"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Injections"];
    }else if ([pVOS.LabelName rangeOfString:@"CON"].location != NSNotFound){
        tabletNameStr=[NSString stringWithFormat:@"%@",@"Ml"];
    }
    dosageIDStr=pVOS.DosageID;

    switch ([sender tag]) {
        case 0:
            if([dosageBtn isSelected]==YES)
            {
            }
            else{
                [dosageBtn setSelected:YES];
                [dosageBtn1 setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 1:
            if([dosageBtn1 isSelected]==YES)
            {
            }
            else{
                [dosageBtn1 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 2:
            if([dosageBtn2 isSelected]==YES)
            {
            }
            else{
                [dosageBtn2 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 3:
            if([dosageBtn3 isSelected]==YES)
            {
            }
            else{
                [dosageBtn3 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 4:
            if([dosageBtn4 isSelected]==YES)
            {
            }
            else{
                [dosageBtn4 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 5:
            if([dosageBtn5 isSelected]==YES)
            {
            }
            else{
                [dosageBtn5 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 6:
            if([dosageBtn6 isSelected]==YES)
            {
            }
            else{
                [dosageBtn6 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 7:
            if([dosageBtn7 isSelected]==YES)
            {
            }
            else{
                [dosageBtn7 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 8:
            if([dosageBtn8 isSelected]==YES)
            {
            }
            else{
                [dosageBtn8 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 9:
            if([dosageBtn9 isSelected]==YES)
            {
            }
            else{
                [dosageBtn9 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 10:
            if([dosageBtn10 isSelected]==YES)
            {
            }
            else{
                [dosageBtn10 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 11:
            if([dosageBtn11 isSelected]==YES)
            {
            }
            else{
                [dosageBtn11 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 12:
            if([dosageBtn12 isSelected]==YES)
            {
            }
            else{
                [dosageBtn12 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 13:
            if([dosageBtn13 isSelected]==YES)
            {
            }
            else{
                [dosageBtn13 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 14:
            if([dosageBtn14 isSelected]==YES)
            {
            }
            else{
                [dosageBtn14 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn15 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 15:
            if([dosageBtn15 isSelected]==YES)
            {
            }
            else{
                [dosageBtn15 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn5 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 16:
            if([dosageBtn16 isSelected]==YES)
            {
            }
            else{
                [dosageBtn16 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn15 setSelected:NO];
                [dosageBtn17 setSelected:NO];
                [dosageBtn18 setSelected:NO];
                [dosageBtn19 setSelected:NO];
                [dosageBtn20 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 17:
            if([dosageBtn17 isSelected]==YES)
            {
            }
            else{
                [dosageBtn17 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn15 setSelected:NO];
                [dosageBtn16 setSelected:NO];
                [dosageBtn18 setSelected:NO];
                [dosageBtn19 setSelected:NO];
                [dosageBtn20 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 18:
            if([dosageBtn18 isSelected]==YES)
            {
            }
            else{
                [dosageBtn18 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn15 setSelected:NO];
                [dosageBtn16 setSelected:NO];
                [dosageBtn17 setSelected:NO];
                [dosageBtn19 setSelected:NO];
                [dosageBtn20 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 19:
            if([dosageBtn19 isSelected]==YES)
            {
            }
            else{
                [dosageBtn19 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn15 setSelected:NO];
                [dosageBtn16 setSelected:NO];
                [dosageBtn17 setSelected:NO];
                [dosageBtn18 setSelected:NO];
                [dosageBtn20 setSelected:NO];

                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
        case 20:
            if([dosageBtn20 isSelected]==YES)
            {
            }
            else{
                [dosageBtn20 setSelected:YES];
                [dosageBtn setSelected:NO];
                [dosageBtn2 setSelected:NO];
                [dosageBtn3 setSelected:NO];
                [dosageBtn1 setSelected:NO];
                [dosageBtn4 setSelected:NO];
                [dosageBtn6 setSelected:NO];
                [dosageBtn7 setSelected:NO];
                [dosageBtn8 setSelected:NO];
                [dosageBtn9 setSelected:NO];
                [dosageBtn10 setSelected:NO];
                [dosageBtn11 setSelected:NO];
                [dosageBtn12 setSelected:NO];
                [dosageBtn13 setSelected:NO];
                [dosageBtn14 setSelected:NO];
                [dosageBtn5 setSelected:NO];
                [dosageBtn15 setSelected:NO];
                [dosageBtn16 setSelected:NO];
                [dosageBtn17 setSelected:NO];
                [dosageBtn18 setSelected:NO];
                [dosageBtn19 setSelected:NO];
                lableNameStr=[NSString stringWithFormat:@"%@",pVOS.LabelName];
            }
            break;
    }
    
    if ([pVOS.LabelName rangeOfString:@"SOL"].location != NSNotFound) {
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"SYP"].location != NSNotFound){
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"TAB"].location != NSNotFound){
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"CAP"].location != NSNotFound){
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"INJ"].location != NSNotFound){
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"CON"].location != NSNotFound){
        [self displayFirstview:height];
    }else if ([pVOS.LabelName rangeOfString:@"CRE"].location != NSNotFound || [pVOS.LabelName rangeOfString:@"GEL"].location != NSNotFound || [pVOS.LabelName rangeOfString:@"LOT"].location != NSNotFound || [pVOS.LabelName rangeOfString:@"OIN"].location != NSNotFound || [pVOS.LabelName rangeOfString:@"NEB"].location != NSNotFound){
        [self displaysecondview:height];
    }
}

-(IBAction)redioBtnActionPer:(UIButton *)sender{
    NSLog(@"Button tag %ld",(long)sender.tag);
    switch ([sender tag]) {
        case 1:
            if([pardayBtnOne isSelected]==YES)
            {
            }
            else{
                [pardayBtnOne setSelected:YES];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [parweekBtn setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                captionnameStr=@"Per day once";
            }
            break;
        case 2:
            if([pardayBtntwo isSelected]==YES)
            {
            }
            else{
                [pardayBtntwo setSelected:YES];
                [pardayBtnOne setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [parweekBtn setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                captionnameStr=@"Per day twice";
            }
            break;
        case 3:
            if([pardayBtnthree isSelected]==YES)
            {
            }
            else{
                [pardayBtnthree setSelected:YES];
                [pardayBtntwo setSelected:NO];
                [pardayBtnOne setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [parweekBtn setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                captionnameStr=@"Per day thrice";
            }
            break;
        case 4:
            if([pardayBtnfour isSelected]==YES)
            {
            }
            else{
                [pardayBtnfour setSelected:YES];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnOne setSelected:NO];
                [parweekBtn setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                captionnameStr=@"Per day four times";
            }
            break;

        case 5:
            if([parweekBtn isSelected]==YES)
            {
            }
            else{
                [parweekBtn setSelected:YES];
                [pardayBtnOne setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnOne setSelected:NO];

                captionnameStr=@"Per week";
            }
            break;
        case 6:
            if([parmonthBtn isSelected]==YES)
            {
            }
            else{
                [parmonthBtn setSelected:YES];
                [pardayBtnOne setSelected:NO];
                [asneededBtn setSelected:NO];
                [parweekBtn setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnOne setSelected:NO];

                captionnameStr=@"Per month";
            }
            break;
        case 7:
            if([asneededBtn isSelected]==YES)
            {
            }
            else{
                [asneededBtn setSelected:YES];
                [pardayBtnOne setSelected:NO];
                [parmonthBtn setSelected:NO];
                [parweekBtn setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnOne setSelected:NO];

                captionnameStr=@"As needed";

            }
            break;
    }
    
    if ([captionnameStr isEqualToString:@"As needed"]) {
        nooftabletTxt.hidden=YES;
        tabletnameLbl.hidden=YES;
    }else{
        nooftabletTxt.hidden=NO;
        tabletnameLbl.hidden=NO;
    }
}

#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DrugsDetailsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    DrugDetalisVO *pVOS=[DrugsDetailsArray objectAtIndex:indexPath.row];
    if (pVOS.PackageDescription !=nil) {
    return screenRect.size.height*0.33;
    }else{
        return screenRect.size.height*0.27;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
    UILabel *DrugNameLbl,*ChemicalNameLbl,*SearchMatchTypeLbl,*dayofsupplyLbl,*packageLbl;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *backgroundView;
    DrugDetalisVO *pVOS=[DrugsDetailsArray objectAtIndex:indexPath.row];
    
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01, 2, screenRect.size.width*0.98, screenRect.size.height*0.29)];
    [backgroundView setBackgroundColor:[UIColor colorWithHexString:@"f7f8f8"]];
    backgroundView.layer.cornerRadius=2.5f;
    backgroundView.layer.borderWidth=1.0f;
    backgroundView.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;
    //[cell.contentView addSubview:backgroundView];
    
    DrugNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,0, screenRect.size.width*0.90, screenRect.size.height*0.07)];
    DrugNameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    DrugNameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    DrugNameLbl.text=[NSString stringWithFormat:@"Dosage: %@",pVOS.LabelName];
    DrugNameLbl.textAlignment = NSTextAlignmentLeft;
    DrugNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    DrugNameLbl.numberOfLines = 0;
    [cell.contentView addSubview:DrugNameLbl];
    
    ChemicalNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.08, screenRect.size.width*0.90, screenRect.size.height*0.05)];
    ChemicalNameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    ChemicalNameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    ChemicalNameLbl.text=[NSString stringWithFormat:@"CommonUserQuantity: %@",pVOS.CommonUserQuantity];
    ChemicalNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    ChemicalNameLbl.numberOfLines = 0;
    ChemicalNameLbl.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:ChemicalNameLbl];
    
    SearchMatchTypeLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13, screenRect.size.width*0.90, screenRect.size.height*0.05)];
    SearchMatchTypeLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    SearchMatchTypeLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    SearchMatchTypeLbl.text=[NSString stringWithFormat:@"CommonMetricQuantity: %@",pVOS.CommonMetricQuantity];
    SearchMatchTypeLbl.lineBreakMode = NSLineBreakByWordWrapping;
    SearchMatchTypeLbl.numberOfLines = 0;
    SearchMatchTypeLbl.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:SearchMatchTypeLbl];
    
    dayofsupplyLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.18, screenRect.size.width*0.90, screenRect.size.height*0.05)];
    dayofsupplyLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    dayofsupplyLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    dayofsupplyLbl.text=[NSString stringWithFormat:@"CommonDaysOfSupply: %@",pVOS.CommonDaysOfSupply];
    dayofsupplyLbl.lineBreakMode = NSLineBreakByWordWrapping;
    dayofsupplyLbl.numberOfLines = 0;
    dayofsupplyLbl.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:dayofsupplyLbl];

    if (pVOS.PackageDescription !=nil) {
        packageLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.23, screenRect.size.width*0.90, screenRect.size.height*0.08)];
        packageLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
        packageLbl.textColor=[UIColor colorWithHexString:@"03687f"];
        packageLbl.text=[NSString stringWithFormat:@"Packages : %@, %@ x %@ = %@%@",pVOS.PackageDescription,pVOS.PackageSize,pVOS.PackageQuantity,pVOS.TotalPackageQuantity,pVOS.PackageSizeUnitOfMeasure];
        packageLbl.lineBreakMode = NSLineBreakByWordWrapping;
        packageLbl.numberOfLines = 0;
        packageLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:packageLbl];
        
        UILabel * lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.325, screenRect.size.width*0.90,1)];
        [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [cell.contentView addSubview:lineLbl];

    }else{
        UILabel * lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.265, screenRect.size.width*0.90,1)];
        [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [cell.contentView addSubview:lineLbl];
    }
    tableView.backgroundColor=[UIColor clearColor];
    [cell setBackgroundColor:[UIColor clearColor]];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
