//
//  HomeViewController.m
//  demo
//
//  Created by Infinitum on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "AsyncImageView.h"
#import "UIColor+Expanded.h"
#import "MyBenefitViewController.h"
#import "ContactListViewController.h"
#import "IdCardsDetalisViewController.h"
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "SearchViewController.h"
#import "MyRxViewController.h"
@interface HomeViewController ()
{
    NSArray *ImgArr;
    NSArray *NameArr;
}

@end

@implementation HomeViewController
@synthesize appDelegate,activityDetailsArray,activityIndicator,tableViewMain,mybenefitBtn,idcardsBtn,myRxBtn,providercontactBtn,findpharmacyBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"Demo Health";
    [titleLabel setTextColor: [self colorFromHexString:@"#03687f"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    //self.navigationItem.titleView = titleLabel;
    
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
    //[self.view.layer insertSublayer:gradient atIndex:0];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *mode=[prefs objectForKey:@"modes"];
    if ([mode isEqualToString:@"offline"]) {
        NameArr=[[NSArray alloc]initWithObjects:@"ID Cards",@"My Rx",@"Provider Contacts",nil];
        ImgArr=[[NSArray alloc]initWithObjects:@"id_card_new_85X85.png",@"my_rx_icon.png",@"contacts_new_85X85.png",nil];
    }else{
        NameArr=[[NSArray alloc]initWithObjects:@"My Benefits",@"ID Cards",@"My Rx",@"Provider Contacts",@"Find Pharmacy",nil];
        ImgArr=[[NSArray alloc]initWithObjects:@"my_benefits_new_85X85-1.png",@"id_card_new_85X85.png",@"my_rx_icon.png",@"contacts_new_85X85.png",@"Pharmacy_icon.png",nil];
    }
    UIImageView *bannerAsyncimg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.30,0, screenRect.size.width*.40, screenRect.size.height*.06)];
    [bannerAsyncimg.layer setMasksToBounds:YES];
    bannerAsyncimg.clipsToBounds=YES;
    [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];
    NSData *receivedData = (NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"clientlogo"];
    UIImage *image = [[UIImage alloc] initWithData:receivedData];
    bannerAsyncimg.image=image;
    self.navigationItem.titleView = bannerAsyncimg;

    [self setFontFamily:@"Open Sans" forView:self.view andSubViews:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.translucent = NO;
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,30,25)];
    //[leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
    [leftBtn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"slider_icon-4.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    //[self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    self.navigationItem.leftBarButtonItem = btn;
    
//    tableViewMain=[[UITableView alloc]init];
//    tableViewMain.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height);
//    tableViewMain.dataSource = self;
//    tableViewMain.delegate = self;
//    [tableViewMain setBackgroundColor:[UIColor clearColor]];
//    self.tableViewMain.separatorColor = [UIColor clearColor];
//    tableViewMain.separatorInset = UIEdgeInsetsZero;
//    tableViewMain.layoutMargins = UIEdgeInsetsZero;
//    [self.view addSubview:tableViewMain];
    
    UIImageView * logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.35,screenRect.size.height*0.85,screenRect.size.width*0.30,screenRect.size.height*0.05)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    //[self.view addSubview:logoImg];
    
    NSString *modes=[prefs objectForKey:@"modes"];
    if ([modes isEqualToString:@"offline"]) {
        
        UIImageView * idcardsImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.07,screenRect.size.height*0.19,screenRect.size.width*0.35,screenRect.size.width*0.35)];
        [idcardsImg setImage:[UIImage imageNamed:@"id_cards_new_new.png"]];
        [self.view addSubview:idcardsImg];
        
        idcardsBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.19,screenRect.size.width*0.48,screenRect.size.height*0.20)];
        [idcardsBtn setBackgroundColor:[UIColor clearColor]];
        [idcardsBtn addTarget:self action:@selector(IDCardsAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:idcardsBtn];
        
        UILabel * idcardsLbl=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.35,screenRect.size.width*0.48,80)];
        idcardsLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.05];
        idcardsLbl.textColor=[UIColor colorWithHexString:@"03687f"];
        idcardsLbl.text=@"ID Cards";
        idcardsLbl.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:idcardsLbl];
        
        UIImageView * myRxImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.57,screenRect.size.height*0.19,screenRect.size.width*0.35,screenRect.size.width*0.35)];
        [myRxImg setImage:[UIImage imageNamed:@"my_rx_new_new.png"]];
        [self.view addSubview:myRxImg];
        
        myRxBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.19,screenRect.size.width*0.48,screenRect.size.height*0.20)];
        [myRxBtn setBackgroundColor:[UIColor clearColor]];
        [myRxBtn addTarget:self action:@selector(MyRxAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:myRxBtn];
        
        
        UILabel * myRxLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.35,screenRect.size.width*0.48,80)];
        myRxLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.05];
        myRxLbl.textColor=[UIColor colorWithHexString:@"03687f"];
        myRxLbl.text=@"My Rx";
        myRxLbl.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:myRxLbl];
        
        UIImageView * providercontactImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.07,screenRect.size.height*0.46,screenRect.size.width*0.35,screenRect.size.width*0.35)];
        [providercontactImg setImage:[UIImage imageNamed:@"contcts_new_new.png"]];
        [self.view addSubview:providercontactImg];
        
        providercontactBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.48,screenRect.size.width*0.46,screenRect.size.height*0.20)];
        [providercontactBtn setBackgroundColor:[UIColor clearColor]];
        [providercontactBtn addTarget:self action:@selector(ContactsAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:providercontactBtn];

        UILabel * providercontactLbl=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.61,screenRect.size.width*0.48,80)];
        providercontactLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.05];
        providercontactLbl.textColor=[UIColor colorWithHexString:@"03687f"];
        providercontactLbl.text=@"Provider Contacts";
        providercontactLbl.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:providercontactLbl];

    }else{
    
    UIImageView * mybenefitImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.07,screenRect.size.height*0.19,screenRect.size.width*0.35,screenRect.size.width*0.35)];
    [mybenefitImg setImage:[UIImage imageNamed:@"My_Benefits_new-3_new.png"]];
    [self.view addSubview:mybenefitImg];

    mybenefitBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.19,screenRect.size.width*0.48,screenRect.size.height*0.20)];
    [mybenefitBtn setBackgroundColor:[UIColor clearColor]];
    [mybenefitBtn addTarget:self action:@selector(MyBenefitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mybenefitBtn];

    UILabel * mybenefitLbl=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.35,screenRect.size.width*0.48,80)];
    mybenefitLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.05];
    mybenefitLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    mybenefitLbl.text=@"My Benefits";
    mybenefitLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mybenefitLbl];
        
    UIImageView * idcardsImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.57,screenRect.size.height*0.19,screenRect.size.width*0.35,screenRect.size.width*0.35)];
    [idcardsImg setImage:[UIImage imageNamed:@"id_cards_new_new.png"]];
    [self.view addSubview:idcardsImg];
    
    idcardsBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.19,screenRect.size.width*0.48,screenRect.size.height*0.20)];
    [idcardsBtn setBackgroundColor:[UIColor clearColor]];
    [idcardsBtn addTarget:self action:@selector(IDCardsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:idcardsBtn];

    UILabel * idcardsLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.35,screenRect.size.width*0.48,80)];
    idcardsLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.05];
    idcardsLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    idcardsLbl.text=@"ID Cards";
    idcardsLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:idcardsLbl];

    UIImageView * myRxImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.07,screenRect.size.height*0.46,screenRect.size.width*0.35,screenRect.size.width*0.35)];
    [myRxImg setImage:[UIImage imageNamed:@"my_rx_new_new.png"]];
    [self.view addSubview:myRxImg];
    
    myRxBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.48,screenRect.size.width*0.46,screenRect.size.height*0.20)];
    [myRxBtn setBackgroundColor:[UIColor clearColor]];
    [myRxBtn addTarget:self action:@selector(MyRxAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myRxBtn];

    UILabel * myRxLbl=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.61,screenRect.size.width*0.48,80)];
    myRxLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.05];
    myRxLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    myRxLbl.text=@"My Rx";
    myRxLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:myRxLbl];

    UIImageView * providercontactImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.57,screenRect.size.height*0.46,screenRect.size.width*0.35,screenRect.size.width*0.35)];
    [providercontactImg setImage:[UIImage imageNamed:@"contcts_new_new.png"]];
    [self.view addSubview:providercontactImg];
    
    providercontactBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.46,screenRect.size.width*0.48,screenRect.size.height*0.20)];
    [providercontactBtn setBackgroundColor:[UIColor clearColor]];
    [providercontactBtn addTarget:self action:@selector(ContactsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:providercontactBtn];

    UILabel * providercontactLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.61,screenRect.size.width*0.48,80)];
    providercontactLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.05];
    providercontactLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    providercontactLbl.text=@"Provider Contacts";
    providercontactLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:providercontactLbl];

    UIImageView * findpharmacyImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.07,screenRect.size.height*0.73,screenRect.size.width*0.35,screenRect.size.width*0.35)];
    [findpharmacyImg setImage:[UIImage imageNamed:@"my_pharmacy_new_new.png"]];
    [self.view addSubview:findpharmacyImg];
    
    findpharmacyBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.73,screenRect.size.width*0.48,screenRect.size.height*0.20)];
    [findpharmacyBtn setBackgroundColor:[UIColor clearColor]];
    [findpharmacyBtn addTarget:self action:@selector(PharmacyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findpharmacyBtn];
        
    UILabel * findpharmacyLbl=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.88,screenRect.size.width*0.48,80)];
    findpharmacyLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.05];
    findpharmacyLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    findpharmacyLbl.text=@"Find Pharmacy";
    findpharmacyLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:findpharmacyLbl];

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
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    appDelegate.isLandscapeOK=NO;
    [tableViewMain reloadData];
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


- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}


- (void)didReceiveMemoryWarning
{
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
    return [NameArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int count=[NameArr count];
    if (count==3) {
        return screenRect.size.height*0.30;
    }else{
        //return screenRect.size.height*0.225;
        return screenRect.size.height*0.18;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *NameLbl,*lineLbl;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    NSString *url=[ImgArr objectAtIndex:indexPath.row];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIImageView *logoImg;
    
    int count=[NameArr count];
    if (count==5) {
    if (indexPath.row==0) {
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.015,85,85)];
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.47, screenRect.size.height*0.015, screenRect.size.width*0.50, 80)];

        lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.175, screenRect.size.width*0.90,1)];
        [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [cell.contentView addSubview:lineLbl];

    }else if (indexPath.row==1) {
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.015,85,85)];
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.47, screenRect.size.height*0.015, screenRect.size.width*0.50, 80)];

        lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.175, screenRect.size.width*0.90,1)];
        [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [cell.contentView addSubview:lineLbl];

    }else if (indexPath.row==2){
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.015,85,85)];
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.47, screenRect.size.height*0.015, screenRect.size.width*0.50, 80)];

        lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.175, screenRect.size.width*0.90,1)];
        [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [cell.contentView addSubview:lineLbl];

    }else if (indexPath.row==3){
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.015,85,85)];
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.47, screenRect.size.height*0.015, screenRect.size.width*0.50, 80)];
        lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.175, screenRect.size.width*0.90,1)];
        [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [cell.contentView addSubview:lineLbl];

    }
    else if (indexPath.row==4){
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.015,85,85)];
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.47, screenRect.size.height*0.015, screenRect.size.width*0.50, 80)];
        
    }
    }else{
        if (indexPath.row==0) {
            logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.08,85,85)];
            NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.47, screenRect.size.height*0.08, screenRect.size.width*0.50, 80)];
            
            lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.295, screenRect.size.width*0.90,1)];
            [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
            [cell.contentView addSubview:lineLbl];
            
        }else if (indexPath.row==1) {
            logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.08,85,85)];
            NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.47, screenRect.size.height*0.08, screenRect.size.width*0.50, 80)];
            
            lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.295, screenRect.size.width*0.90,1)];
            [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
            [cell.contentView addSubview:lineLbl];
        }
        else if (indexPath.row==2) {
            logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.19,screenRect.size.height*0.08,85,85)];
            NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.47, screenRect.size.height*0.08, screenRect.size.width*0.50, 80)];
            
            lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.445, screenRect.size.width*0.90,1)];
            [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
            //[cell.contentView addSubview:lineLbl];
        }
    }
    [logoImg setImage:[UIImage imageNamed:url]];
    [cell.contentView addSubview:logoImg];

    NameLbl.tag=3;
    NameLbl.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:screenRect.size.width*0.05];
    NameLbl.textColor=[UIColor whiteColor];
    NameLbl.text=[NameArr objectAtIndex:indexPath.row];
    [cell.contentView addSubview:NameLbl];

    tableView.backgroundColor=[UIColor clearColor];
    [cell setBackgroundColor:[UIColor clearColor]];
        //Your main thread code goes in here
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * nameindex=[NameArr objectAtIndex:indexPath.row];
    if ([nameindex isEqualToString:@"My Benefits"]) {
        MyBenefitViewController *myBenefit=[[MyBenefitViewController alloc] initWithNibName:@"MyBenefitViewController" bundle:nil];
        
        myBenefit.idcardsYes=[[NSString alloc]init];
        myBenefit.idcardsYes=@"My Benefits";
        [self.navigationController pushViewController:myBenefit animated:YES];

    }else if ([nameindex isEqualToString:@"ID Cards"]){
        IdCardsDetalisViewController *cardsDetails=[[IdCardsDetalisViewController alloc] initWithNibName:@"IdCardsDetalisViewController" bundle:nil];
//        myBenefit.idcardsYes=[[NSString alloc]init];
//        myBenefit.idcardsYes=@"ID Cards";
        [self.navigationController pushViewController:cardsDetails animated:YES];
    }else if ([nameindex isEqualToString:@"Provider Contacts"]){
        ContactListViewController *contact=[[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil];
        [self.navigationController pushViewController:contact animated:YES];
    }else if ([nameindex isEqualToString:@"Find Pharmacy"]){
        SearchViewController *search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        [self.navigationController pushViewController:search animated:YES];
    }else if ([nameindex isEqualToString:@"My Rx"]){
        MyRxViewController *myRX=[[MyRxViewController alloc] initWithNibName:@"MyRxViewController" bundle:nil];
        [self.navigationController pushViewController:myRX animated:YES];
    }
}

-(IBAction)MyBenefitAction{
    MyBenefitViewController *myBenefit=[[MyBenefitViewController alloc] initWithNibName:@"MyBenefitViewController" bundle:nil];
    myBenefit.idcardsYes=[[NSString alloc]init];
    myBenefit.idcardsYes=@"My Benefits";
    [self.navigationController pushViewController:myBenefit animated:YES];
}

-(IBAction)IDCardsAction{
    IdCardsDetalisViewController *cardsDetails=[[IdCardsDetalisViewController alloc] initWithNibName:@"IdCardsDetalisViewController" bundle:nil];
    [self.navigationController pushViewController:cardsDetails animated:YES];
}
-(IBAction)ContactsAction{
    ContactListViewController *contact=[[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil];
    [self.navigationController pushViewController:contact animated:YES];
}
-(IBAction)PharmacyAction{
    SearchViewController *search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:search animated:YES];
}
-(IBAction)MyRxAction{
    MyRxViewController *myRX=[[MyRxViewController alloc] initWithNibName:@"MyRxViewController" bundle:nil];
    [self.navigationController pushViewController:myRX animated:YES];
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
