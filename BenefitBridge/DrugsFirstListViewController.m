//
//  DrugsFirstListViewController.m
//  BenefitBridge
//
//  Created by Infinitum on 22/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import "DrugsFirstListViewController.h"
#import "Reachability.h"
#import "PharmacyVO.h"
#import "UIColor+Expanded.h"
#import "DrugFirstVO.h"
#import "DrugsDetalisViewController.h"
@interface DrugsFirstListViewController ()

@end

@implementation DrugsFirstListViewController
@synthesize appDelegate,DrugsArray,tableViewMain,activityImageView,tokenStr,msgLbl,searchStr,SearchBtn,
DrugsTxt,searchBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Medicine List";
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
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];
    
//    DrugsTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.70,screenRect.size.height*0.06)];
//    DrugsTxt.font=font1;
//    DrugsTxt.textAlignment=NSTextAlignmentLeft;
//    DrugsTxt.delegate = self;
//    DrugsTxt.textColor=[UIColor colorWithHexString:@"434444"];
//    CALayer *bottomBorders6 = [CALayer layer];
//    bottomBorders6.frame = CGRectMake(0.0f, DrugsTxt.frame.size.height - 1, DrugsTxt.frame.size.width, 1.0f);
//    bottomBorders6.backgroundColor = [UIColor lightGrayColor].CGColor;
//    [DrugsTxt.layer addSublayer:bottomBorders6];
//    UIView *paddingVie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    DrugsTxt.leftView = paddingVie;
//    DrugsTxt.tag=5;
//    DrugsTxt.leftViewMode = UITextFieldViewModeAlways;
//    self.DrugsTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search Medicine" attributes:@{NSForegroundColorAttributeName: color}];
//    DrugsTxt.returnKeyType=UIReturnKeyNext;
//    [self.view addSubview:DrugsTxt];
//    
//
//    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
//    
//    SearchBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.75, screenRect.size.height*0.12, screenRect.size.width*0.24, screenRect.size.height*0.06)];
//    [SearchBtn setBackgroundColor:[UIColor clearColor]];
//    SearchBtn.layer.cornerRadius = 6.0f;
//    [SearchBtn addTarget:self action:@selector(SearcgDrugsClick:) forControlEvents:UIControlEventTouchUpInside];
//    [SearchBtn setTitle:@"Search" forState:UIControlStateNormal];
//    [SearchBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
//    [self.view addSubview:SearchBtn];
    UIFont *customFontdreg = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.035];

   UILabel * InfoLbl= [[UILabel alloc] init];
    [InfoLbl setFrame:CGRectMake(screenRect.size.width*0.02, screenRect.size.height*0.12, screenRect.size.width*0.96, screenRect.size.height*0.04)];
    InfoLbl.textAlignment = NSTextAlignmentCenter;
    InfoLbl.text=[NSString stringWithFormat:@"Type at least 3 characters for auto search"];
    InfoLbl.font=customFontdreg;
    InfoLbl.textColor=[UIColor grayColor];
    [self.view addSubview:InfoLbl];

            searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, screenRect.size.width*0.96, 44.0)];
            searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [searchBar setBackgroundColor:[UIColor clearColor]];
            searchBar.placeholder=@"Search";
            searchBar.showsCancelButton = YES;
            [searchBar sizeToFit];
            searchBar.tintColor=[UIColor grayColor];
            searchBar.barTintColor = [UIColor whiteColor];
            UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.165,screenRect.size.width*0.96,screenRect.size.height*0.06)];
            searchBarView.autoresizingMask = 0;
            searchBar.delegate = self;
            [searchBarView addSubview:searchBar];
            [searchBarView setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:searchBarView];

    DrugsArray=[[NSMutableArray alloc]init];
    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,screenRect.size.height*0.235,screenRect.size.width,screenRect.size.height*0.76);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    tableViewMain.separatorInset = UIEdgeInsetsZero;
    tableViewMain.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:tableViewMain];
    

}

-(void)viewDidAppear:(BOOL)animated{
}
-(IBAction)CancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)SearcgDrugsClick:(id)sender{
    
    if ([DrugsTxt.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please fill data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        [DrugsTxt resignFirstResponder];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        [self performSelector:@selector(SearchData) withObject:nil afterDelay:1.0 ];
    }
}

#pragma mark - Search Implementation
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    NSLog(@"Cancel clicked");
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (![self.searchBar.text isEqualToString:@""]) {
        int charlenght=[self.searchBar.text length];
        if (charlenght>2) {
            [self.searchBar resignFirstResponder];
            DrugsArray=[[NSMutableArray alloc]init];
            NSLog(@"searchBar text %@",self.searchBar.text);
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            [self performSelector:@selector(SearchData) withObject:nil afterDelay:1.0 ];
        }
        else
        {
            DrugsArray=[[NSMutableArray alloc]init];
            [tableViewMain reloadData];
        }
    }
    else
    {
        DrugsArray=[[NSMutableArray alloc]init];
        [tableViewMain reloadData];
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [self.searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar {
    NSLog(@"Search Clicked");
    [self.searchBar resignFirstResponder];
    DrugsArray=[[NSMutableArray alloc]init];
    NSLog(@"searchBar text %@",self.searchBar.text);
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    [self performSelector:@selector(SearchData) withObject:nil afterDelay:1.0 ];

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
                    NSString *str = [userDict objectForKey:@"access_token"];
                    tokenStr =[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSLog(@"Token :%@",tokenStr);

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
        DrugsArray=[[NSMutableArray alloc]init];
        
        NSString *token=[NSString stringWithFormat:@"Bearer %@",tokenStr];
        NSError *error;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //[request setURL:[NSURL URLWithString:@"http://192.168.0.192:9810/api/IdCard/UpdateImages"]];
        //Autocomplete
        //https://i.diawi.com/VFZ9zf
        NSString *url=[NSString stringWithFormat:@"https://www.drxwebservices.com/APITools/v1/Drugs/Autocomplete?q=%@",searchBar.text];
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
                NSLog(@"reponse content %@",content);
                if ([content rangeOfString:@"The request is invalid"].location != NSNotFound) {
                    [activityImageView removeFromSuperview];

                }else{
                if (![content isEqualToString:@""]) {
                   NSArray *activityArray=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                        //NSArray *activityArray=[userDict objectForKey:@"PharmacyList"];
                        for (int count=0; count<[activityArray count]; count++) {
                            NSDictionary *activityData=[activityArray objectAtIndex:count];
                            DrugFirstVO *Pvo=[[DrugFirstVO alloc] init];
                            Pvo.DrugID=[[NSString alloc] init];
                            Pvo.DrugName=[[NSString alloc] init];
                            Pvo.DrugType=[[NSString alloc] init];
                            Pvo.DrugTypeID=[[NSString alloc] init];
                            Pvo.ChemicalName=[[NSString alloc] init];
                            Pvo.GenericDrugID=[[NSString alloc] init];
                            Pvo.GenericDrugName=[[NSString alloc] init];
                            Pvo.SearchMatchType=[[NSString alloc] init];
                            Pvo.ReferenceNDC=[[NSString alloc] init];
                            
                            if ([activityData objectForKey:@"DrugID"] != [NSNull null])
                                Pvo.DrugID=[activityData objectForKey:@"DrugID"];
                            
                            if ([activityData objectForKey:@"DrugName"] != [NSNull null])
                                Pvo.DrugName=[activityData objectForKey:@"DrugName"];
                            
                            if ([activityData objectForKey:@"DrugType"] != [NSNull null])
                                Pvo.DrugType=[activityData objectForKey:@"DrugType"];
                            
                            if ([activityData objectForKey:@"DrugTypeID"] != [NSNull null])
                                Pvo.DrugTypeID=[activityData objectForKey:@"DrugTypeID"];
                            
                            if ([activityData objectForKey:@"ChemicalName"] != [NSNull null])
                                Pvo.ChemicalName=[activityData objectForKey:@"ChemicalName"];
                            
                            if ([activityData objectForKey:@"GenericDrugID"] != [NSNull null])
                                Pvo.GenericDrugID=[activityData objectForKey:@"GenericDrugID"];

                            if ([activityData objectForKey:@"GenericDrugName"] != [NSNull null])
                                Pvo.GenericDrugName=[activityData objectForKey:@"GenericDrugName"];

                            if ([activityData objectForKey:@"SearchMatchType"] != [NSNull null])
                                Pvo.SearchMatchType=[activityData objectForKey:@"SearchMatchType"];
                            
                            if ([activityData objectForKey:@"ReferenceNDC"] != [NSNull null])
                                Pvo.ReferenceNDC=[activityData objectForKey:@"ReferenceNDC"];
                            
                            [DrugsArray addObject:Pvo];
                        }
                    
                    [tableViewMain reloadData];

                }
                if ([DrugsArray count]>0) {
                    [msgLbl removeFromSuperview];
                    [self.searchBar becomeFirstResponder];

                }else{
                    [self.searchBar becomeFirstResponder];
                    [activityImageView removeFromSuperview];
                    CGRect screenRect = [[UIScreen mainScreen] bounds];
                    [msgLbl removeFromSuperview];
                    msgLbl = [[UILabel alloc] init];
                    [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.24, screenRect.size.width*0.90, 35)];
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
            }
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"OK"]){
        [self.navigationController popViewControllerAnimated:YES];
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
    activityImageView.frame = CGRectMake(screenRect.size.width/2-35,screenRect.size.height/2-85,70,70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
}

#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DrugsArray count];
    
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
    
    UILabel *DrugNameLbl,*ChemicalNameLbl,*SearchMatchTypeLbl;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *backgroundView;
    DrugFirstVO *pVOS=[DrugsArray objectAtIndex:indexPath.row];
    
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01, 2, screenRect.size.width*0.98, screenRect.size.height*0.17)];
    [backgroundView setBackgroundColor:[UIColor colorWithHexString:@"f7f8f8"]];
    backgroundView.layer.cornerRadius=2.5f;
    backgroundView.layer.borderWidth=1.0f;
    backgroundView.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;
    //[cell.contentView addSubview:backgroundView];
    
    DrugNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,0, screenRect.size.width*0.84, screenRect.size.height*0.07)];
    DrugNameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    DrugNameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    DrugNameLbl.text=[NSString stringWithFormat:@"%@",pVOS.DrugName];
    DrugNameLbl.textAlignment = NSTextAlignmentLeft;
    DrugNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    DrugNameLbl.numberOfLines = 0;
    [cell.contentView addSubview:DrugNameLbl];
    
//    ChemicalNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.06, screenRect.size.width*0.90, screenRect.size.height*0.05)];
//    ChemicalNameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
//    ChemicalNameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
//    ChemicalNameLbl.text=[NSString stringWithFormat:@"Medicine type: %@",pVOS.DrugType];
//    ChemicalNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
//    ChemicalNameLbl.numberOfLines = 0;
//    ChemicalNameLbl.textAlignment = NSTextAlignmentLeft;
//    [cell.contentView addSubview:ChemicalNameLbl];
//    
//    SearchMatchTypeLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.width*0.90, screenRect.size.height*0.05)];
//    SearchMatchTypeLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
//    SearchMatchTypeLbl.textColor=[UIColor colorWithHexString:@"03687f"];
//    SearchMatchTypeLbl.text=[NSString stringWithFormat:@"Chemical name: %@",pVOS.ChemicalName];
//    SearchMatchTypeLbl.lineBreakMode = NSLineBreakByWordWrapping;
//    SearchMatchTypeLbl.numberOfLines = 0;
//    SearchMatchTypeLbl.textAlignment = NSTextAlignmentLeft;
//    [cell.contentView addSubview:SearchMatchTypeLbl];

        UIImageView *  logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.84,screenRect.size.height*0.005,40,40)];
        [logoImg setImage:[UIImage imageNamed:@"user_plus.png"]];
        [cell.contentView addSubview:logoImg];

    UIButton *addpharmacycontactbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.85,0,screenRect.size.width*0.15,screenRect.size.height*0.08)];
    [addpharmacycontactbtn addTarget:self
                              action:@selector(submitPharmacyContact:)
                    forControlEvents:UIControlEventTouchUpInside];
    [addpharmacycontactbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addpharmacycontactbtn.tag=indexPath.row;
//    [addpharmacycontactbtn setBackgroundImage:[UIImage imageNamed:@"user_plus.png"]forState:UIControlStateNormal];
    [cell.contentView addSubview:addpharmacycontactbtn];
//    }
      UILabel * lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.075, screenRect.size.width*0.90,1)];
        [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [cell.contentView addSubview:lineLbl];


    tableView.backgroundColor=[UIColor clearColor];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//       DrugsDetalisViewController  *pharmacy=[[DrugsDetalisViewController alloc] initWithNibName:@"DrugsDetalisViewController" bundle:nil];
//        DrugFirstVO* pharVO=[DrugsArray objectAtIndex:indexPath.row];
//        pharmacy.drugIDStr=[[NSString alloc]init];
//        pharmacy.drugIDStr=pharVO.DrugID;
//        appDelegate.drugAdd=NO;
//        [self.navigationController pushViewController:pharmacy animated:YES];
//}

-(void)submitPharmacyContact:(UIButton *)Btn{
//    if (appDelegate.mainArray==nil) {
//        appDelegate.mainArray=[[NSMutableArray alloc]init];
//    }
//    DrugFirstVO* pharVO=[DrugsArray objectAtIndex:Btn.tag];
//    [appDelegate.mainArray addObject:pharVO];
////    NSArray *array = [appDelegate.mainArray copy];
////    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
////    NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
////    [prefsusername setObject:data forKey:@"DrugList"];
////    [prefsusername synchronize];
//
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine added successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//
//    [tableViewMain reloadData];
    
    DrugsDetalisViewController  *pharmacy=[[DrugsDetalisViewController alloc] initWithNibName:@"DrugsDetalisViewController" bundle:nil];
    DrugFirstVO* pharVO=[DrugsArray objectAtIndex:Btn.tag];
    pharmacy.drugIDStr=[[NSString alloc]init];
    pharmacy.drugIDStr=pharVO.DrugID;
    pharmacy.pharVO=[[DrugFirstVO alloc]init];
    pharmacy.pharVO=pharVO;
    appDelegate.drugAdd=NO;
    [self.navigationController pushViewController:pharmacy animated:YES];

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
