//
//  ContactViewController.m
//  demo
//
//  Created by Infinitum on 11/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "ContactViewController.h"
#import "AsyncImageView.h"
#import "MainViewController.h"
#import "UIColor+Expanded.h"
#import "ContactListViewController.h"
#import "Reachability.h"
#define MAX_LENGTH 5

@interface ContactViewController ()

@end

@implementation ContactViewController
@synthesize logoImg,firstNameTxt,lastNameTxt,addressTxt,cityTxt,stateTxt,countryTxt,zipTxt,PhonenoTxt,firstnameLbl,lastnameLbl,addressLbl,cityLbl,stateLbl,countryLbl,zipLbl,phonenoLbl,scrollView,BenefitTypeTxt,benefittypeLbl,BenefitPickerView,BenefitPickertoolbar,benefitTypeArray,editing,updateBtn,listView,listofBenefitBtn,benefitScrollview,islistviewVisible,contactVOS,activityIndicator,btnscrollview,appDelegate,SpecialityTxt,SpecialityLbl,activityImageView,numberToolbar,numberToolbarzip,mainbenefitarray,tempArray,titleLabel,benefitpickerview,specialitypickerview,statepickerview,toolbarbenefit,toolbarspeciality,toolbarstate,selectedTxtfieldbenefit,selectedTxtfieldstate,selectedTxtfieldspeclaity,heigth,heigth1,selectedStrState,selectedStrBenefit,selectedStrspecility;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    appDelegate.contactsubmitdeleteupdate=false;

    titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Provider Contacts";
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
   // [leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
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

    if ([editing isEqualToString:@"NO"]) {

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setFrame:CGRectMake(0, 0,30,30)];
    //[rightBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    rightBtn.titleLabel.font = fontss;
    [rightBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    //[self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
        
        UIButton *rightBtnDelete = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightBtnDelete setFrame:CGRectMake(30, 0,30,30)];
        //[rightBtn setTitle:@"Edit" forState:UIControlStateNormal];
        [rightBtnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtnDelete setBackgroundImage:[UIImage imageNamed:@"font-awesome_4-6-3_trash_60_10_851c2b_none.png"] forState:UIControlStateNormal];
        UIBarButtonItem *btnsdel = [[UIBarButtonItem alloc]initWithCustomView:rightBtnDelete];
        rightBtnDelete.titleLabel.font = fontss;
        [rightBtnDelete setTintColor:[self colorFromHexString:@"#03687f"]];
        [self.navigationItem setRightBarButtonItems:@[btnsdel] animated:NO];

        
    }else{
        titleLabel.text=@"Add Provider Contacts";

    }
        
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //demo hospital logo view
    UIImageView *bannerAsyncimg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.30, screenRect.size.height*.13, screenRect.size.width*.40, screenRect.size.height*.07)];
    [bannerAsyncimg.layer setMasksToBounds:YES];
    bannerAsyncimg.clipsToBounds=YES;
    [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];
    NSData *receivedData = (NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"clientlogo"];
    UIImage *image = [[UIImage alloc] initWithData:receivedData];
    bannerAsyncimg.image=image;
    [self.view addSubview:bannerAsyncimg];
    
    //main scroll view
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*.21, screenRect.size.width, screenRect.size.height*0.70)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];

    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
     heigth=screenRect.size.height*0.01;
    
//    benefittypeLbl= [[UILabel alloc] init];
//    [benefittypeLbl setFrame:CGRectMake(screenRect.size.width*0.10, heigth, screenRect.size.width*0.80, screenRect.size.height*0.05)];
//    benefittypeLbl.textAlignment = NSTextAlignmentLeft;
//    NSMutableAttributedString * stringss = [[NSMutableAttributedString alloc] initWithString:@"Benefit*"];
//    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,7)];
//    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7,1)];
//    benefittypeLbl.attributedText=stringss;
//    benefittypeLbl.font=fonts;
//    [scrollView addSubview:benefittypeLbl];
//    
//    heigth=heigth+screenRect.size.height*0.06;
    
    BenefitTypeTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    BenefitTypeTxt.font=font1;
    BenefitTypeTxt.textAlignment=NSTextAlignmentLeft;
    BenefitTypeTxt.delegate = self;
    BenefitTypeTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders = [CALayer layer];
    bottomBorders.frame = CGRectMake(0.0f, BenefitTypeTxt.frame.size.height - 1, BenefitTypeTxt.frame.size.width, 1.0f);
    bottomBorders.backgroundColor = [UIColor lightGrayColor].CGColor;
    [BenefitTypeTxt.layer addSublayer:bottomBorders];
    UIView *paddingViewsb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    BenefitTypeTxt.leftView = paddingViewsb;
    BenefitTypeTxt.leftViewMode = UITextFieldViewModeAlways;

//    self.BenefitTypeTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Benefit" attributes:@{NSForegroundColorAttributeName: color}];
    
        NSMutableAttributedString * stringss = [[NSMutableAttributedString alloc] initWithString:@"Category*"];
        [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,8)];
        [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8,1)];
    self.BenefitTypeTxt.attributedPlaceholder=stringss;
    [scrollView addSubview:BenefitTypeTxt];

    heigth=heigth+screenRect.size.height*0.08;

    SpecialityTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    SpecialityTxt.font=font1;
    SpecialityTxt.textAlignment=NSTextAlignmentLeft;
    SpecialityTxt.delegate = self;
    SpecialityTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders1 = [CALayer layer];
    bottomBorders1.frame = CGRectMake(0.0f, SpecialityTxt.frame.size.height - 1, SpecialityTxt.frame.size.width, 1.0f);
    bottomBorders1.backgroundColor = [UIColor lightGrayColor].CGColor;
    [SpecialityTxt.layer addSublayer:bottomBorders1];
    UIView *paddingViewsbs = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    SpecialityTxt.leftView = paddingViewsbs;
    SpecialityTxt.leftViewMode = UITextFieldViewModeAlways;
    self.SpecialityTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Speciality" attributes:@{NSForegroundColorAttributeName: color}];
    [scrollView addSubview:SpecialityTxt];
    
    if ([editing isEqualToString:@"NO"]) {
        BenefitTypeTxt.text=contactVOS.BenefitType;
        SpecialityTxt.text=contactVOS.Speciality;
        
    }

    heigth=heigth+screenRect.size.height*0.08;
    

    firstNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    firstNameTxt.font=font1;
    firstNameTxt.textAlignment=NSTextAlignmentLeft;
    firstNameTxt.delegate = self;
    firstNameTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders2 = [CALayer layer];
    bottomBorders2.frame = CGRectMake(0.0f, firstNameTxt.frame.size.height - 1, firstNameTxt.frame.size.width, 1.0f);
    bottomBorders2.backgroundColor = [UIColor lightGrayColor].CGColor;
    [firstNameTxt.layer addSublayer:bottomBorders2];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    firstNameTxt.leftView = paddingView;
    firstNameTxt.tag=1;
    [firstNameTxt setTintColor:[UIColor lightGrayColor]];
    firstNameTxt.leftViewMode = UITextFieldViewModeAlways;
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"First Name*"];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,10)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
        self.firstNameTxt.attributedPlaceholder=string;
    firstNameTxt.returnKeyType=UIReturnKeyNext;
    [scrollView addSubview:firstNameTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    heigth1=heigth;
    
    [self displayView];
    logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.93,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
    [self.view addGestureRecognizer:tap];
    tempArray=[[NSMutableArray alloc]init ];
    tempArray=appDelegate.benefitTypeArray;
    mainbenefitarray=[[NSMutableArray alloc]init ];
    NSMutableArray *temparray=[[NSMutableArray alloc]init];
    for (int count=0; count<[appDelegate.benefitTypeArray count]; count++) {
        NSString *benefittype=[appDelegate.benefitTypeArray objectAtIndex:count];

        [temparray addObject:benefittype];

    }
    
    
    //old placeholder is select benefit then after change select Category
    
    [mainbenefitarray addObject:@"Select Category"];
    for (int count=0; count<[temparray count]; count++) {
        
        NSString *benefittype=[temparray objectAtIndex:count];
        if ([benefittype isEqualToString:@"Medical"]) {
            [mainbenefitarray addObject:@"Medical"];
            [temparray removeObjectAtIndex:count];
        }
    }
    
    for (int counts=0; counts<[temparray count]; counts++) {
        
        NSString *benefittype=[temparray objectAtIndex:counts];
        if ([benefittype isEqualToString:@"Dental"]){
            [mainbenefitarray addObject:@"Dental"];
            [temparray removeObjectAtIndex:counts];
        }
    }
    
    for (int countss=0; countss<[temparray count]; countss++) {
        
        NSString *benefittype=[temparray objectAtIndex:countss];
        if ([benefittype isEqualToString:@"Vision"]){
            [mainbenefitarray addObject:@"Vision"];
            [temparray removeObjectAtIndex:countss];
        }
    }
    
    [mainbenefitarray addObject:@"Pharmacy"];

    for (int countsss=0; countsss<[temparray count]; countsss++) {
        
        NSSortDescriptor *priceDescriptor = [NSSortDescriptor
                                             sortDescriptorWithKey:@""
                                             ascending:YES
                                             selector:@selector(compare:)];
        NSArray *descriptors = @[priceDescriptor];
        [temparray sortUsingDescriptors:descriptors];
        
    }
    for (int counta=0; counta<[temparray count]; counta++) {
        NSString *benefittype=[temparray objectAtIndex:counta];
        
        [mainbenefitarray addObject:benefittype];
    }
}
-(void)displayView{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];
    [lastNameTxt removeFromSuperview];
    [addressTxt removeFromSuperview];
    [cityTxt removeFromSuperview];
    [stateTxt removeFromSuperview];
    [zipTxt removeFromSuperview];
    [PhonenoTxt removeFromSuperview];
    [updateBtn removeFromSuperview];

    heigth=heigth1;

    if ([editing isEqualToString:@"NO"] &&  [BenefitTypeTxt.text isEqualToString:@"Pharmacy"]) {
        
        
    }else{
        if ([BenefitTypeTxt.text isEqualToString:@"Pharmacy"]){
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"Pharmacy Name*"];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,13)];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13,1)];
            self.firstNameTxt.attributedPlaceholder=string;

        }else{
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"First Name*"];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,10)];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
            self.firstNameTxt.attributedPlaceholder=string;

        lastNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
        lastNameTxt.font=font1;
        lastNameTxt.textAlignment=NSTextAlignmentLeft;
        lastNameTxt.delegate = self;
        lastNameTxt.textColor=[UIColor colorWithHexString:@"434444"];
        CALayer *bottomBorders3 = [CALayer layer];
        bottomBorders3.frame = CGRectMake(0.0f, lastNameTxt.frame.size.height - 1, lastNameTxt.frame.size.width, 1.0f);
        bottomBorders3.backgroundColor = [UIColor lightGrayColor].CGColor;
        [lastNameTxt.layer addSublayer:bottomBorders3];
        UIView *paddingViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        lastNameTxt.leftView = paddingViews;
        lastNameTxt.tag=2;
        [lastNameTxt setTintColor:[UIColor lightGrayColor]];
        lastNameTxt.leftViewMode = UITextFieldViewModeAlways;
        self.lastNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
        lastNameTxt.returnKeyType=UIReturnKeyNext;
        [scrollView addSubview:lastNameTxt];
        
        heigth=heigth+screenRect.size.height*0.08;
        }
    }
    
    addressTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    addressTxt.font=font1;
    addressTxt.textAlignment=NSTextAlignmentLeft;
    addressTxt.delegate = self;
    addressTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders4 = [CALayer layer];
    bottomBorders4.frame = CGRectMake(0.0f, addressTxt.frame.size.height - 1, addressTxt.frame.size.width, 1.0f);
    bottomBorders4.backgroundColor = [UIColor lightGrayColor].CGColor;
    [addressTxt.layer addSublayer:bottomBorders4];
    UIView *paddingViewss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    addressTxt.leftView = paddingViewss;
    addressTxt.tag=3;
    [addressTxt setTintColor:[UIColor lightGrayColor]];
    addressTxt.leftViewMode = UITextFieldViewModeAlways;
    self.addressTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: color}];
    addressTxt.returnKeyType=UIReturnKeyNext;
    [scrollView addSubview:addressTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    cityTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    cityTxt.font=font1;
    cityTxt.textAlignment=NSTextAlignmentLeft;
    cityTxt.delegate = self;
    cityTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders5 = [CALayer layer];
    bottomBorders5.frame = CGRectMake(0.0f, cityTxt.frame.size.height - 1, cityTxt.frame.size.width, 1.0f);
    bottomBorders5.backgroundColor = [UIColor lightGrayColor].CGColor;
    [cityTxt.layer addSublayer:bottomBorders5];
    UIView *paddingViewsss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    cityTxt.leftView = paddingViewsss;
    cityTxt.tag=4;
    [cityTxt setTintColor:[UIColor lightGrayColor]];
    cityTxt.leftViewMode = UITextFieldViewModeAlways;
    self.cityTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City" attributes:@{NSForegroundColorAttributeName: color}];
    cityTxt.returnKeyType=UIReturnKeyNext;
    [scrollView addSubview:cityTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    stateTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    stateTxt.font=font1;
    stateTxt.textAlignment=NSTextAlignmentLeft;
    stateTxt.delegate = self;
    stateTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders6 = [CALayer layer];
    bottomBorders6.frame = CGRectMake(0.0f, stateTxt.frame.size.height - 1, stateTxt.frame.size.width, 1.0f);
    bottomBorders6.backgroundColor = [UIColor lightGrayColor].CGColor;
    [stateTxt.layer addSublayer:bottomBorders6];
    UIView *paddingVie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    stateTxt.leftView = paddingVie;
    stateTxt.tag=5;
    stateTxt.leftViewMode = UITextFieldViewModeAlways;
    self.stateTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"State" attributes:@{NSForegroundColorAttributeName: color}];
    stateTxt.returnKeyType=UIReturnKeyNext;
    [scrollView addSubview:stateTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    zipTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    zipTxt.font=font1;
    zipTxt.textAlignment=NSTextAlignmentLeft;
    zipTxt.delegate = self;
    zipTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders7 = [CALayer layer];
    bottomBorders7.frame = CGRectMake(0.0f, zipTxt.frame.size.height - 1, zipTxt.frame.size.width, 1.0f);
    bottomBorders7.backgroundColor = [UIColor lightGrayColor].CGColor;
    [zipTxt.layer addSublayer:bottomBorders7];
    UIView *paddingViewssss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    zipTxt.leftView = paddingViewssss;
    zipTxt.tag=6;
    [zipTxt setTintColor:[UIColor lightGrayColor]];
    zipTxt.leftViewMode = UITextFieldViewModeAlways;
    self.zipTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip" attributes:@{NSForegroundColorAttributeName: color}];
    [zipTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    numberToolbarzip = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarzip.barStyle = UIBarStyleBlackOpaque;
    numberToolbarzip.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbarzip sizeToFit];
    numberToolbarzip.tintColor=[UIColor whiteColor];
    zipTxt.inputAccessoryView = numberToolbarzip;
    zipTxt.returnKeyType=UIReturnKeyNext;
    [scrollView addSubview:zipTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    PhonenoTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heigth,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    PhonenoTxt.font=font1;
    PhonenoTxt.textAlignment=NSTextAlignmentLeft;
    PhonenoTxt.delegate = self;
    PhonenoTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders8 = [CALayer layer];
    bottomBorders8.frame = CGRectMake(0.0f, PhonenoTxt.frame.size.height - 1, PhonenoTxt.frame.size.width, 1.0f);
    bottomBorders8.backgroundColor = [UIColor lightGrayColor].CGColor;
    [PhonenoTxt.layer addSublayer:bottomBorders8];
    UIView *paddingViewr = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    PhonenoTxt.leftView = paddingViewr;
    PhonenoTxt.tag=7;
    [PhonenoTxt setTintColor:[UIColor lightGrayColor]];
    PhonenoTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * strings = [[NSMutableAttributedString alloc] initWithString:@"Phone Number*"];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,12)];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12,1)];
    self.PhonenoTxt.attributedPlaceholder=strings;
    [PhonenoTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackOpaque;
    [numberToolbar setBarStyle:UIBarStyleBlackOpaque];


    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    numberToolbar.tintColor=[UIColor whiteColor];
    PhonenoTxt.inputAccessoryView = numberToolbar;
    PhonenoTxt.returnKeyType=UIReturnKeyNext;
    
    [scrollView addSubview:PhonenoTxt];
    
    scrollView.contentSize=CGSizeMake(screenRect.size.width,heigth+100);
    
    NSString *modes=[prefs objectForKey:@"modes"];
    if ([modes isEqualToString:@"offline"]) {
        firstNameTxt.enabled = NO;
        lastNameTxt.enabled = NO;
        addressTxt.enabled = NO;
        cityTxt.enabled = NO;
        stateTxt.enabled = NO;
        countryTxt.enabled = NO;
        zipTxt.enabled = NO;
        PhonenoTxt.enabled = NO;
        BenefitTypeTxt.enabled = NO;
        SpecialityTxt.enabled = NO;
        updateBtn.hidden=YES;
        firstNameTxt.text=contactVOS.DrFirstName;
        lastNameTxt.text=contactVOS.DrLastName;
        addressTxt.text=contactVOS.Address;
        cityTxt.text=contactVOS.City;
        stateTxt.text=contactVOS.State;
        countryTxt.text=contactVOS.Country;
        zipTxt.text=contactVOS.Zip;
        PhonenoTxt.text=contactVOS.PhNo;
        
        scrollView.contentSize=CGSizeMake(screenRect.size.width,heigth+100);
        
    }else{
        heigth=heigth+screenRect.size.height*0.08;
        
        updateBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.30,heigth,screenRect.size.width*0.40,screenRect.size.height*0.06)];
        updateBtn.layer.cornerRadius = 6.0f;
        [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        updateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //[updateBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
        [updateBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
        [scrollView addSubview:updateBtn];
        
        if ([editing isEqualToString:@"NO"]) {
            
            updateBtn.hidden=YES;
            firstNameTxt.text=contactVOS.DrFirstName;
            lastNameTxt.text=contactVOS.DrLastName;
            addressTxt.text=contactVOS.Address;
            cityTxt.text=contactVOS.City;
            stateTxt.text=contactVOS.State;
            countryTxt.text=contactVOS.Country;
            zipTxt.text=contactVOS.Zip;
            PhonenoTxt.text=contactVOS.PhNo;
            if ([contactVOS.BenefitType isEqualToString:@"Medical"] || [contactVOS.BenefitType isEqualToString:@"Dental"] || [contactVOS.BenefitType isEqualToString:@"Vision"]) {
                SpecialityTxt.enabled=YES;
            }else{
                SpecialityTxt.enabled=NO;

            }
            
            //check here condition if pharmacy then all fields are enabled.
            
            titleLabel.text=@"Update Provider Contacts";
            
            updateBtn.hidden=NO;
            [updateBtn setTitle:@"Update" forState:UIControlStateNormal];
            [updateBtn addTarget:self action:@selector(UpdateProfileAction:) forControlEvents:UIControlEventTouchUpInside];
            
            scrollView.contentSize=CGSizeMake(screenRect.size.width,heigth+100);
            
        }else{
            if ([BenefitTypeTxt.text isEqualToString:@""]) {
                SpecialityTxt.enabled=NO;
            }else{
                SpecialityTxt.enabled=YES;
            }
            stateTxt.text=selectedStrState;
            BenefitTypeTxt.text=selectedStrBenefit;
            if ([selectedStrBenefit isEqualToString:@"Pharmacy"]) {
             SpecialityTxt.text=@"";
                selectedStrspecility=@"";
            }else{
                SpecialityTxt.text=selectedStrspecility;
            }

            [updateBtn setTitle:@"Submit" forState:UIControlStateNormal];
            [updateBtn addTarget:self action:@selector(SubmitProfileAction:) forControlEvents:UIControlEventTouchUpInside];
            scrollView.contentSize=CGSizeMake(screenRect.size.width,heigth+100);
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
-(void)deleteData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/Contacts/DeleteContacts?ContactId=%@",contactVOS.ContactId];
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    NSError *error;
    if ([content isEqualToString:@"true"]) {
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Provider Contact deleted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        appDelegate.contactsubmitdeleteupdate=true;
    }else{
        [activityImageView removeFromSuperview];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(IBAction)deleteAction:(id)sender{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
    }else{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Are you sure you want to delete?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"]){
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        [self performSelector:@selector(deleteData) withObject:nil afterDelay:1.0 ];
    }
    
    if ([title isEqualToString:@"OK"]) {
//        ContactListViewController *contactList=[[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil];
        appDelegate.contact=NO;
//        [self.navigationController pushViewController:contactList animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(IBAction)editAction:(id)sender{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    scrollView.contentSize=CGSizeMake(screenRect.size.width,screenRect.size.height);
    firstNameTxt.enabled = YES;
    lastNameTxt.enabled = YES;
    addressTxt.enabled = YES;
    cityTxt.enabled = YES;
    stateTxt.enabled = YES;
    countryTxt.enabled = YES;
    zipTxt.enabled = YES;
    PhonenoTxt.enabled = YES;
    BenefitTypeTxt.enabled = YES;
    if ([BenefitTypeTxt.text isEqualToString:@"Medical"] || [BenefitTypeTxt.text isEqualToString:@"Dental"] || [BenefitTypeTxt.text isEqualToString:@"Vision"]) {
        SpecialityTxt.enabled=YES;
    }else{
        SpecialityTxt.enabled=NO;
        
    }
    titleLabel.text=@"Update Provider Contacts";

    updateBtn.hidden=NO;
    [updateBtn setTitle:@"Update" forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(UpdateProfileAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItems:nil animated:NO];

}

-(IBAction)SubmitProfileAction:(id)sender{
    [BenefitTypeTxt resignFirstResponder];
    [SpecialityTxt resignFirstResponder];
    [firstNameTxt resignFirstResponder];
    [lastNameTxt resignFirstResponder];
    [addressTxt resignFirstResponder];
    [cityTxt resignFirstResponder];
    [zipTxt resignFirstResponder];
    [PhonenoTxt resignFirstResponder];
    [stateTxt resignFirstResponder];
    [BenefitTypeTxt resignFirstResponder];
    [SpecialityTxt resignFirstResponder];
    
    if ([BenefitTypeTxt.text isEqualToString:@"Select Category"]) {
        BenefitTypeTxt.text=@"";
    }
    
    if ([SpecialityTxt.text isEqualToString:@"Select Speciality"]) {
        SpecialityTxt.text=@"";
    }

        Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
        NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
        if(myStatus == NotReachable)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityIndicator stopAnimating];
        }else{
           NSString *phno = [PhonenoTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *pinno=zipTxt.text;

            int length = [phno length];
            int lengthZip = [pinno length];
            if ([firstNameTxt.text isEqualToString:@""] || [PhonenoTxt.text isEqualToString:@""] || [BenefitTypeTxt.text isEqualToString:@""]) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Benefit, First name and Phone number are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }else
            if ([firstNameTxt.text isEqualToString:@""] || [PhonenoTxt.text isEqualToString:@""] ) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"First name and Phone number are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

            }else if ( [PhonenoTxt.text isEqualToString:@""]) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Phone number is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [PhonenoTxt becomeFirstResponder];

            }else if ( [firstNameTxt.text isEqualToString:@""]) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"First name is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [firstNameTxt becomeFirstResponder];

            }
            else{
                if (![PhonenoTxt.text isEqualToString:@""]) {
                    if(length == 12){
                        NSString* str = [PhonenoTxt.text stringByReplacingOccurrencesOfString:@"-" withString:@""];

                        if ([str rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                        {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            [PhonenoTxt becomeFirstResponder];
                        }else{
                            if (![zipTxt.text isEqualToString:@""]){
                                if (lengthZip == 5) {
                                    
                                    if ([zipTxt.text rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                                    {
                                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid zip code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                        [alert show];
                                        [zipTxt becomeFirstResponder];

                                    }else{

                                    [self submit];
                                    }
                                }else{
                                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid zip code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                    
                                    [zipTxt becomeFirstResponder];
                                }
                            }else{
                                [self submit];
                                
                            }

                        }
                        
                    }else{
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid Phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        [PhonenoTxt becomeFirstResponder];

                    }
                }
                else{
                    [self submit];
                }
            
            }
        }
}

-(void)submit{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    if ([BenefitTypeTxt.text isEqualToString:@"Pharmacy"]) {
        lastNameTxt.text=@"";
        SpecialityTxt.text=@"";
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/Contacts/InsertContacts?UserID=%@&LoginID=%@&SubscriberCode=%@&BenefitType=%@&DrFirstName=%@&DrLastName=%@&Address=%@&City=%@&State=%@&Zip=%@&Phno=%@&Speciality=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"],BenefitTypeTxt.text,firstNameTxt.text,lastNameTxt.text,addressTxt.text,cityTxt.text,stateTxt.text,zipTxt.text,PhonenoTxt.text,SpecialityTxt.text];
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    NSError *error;
    if (![content isEqualToString:@""]) {
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Provider Contact saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        appDelegate.contactsubmitdeleteupdate=true;

    }else{
        [activityImageView removeFromSuperview];

        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==PhonenoTxt){
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int length = [currentString length];
        if (length > 12) {
            return NO;
        }
        
    }
    int length = [self getLength:PhonenoTxt.text];
    if(length == 12) {
        if(range.length == 0)
            return NO;
    }
    if(length == 3){
        NSString *num = [self formatNumber:PhonenoTxt.text];
        PhonenoTxt.text = [NSString stringWithFormat:@"%@-",num];
        
        if(range.length > 0) {
            PhonenoTxt.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
            
        }
    } else if(length == 6) {
        NSString *num = [self formatNumber:PhonenoTxt.text];
        PhonenoTxt.text = [NSString stringWithFormat:@"%@-%@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        if(range.length > 0) {
            PhonenoTxt.text = [NSString stringWithFormat:@"%@-%@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    if(textField==zipTxt){

    if (zipTxt.text.length >= MAX_LENGTH && range.length == 0)
    {
        return NO; // return NO to not change text
    }
    else
    {return YES;}

    }
    return YES;
}


-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
    }
    return mobileNumber;
}
-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    
    return length;
}
-(void)update{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
    }else{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        if ([BenefitTypeTxt.text isEqualToString:@"Pharmacy"]) {
            lastNameTxt.text=@"";
            SpecialityTxt.text=@"";
        }

        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/Contacts/UpdateContacts?UserID=%@&LoginID=%@&SubscriberCode=%@&ContactId=%@&BenefitType=%@&DrFirstName=%@&DrLastName=%@&Address=%@&City=%@&State=%@&Zip=%@&Phno=%@&Speciality=%@",contactVOS.UserID,contactVOS.LoginID,contactVOS.SubscriberCode,contactVOS.ContactId,BenefitTypeTxt.text,firstNameTxt.text,lastNameTxt.text,addressTxt.text,cityTxt.text,stateTxt.text,zipTxt.text,PhonenoTxt.text,SpecialityTxt.text];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@"true"]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];

            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Provider Contact updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            appDelegate.contactsubmitdeleteupdate=true;

        }else{
            [activityImageView removeFromSuperview];

            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }

}
-(IBAction)UpdateProfileAction:(id)sender{
    
    [firstNameTxt resignFirstResponder];
    [lastNameTxt resignFirstResponder];
    [addressTxt resignFirstResponder];
    [cityTxt resignFirstResponder];
    [zipTxt resignFirstResponder];
    [PhonenoTxt resignFirstResponder];
    [stateTxt resignFirstResponder];
    [BenefitTypeTxt resignFirstResponder];
    [SpecialityTxt resignFirstResponder];
    NSString *phno=PhonenoTxt.text;
    NSString *pinno=zipTxt.text;
    
    
    if ([BenefitTypeTxt.text isEqualToString:@"Select Category"]) {
        BenefitTypeTxt.text=@"";
    }
    
    if ([SpecialityTxt.text isEqualToString:@"Select Speciality"]) {
        SpecialityTxt.text=@"";
    }

    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
    }else{
        NSString *phno = [PhonenoTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *pinno=zipTxt.text;
        
        int length = [phno length];
        int lengthZip = [pinno length];
        if ([firstNameTxt.text isEqualToString:@""] || [PhonenoTxt.text isEqualToString:@""] || [BenefitTypeTxt.text isEqualToString:@""]) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Benefit, First name and Phone number are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }else
            if ([firstNameTxt.text isEqualToString:@""] || [PhonenoTxt.text isEqualToString:@""] ) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"First name and Phone number are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }else if ( [PhonenoTxt.text isEqualToString:@""]) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Phone number is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [PhonenoTxt becomeFirstResponder];
                
            }else if ( [firstNameTxt.text isEqualToString:@""]) {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"First name is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [firstNameTxt becomeFirstResponder];
                
            }
            else{
                if (![PhonenoTxt.text isEqualToString:@""]) {
                    if(length == 12){
                        NSString* str = [PhonenoTxt.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        
                        if ([str rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                        {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        }else{
                            if (![zipTxt.text isEqualToString:@""]){
                                if (lengthZip == 5) {
                                    
                                    if ([zipTxt.text rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
                                    {
                                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid zip code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                        [alert show];
                                        [zipTxt becomeFirstResponder];

                                    }else{
                                        
                                        [self update];
                                    }
                                }else{
                                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid zip code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                    
                                    [zipTxt becomeFirstResponder];
                                }
                            }else{
                                [self update];
                                
                            }
                            
                        }
                        
                        
                        
                    }else{
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid Phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        [PhonenoTxt becomeFirstResponder];
                        
                    }
                }
                else{
                    [self update];
                }
                
            }
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if(textField==stateTxt)
    {
        
        selectedTxtfieldbenefit=NO;
        selectedTxtfieldstate=YES;
        selectedTxtfieldspeclaity=NO;
        benefitTypeArray=[[NSMutableArray alloc]initWithObjects:@"Alabama",@"Alaska",@"Arizona",@"Arkansas",@"California",@"Colorado" ,@"Connecticut",@"Delaware",@"Florida",@"Georgia",@"Hawaii",@"Idaho",@"Illinois",@"Iowa",@"Kansas",@"Kentucky",@"Louisiana",@"Maine",@"Maryland",@"Massachusetts",@"Michigan",@"Minnesota",@"Mississippi",@"Missouri",@"Montana Nebraska",@"Nevada",@"New Hampshire",@"New Jersey",@"New Mexico",@"New York",@"North Carolina",@"North Dakota",@"Ohio",@"Oklahoma",@"Oregon",@"Pennsylvania Rhode Island",@"South Carolina",@"South Dakota",@"Tennessee",@"Texas",@"Utah",@"Vermont",@"Virginia",@"Washington",@"West Virginia",@"Wisconsin",@"Wyoming",nil];

        [firstNameTxt resignFirstResponder];
        [lastNameTxt resignFirstResponder];
        [addressTxt resignFirstResponder];
        [cityTxt resignFirstResponder];
        [zipTxt resignFirstResponder];
        [PhonenoTxt resignFirstResponder];
        [stateTxt resignFirstResponder];
        [BenefitTypeTxt resignFirstResponder];
        [SpecialityTxt resignFirstResponder];
        toolbarstate.hidden=YES;
        statepickerview.hidden=YES;
        toolbarbenefit.hidden=YES;
        benefitpickerview.hidden=YES;
        toolbarspeciality.hidden=YES;
        specialitypickerview.hidden=YES;

        
        statepickerview = [[UIPickerView alloc] init];
        [statepickerview setDataSource: self];
        [statepickerview setDelegate: self];
        statepickerview.backgroundColor = [UIColor whiteColor];
        [statepickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        statepickerview.showsSelectionIndicator = YES;
        [statepickerview selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: statepickerview];
        statepickerview.hidden=NO;
        toolbarstate= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        [toolbarstate setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPresseds)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        toolbarstate.items = @[rightButton,flex,leftButton];
        [self.view addSubview:toolbarstate];
        
        toolbarstate.hidden=NO;
        [stateTxt resignFirstResponder];
        
        return NO;

    }
    else     if(textField==BenefitTypeTxt)
    {
        selectedTxtfieldbenefit=YES;
        selectedTxtfieldstate=NO;
        selectedTxtfieldspeclaity=NO;

        benefitTypeArray=[[NSMutableArray alloc]init];
        benefitTypeArray=mainbenefitarray;

        [firstNameTxt resignFirstResponder];
        [lastNameTxt resignFirstResponder];
        [addressTxt resignFirstResponder];
        [cityTxt resignFirstResponder];
        [zipTxt resignFirstResponder];
        [PhonenoTxt resignFirstResponder];
        [stateTxt resignFirstResponder];
        [BenefitTypeTxt resignFirstResponder];
        [SpecialityTxt resignFirstResponder];
        toolbarstate.hidden=YES;
        statepickerview.hidden=YES;
        toolbarbenefit.hidden=YES;
        benefitpickerview.hidden=YES;
        toolbarspeciality.hidden=YES;
        specialitypickerview.hidden=YES;
        
        
        benefitpickerview = [[UIPickerView alloc] init];
        [benefitpickerview setDataSource: self];
        [benefitpickerview setDelegate: self];
        benefitpickerview.backgroundColor = [UIColor whiteColor];
        [benefitpickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        benefitpickerview.showsSelectionIndicator = YES;
        [benefitpickerview selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: benefitpickerview];
        benefitpickerview.hidden=NO;
        toolbarbenefit= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        [toolbarbenefit setBarStyle:UIBarStyleBlackOpaque];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressedsBenefit)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                              forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];

        toolbarbenefit.items = @[rightButton,flex,leftButton];

        [self.view addSubview:toolbarbenefit];
        
        toolbarbenefit.hidden=NO;

        [BenefitTypeTxt resignFirstResponder];
        
        return NO;
    }else if(textField==SpecialityTxt)
    {
        selectedTxtfieldbenefit=NO;
        selectedTxtfieldstate=NO;
        selectedTxtfieldspeclaity=YES;

        if ([BenefitTypeTxt.text isEqualToString:@"Medical"]) {
            benefitTypeArray=[[NSMutableArray alloc]initWithObjects:@"Select Speciality",@"None",@"Acupuncture",@"Adolescent Medicine",@"Allergy and Immunology",@"Anesthesiology" ,@"Bariatric (Weight Loss) Surgery",@"Cancer Surgery",@"Cardiothoracic Surgery",@"Cardiovascular Disease",@"Cardiovascular Surgery",@"Colorectal Surgery",@"Critical Care Medicine",@"Dermatology",@"Dermatopathology",@"Electrophysiology",@"Emergency Medicine",@"Endocrinology, Diabetes and Metabolism",@"Family Medicine",@"Gastroenterology",@"Geriatric Medicine",@"Gynecologic Oncology",@"Gynecology (only)",@"Hand Surgery",@"Hematology",@"HIV Disease Specialist",@"Hospice and Palliative Medicine",@"Infectious Disease",@"Infertility",@"Internal Medicine",@"Interventional Cardiology",@"Lactation Consultant",@"Maternal and Fetal Medicine",@"Medical Genetics",@"Medical Oncology",@"Neonatal-Perinatal Medicine",@"Nephrology",@"Neuro-Oncology",@"Neurology",@"Neuropsychology",@"Neuroradiology",@"Neurosurgery",@"Nuclear Medicine",@"Nurse Midwife",@"Nurse Practitioner",@"Nurse Practitioner, Cardiology",@"Nurse Practitioner, Dermatology",@"Nurse Practitioner, Endocrinology",@"Nurse Practitioner, Family Practice",@"Nurse Practitioner, Gastroenterology",@"Nurse Practitioner, Gynecologic Oncology",@"Nurse Practitioner, Hematology (Blood)",@"Nurse Practitioner, Hospitalist",@"Nurse Practitioner, Internal Medicine",@"Nurse Practitioner, Neurosurgery",@"Nurse Practitioner, Obstetrics and Gynecology",@"Nurse Practitioner, Oncology (Cancer)",@"Nurse Practitioner, Orthopedics",@"Nurse Practitioner, Palliative Care",@"Nurse Practitioner, Pediatrics",@"Nurse Practitioner, Physical Medicine & Rehabilitation",@"Nurse Practitioner, Pulmonary Disease & Critical Care",@"Nurse Practitioner, Sports Medicine",@"Nurse Practitioner, Urgent Care",@"Obstetrics and Gynecology",@"Occupational Medicine",@"Ophthalmology",@"Optometrist",@"Oral and Maxillofacial Surgery",@"Orthopedic Surgery",@"Otolaryngology (ENT) - Head and Neck Surgery",@"Pain management",@"Pain Management",@"Pediatric Allergy and Immunology",@"Pediatric Cardiology",@"Pediatric Child Abuse and Neglect",@"Pediatric Critical Care",@"Pediatric Endocrinology",@"Pediatric Gastroenterology",@"Pediatric Hematology-Oncology",@"Pediatric Nephrology",@"Pediatric Neurology",@"Pediatric Neurosurgery",@"Pediatric Ophthalmology",@"Pediatric Orthopedics",@"Pediatric Otolaryngology",@"Pediatric Pulmonology",@"Pediatric Rehabilitation Medicine",@"Pediatric Rheumatology",@"Pediatric Surgery",@"Pediatric Urology",@"Pediatrics",@"Pediatrics - Developmental and Behavioral",@"Perinatology",@"Physical Medicine and Rehabilitation",@"Physician Assistant",@"Physician Assistant, Cardiac Surgery",@"Physician Assistant, Cardiology",@"Physician Assistant, Dermatology",@"Physician Assistant, Family Practice",@"Physician Assistant, Gastroenterology",@"Physician Assistant, General Surgery",@"Physician Assistant, Gynecologic Oncology",@"Physician Assistant, Internal Medicine",@"Physician Assistant, Nephrology",@"Physician Assistant, Neurosurgery",@"Physician Assistant, Obstetrics and Gynecology",@"Physician Assistant, Oncology (Cancer)",@"Physician Assistant, Orthopedics",@"Physician Assistant, Plastic Surgery",@"Physician Assistant, Sports Medicine",@"Physician Assistant, Urgent Care",@"Physician Assistant, Urology",@"Physician Assistant, Vascular Surgery",@"Plastic Surgery",@"Podiatry",@"Pulmonary Disease",@"Radiation Oncology",@"Reconstructive Surgery",@"Reproductive Endocrinology",@"Rheumatology",@"Sleep Medicine",@"Spine Surgery",@"Sports Medicine",@"Surgery",@"Thoracic Surgery",@"Undersea and Hyperbaric Medicine",@"Urogynecology",@"Urologic Oncology",@"Urology",@"Vascular Surgery",@"Weight Management (Medical, Non-Surgical)",nil];

        }else if ([BenefitTypeTxt.text isEqualToString:@"Dental"]){
            benefitTypeArray=[[NSMutableArray alloc]initWithObjects:@"Select Speciality",@"Any",@"General Dentist",@"Oral Surgeon",@"Endodontist",@"Orthodontist",@"Pediatric Dentist",@"Periodontist",@"Prosthodontist",@"Oral Pathologist",@"Public Health",@"Full Time Faculty",@"Oral Maxillofacial Radiologist",nil];

        }else if ([BenefitTypeTxt.text isEqualToString:@"Vision"]){
            benefitTypeArray=[[NSMutableArray alloc]initWithObjects:@"Select Speciality",@"None",@"Ophthalmology",@"Optometrist",@"Low Vision Specialist",@"Orthoptist",@"Optician",nil];
            
        }
        
        listView.hidden=true;
        islistviewVisible=false;

        [firstNameTxt resignFirstResponder];
        [lastNameTxt resignFirstResponder];
        [addressTxt resignFirstResponder];
        [cityTxt resignFirstResponder];
        [zipTxt resignFirstResponder];
        [PhonenoTxt resignFirstResponder];
        [stateTxt resignFirstResponder];
        [BenefitTypeTxt resignFirstResponder];
        [SpecialityTxt resignFirstResponder];
        
        toolbarstate.hidden=YES;
        statepickerview.hidden=YES;
        toolbarbenefit.hidden=YES;
        benefitpickerview.hidden=YES;
        toolbarspeciality.hidden=YES;
        specialitypickerview.hidden=YES;
        
        
        specialitypickerview = [[UIPickerView alloc] init];
        [specialitypickerview setDataSource: self];
        [specialitypickerview setDelegate: self];
        specialitypickerview.backgroundColor = [UIColor whiteColor];
        [specialitypickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
        specialitypickerview.showsSelectionIndicator = YES;
        [specialitypickerview selectRow:2 inComponent:0 animated:YES];
        [self.view addSubview: specialitypickerview];
        specialitypickerview.hidden=NO;
        toolbarspeciality= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
        [toolbarspeciality setBarStyle:UIBarStyleBlackOpaque];
        //[toolbarspeciality setBackgroundColor:[UIColor colorWithHexString:@""]];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPresseds)];
        [leftButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                  forState:UIControlStateNormal];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpress)];
        [rightButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
        
        toolbarspeciality.items = @[rightButton,flex,leftButton];
        [self.view addSubview:toolbarspeciality];
        
        toolbarspeciality.hidden=NO;

        [SpecialityTxt resignFirstResponder];
        
        return NO;
    }

    else{
        
        int tags=textField.tag;
        if (tags==1) {
            [self animateTextField:textField up:YES];

        }else if (tags==2) {
        [self animateTextField:textField up:YES];
            
        }
       else if (tags==3) {
            [self animateTextField:textField up:YES];

        }else
        if (tags==4){
            [self animateTextField:textField up:YES];
        }else if (tags==6){
            [self animateTextField:textField up:YES];
        }else if (tags==7){
            [self animateTextField:textField up:YES];
        }
    }
    listView.hidden=true;
    islistviewVisible=false;
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    toolbarbenefit.hidden=YES;
    benefitpickerview.hidden=YES;
    toolbarspeciality.hidden=YES;
    specialitypickerview.hidden=YES;

    return YES;
}
-(IBAction)doneBtnPresseds{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    toolbarbenefit.hidden=YES;
    benefitpickerview.hidden=YES;
    toolbarspeciality.hidden=YES;
    specialitypickerview.hidden=YES;

    if (selectedTxtfieldstate) {
        stateTxt.text=selectedStrState;
    }else if (selectedTxtfieldbenefit){
        BenefitTypeTxt.text=selectedStrBenefit;
        SpecialityTxt.text=@"";
    }else if(selectedTxtfieldspeclaity){
        SpecialityTxt.text=selectedStrspecility;
    }
    if ([BenefitTypeTxt.text isEqualToString:@"Medical"] || [BenefitTypeTxt.text isEqualToString:@"Dental"] || [BenefitTypeTxt.text isEqualToString:@"Vision"]) {
        SpecialityTxt.enabled=YES;
    }else{
        SpecialityTxt.enabled=NO;
    }
}
-(IBAction)doneBtnPressedsBenefit{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    toolbarbenefit.hidden=YES;
    benefitpickerview.hidden=YES;
    toolbarspeciality.hidden=YES;
    specialitypickerview.hidden=YES;
    
    BenefitTypeTxt.text=selectedStrBenefit;
    SpecialityTxt.text=@"";
    [self displayView];
    if ([BenefitTypeTxt.text isEqualToString:@"Medical"] || [BenefitTypeTxt.text isEqualToString:@"Dental"] || [BenefitTypeTxt.text isEqualToString:@"Vision"]) {
        SpecialityTxt.enabled=YES;
    }else{
        SpecialityTxt.enabled=NO;
    }
}

-(IBAction)cancelBtnpress{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    toolbarbenefit.hidden=YES;
    benefitpickerview.hidden=YES;
    toolbarspeciality.hidden=YES;
    specialitypickerview.hidden=YES;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: statepickerview]) {
        return [benefitTypeArray count];
    }
   else if ([pickerView isEqual: benefitpickerview]) {
        return [benefitTypeArray count];
   }else if ([pickerView isEqual: specialitypickerview]) {
       return [benefitTypeArray count];
   }
    else{
        return 0;
    }
}


// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    if (pickerView == benefitpickerview)
    {
        rowItem = [benefitTypeArray objectAtIndex: row];
        
    }
    if (pickerView == statepickerview)
    {
        rowItem = [benefitTypeArray objectAtIndex: row];
        
    }
    if (pickerView == specialitypickerview)
    {
        rowItem = [benefitTypeArray objectAtIndex: row];
        
    }

    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:UITextAlignmentCenter];
    [lblRow setTextColor: [UIColor blackColor]];
    [lblRow setText:rowItem];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    lblRow.font=fonts;
    [lblRow setBackgroundColor:[UIColor clearColor]];
    return lblRow;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView ==statepickerview)
    {
        selectedStrState=[[NSString alloc]init];
        selectedStrState=[NSString stringWithFormat:@"%@",[benefitTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==benefitpickerview)
    {
        selectedStrBenefit=[[NSString alloc]init];
        selectedStrBenefit=[NSString stringWithFormat:@"%@",[benefitTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]]];

    }if (pickerView ==specialitypickerview)
    {
        selectedStrspecility=[[NSString alloc]init];
        selectedStrspecility=[NSString stringWithFormat:@"%@",[benefitTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == statepickerview)
    {
        return [benefitTypeArray objectAtIndex:row];
        
    }
    if (pickerView == benefitpickerview)
    {
        return [benefitTypeArray objectAtIndex:row];
        
    }
    if (pickerView == specialitypickerview)
    {
        return [benefitTypeArray objectAtIndex:row];
        
    }

    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 300.0;
    
    return componentWidth;
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    int movementDistance=0;
    int tags=textField.tag;
    if (tags==1) {
       movementDistance = -5; // tweak as needed
    }else if (tags==2){
        movementDistance = -10; // tweak as needed
    }else if (tags==3){
        movementDistance = -50; // tweak as needed
    }else
    if (tags==4){
         movementDistance = -130; // tweak as needed
    }else if (tags==6){
        movementDistance = -210; // tweak as needed
    }else if (tags==7){
         movementDistance = -240; // tweak as needed
    }
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int tags=textField.tag;
    if (tags==1) {
        [self animateTextField:textField up:NO];
        
    }else if (tags==2) {
        [self animateTextField:textField up:NO];
        
    }
else if (tags==3) {
        [self animateTextField:textField up:NO];
        
    }else if (tags==4){
        [self animateTextField:textField up:NO];
    }else if (tags==6){
        [self animateTextField:textField up:NO];
    }else if (tags==7){
        [self animateTextField:textField up:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollViews
{
    if(scrollViews == btnscrollview){
        benefitScrollview.scrollEnabled = NO;
    }else{
        benefitScrollview.scrollEnabled = YES;
        listView.hidden=true;
        islistviewVisible=false;

    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollViewss
{
    if(scrollViewss == btnscrollview)
    {
        if(btnscrollview.contentOffset.x + btnscrollview.frame.size.width == btnscrollview.contentSize.width)
        {
            benefitScrollview.scrollEnabled = NO;
        }
        else
        {
            benefitScrollview.scrollEnabled = YES;
        }
    }else{
        listView.hidden=true;
        islistviewVisible=false;

    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    listView.hidden=true;
    islistviewVisible=false;

}
- (void)tapOnView:(UITapGestureRecognizer *)sender
{
    listView.hidden=true;
    islistviewVisible=false;
}

-(IBAction)doneBtnPressed:(UIButton *)button{
    int tags=button.tag;
    stateTxt.text=[benefitTypeArray objectAtIndex:tags];
    listView.hidden=true;
    islistviewVisible=false;
    scrollView.scrollEnabled=YES;

}
-(IBAction)doneBtnPressedBenefit:(UIButton *)button{
    int tags=button.tag;
    BenefitTypeTxt.text=[benefitTypeArray objectAtIndex:tags];
    if ([BenefitTypeTxt.text isEqualToString:@"Medical"] || [BenefitTypeTxt.text isEqualToString:@"Dental"] || [BenefitTypeTxt.text isEqualToString:@"Vision"]) {
        SpecialityTxt.enabled=YES;
    }else{
        SpecialityTxt.enabled=NO;

    }
    
    listView.hidden=true;
    islistviewVisible=false;
    scrollView.scrollEnabled=YES;
    
}
-(IBAction)doneBtnPressedSpeciality:(UIButton *)button{
    int tags=button.tag;
    SpecialityTxt.text=[benefitTypeArray objectAtIndex:tags];
    listView.hidden=true;
    islistviewVisible=false;
    scrollView.scrollEnabled=YES;
    
}

-(void)doneWithNumberPad{
    [zipTxt resignFirstResponder];
    [PhonenoTxt resignFirstResponder];
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
-(IBAction)CancelAction:(id)sender{
//    ContactListViewController *contactList=[[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil];
//    [self.navigationController pushViewController:contactList animated:YES];
    appDelegate.contact=YES;
    [self.navigationController popViewControllerAnimated:YES];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==firstNameTxt){
        [lastNameTxt becomeFirstResponder];
    }else if(textField==lastNameTxt){
        [addressTxt becomeFirstResponder];
    }else if(textField==addressTxt){
        [cityTxt becomeFirstResponder];
    }else if(textField==cityTxt){
        [cityTxt resignFirstResponder];
    }else if(textField==stateTxt){
        [zipTxt becomeFirstResponder];
    }else if(textField==zipTxt){
        [PhonenoTxt becomeFirstResponder];
    }else if(textField==PhonenoTxt){
        [PhonenoTxt resignFirstResponder];
    }
    return YES;
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
