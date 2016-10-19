//
//  SearchViewController.m
//  demo
//
//  Created by Infinitum on 02/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "SearchViewController.h"
#import "MainViewController.h"
#import "UIColor+Expanded.h"
#import "SearchListViewController.h"
#import "DrugsFirstListViewController.h"
#define MAX_LENGTH 5

@interface SearchViewController ()
@property(nonatomic) double longitude;
@property(nonatomic) double latitude;

@end

@implementation SearchViewController{
    CLLocationManager *locationManager;
}

@synthesize appDelegate,longitudeLabel,latitudeLabel,currentLocation,longitude,latitude,SearchBtn,pharmacyNameTxt,zipcodeTxt,numberToolbar,nearMeBtn,zipBtn,rediusTxt,segmentedControl,searchType,pharmcayBtn,draugBtn,DrugsTxt,SearchBtn1;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Find Pharmacy";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    
    appDelegate.contactsubmitdeleteupdate=false;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
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

    pharmacyNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.20,screenRect.size.width*0.80,screenRect.size.height*0.06)];
    pharmacyNameTxt.font=font1;
    pharmacyNameTxt.textAlignment=NSTextAlignmentLeft;
    pharmacyNameTxt.delegate = self;
    pharmacyNameTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders6 = [CALayer layer];
    bottomBorders6.frame = CGRectMake(0.0f, pharmacyNameTxt.frame.size.height - 1, pharmacyNameTxt.frame.size.width, 1.0f);
    bottomBorders6.backgroundColor = [UIColor lightGrayColor].CGColor;
    [pharmacyNameTxt.layer addSublayer:bottomBorders6];
    UIView *paddingVie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    pharmacyNameTxt.leftView = paddingVie;
    pharmacyNameTxt.tag=5;
    pharmacyNameTxt.leftViewMode = UITextFieldViewModeAlways;
    self.pharmacyNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"State" attributes:@{NSForegroundColorAttributeName: color}];
    pharmacyNameTxt.returnKeyType=UIReturnKeyNext;
   // [self.view addSubview:pharmacyNameTxt];
    
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];

    /// hide this code start
//    pharmcayBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13,30,30)];
//    [pharmcayBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
//    [pharmcayBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
//    pharmcayBtn.layer.cornerRadius = 6.0f;
//    [pharmcayBtn setTag:1];
//    //[ownsettingBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
//    [pharmcayBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:pharmcayBtn];
//    pharmcayBtn.selected=YES;
//    
//    UILabel *firstnameLbl1= [[UILabel alloc] init];
//    [firstnameLbl1 setFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.13, screenRect.size.width*0.60, screenRect.size.height*0.04)];
//    firstnameLbl1.textAlignment = NSTextAlignmentLeft;
//    NSMutableAttributedString * stringss1 = [[NSMutableAttributedString alloc] initWithString:@"Pharmacy Search"];
//    [stringss1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,15)];
//    //[stringss1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
//    firstnameLbl1.attributedText=stringss1;
//    firstnameLbl1.font=fonts;
//    [self.view addSubview:firstnameLbl1];

    ///here end

    NSArray *itemArray;
    itemArray = [NSArray arrayWithObjects: @"Near me", @"Zip code", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.17, screenRect.size.width*0.90,35);
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor colorWithHexString:@"e8e8e7"];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"03687f"]} forState:UIControlStateSelected];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"434444"]} forState:UIControlStateDisabled];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"OpenSans-ExtraBold" size:13.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    
    [self.view addSubview:segmentedControl];
    searchType=0;

    zipcodeTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.27,screenRect.size.width*0.90,screenRect.size.height*0.06)];
    zipcodeTxt.font=font1;
    zipcodeTxt.textAlignment=NSTextAlignmentLeft;
    zipcodeTxt.delegate = self;
    zipcodeTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders7 = [CALayer layer];
    bottomBorders7.frame = CGRectMake(0.0f, zipcodeTxt.frame.size.height - 1, zipcodeTxt.frame.size.width, 1.0f);
    bottomBorders7.backgroundColor = [UIColor lightGrayColor].CGColor;
    [zipcodeTxt.layer addSublayer:bottomBorders7];
    UIView *paddingViewssss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    zipcodeTxt.leftView = paddingViewssss;
    zipcodeTxt.tag=6;
    [zipcodeTxt setTintColor:[UIColor lightGrayColor]];
    zipcodeTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * stringss = [[NSMutableAttributedString alloc] initWithString:@"zip code*"];
    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,8)];
    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8,1)];
    self.zipcodeTxt.attributedPlaceholder=stringss;
    [zipcodeTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackOpaque;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    numberToolbar.tintColor=[UIColor whiteColor];
    zipcodeTxt.inputAccessoryView = numberToolbar;
    zipcodeTxt.returnKeyType=UIReturnKeyNext;
    [self.view addSubview:zipcodeTxt];

    zipcodeTxt.hidden=YES;
    
    rediusTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.27,screenRect.size.width*0.40,screenRect.size.height*0.06)];
    rediusTxt.font=font1;
    rediusTxt.textAlignment=NSTextAlignmentLeft;
    rediusTxt.delegate = self;
    rediusTxt.textColor=[UIColor colorWithHexString:@"434444"];
    CALayer *bottomBorders1 = [CALayer layer];
    bottomBorders1.frame = CGRectMake(0.0f, rediusTxt.frame.size.height - 1, rediusTxt.frame.size.width, 1.0f);
    bottomBorders1.backgroundColor = [UIColor lightGrayColor].CGColor;
    [rediusTxt.layer addSublayer:bottomBorders1];
    UIView *paddingViews1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    rediusTxt.leftView = paddingViews1;
    rediusTxt.tag=6;
    [rediusTxt setTintColor:[UIColor lightGrayColor]];
    rediusTxt.leftViewMode = UITextFieldViewModeAlways;
    self.rediusTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Radius in miles" attributes:@{NSForegroundColorAttributeName: color}];
    [rediusTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackOpaque;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    numberToolbar.tintColor=[UIColor whiteColor];
    rediusTxt.inputAccessoryView = numberToolbar;
    rediusTxt.returnKeyType=UIReturnKeyNext;
   // [self.view addSubview:rediusTxt];

    UILabel *rediusLbl= [[UILabel alloc] init];
    [rediusLbl setFrame:CGRectMake(screenRect.size.width*0.55, screenRect.size.height*0.27, screenRect.size.width*0.35, screenRect.size.height*0.05)];
    rediusLbl.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString * stringss2 = [[NSMutableAttributedString alloc] initWithString:@"miles"];
    [stringss2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,5)];
    //[stringss1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
    rediusLbl.attributedText=stringss2;
    rediusLbl.font=fonts;
    //[self.view addSubview:rediusLbl];

    SearchBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30, screenRect.size.height*0.35, screenRect.size.width*0.40, screenRect.size.height*0.05)];
    [SearchBtn setBackgroundColor:[UIColor clearColor]];
    SearchBtn.layer.cornerRadius = 6.0f;
    [SearchBtn addTarget:self action:@selector(SearcgCardClick:) forControlEvents:UIControlEventTouchUpInside];
    [SearchBtn setTitle:@"Search" forState:UIControlStateNormal];
    [SearchBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [self.view addSubview:SearchBtn];

    
    ///hide this code drugs medicine
    
//    draugBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.50,30,30)];
//    [draugBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
//    [draugBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
//    draugBtn.layer.cornerRadius = 6.0f;
//    [draugBtn setTag:2];
//    //[ownsettingBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
//    [draugBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:draugBtn];
//    //
//    UILabel *zipLbl1= [[UILabel alloc] init];
//    [zipLbl1 setFrame:CGRectMake(screenRect.size.width*0.15, screenRect.size.height*0.50, screenRect.size.width*0.60, screenRect.size.height*0.04)];
//    zipLbl1.textAlignment = NSTextAlignmentLeft;
//    NSMutableAttributedString * strings = [[NSMutableAttributedString alloc] initWithString:@"Drugs Search"];
//    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,8)];
//    //[stringss1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
//    zipLbl1.attributedText=strings;
//    zipLbl1.font=fonts;
//    [self.view addSubview:zipLbl1];
//
//    DrugsTxt= [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.55,screenRect.size.width*0.80,screenRect.size.height*0.06)];
//    DrugsTxt.font=font1;
//    DrugsTxt.textAlignment=NSTextAlignmentLeft;
//    DrugsTxt.delegate = self;
//    DrugsTxt.textColor=[UIColor colorWithHexString:@"434444"];
//    CALayer *bottomBorders = [CALayer layer];
//    bottomBorders.frame = CGRectMake(0.0f, DrugsTxt.frame.size.height - 1, DrugsTxt.frame.size.width, 1.0f);
//    bottomBorders.backgroundColor = [UIColor lightGrayColor].CGColor;
//    [DrugsTxt.layer addSublayer:bottomBorders6];
//    UIView *paddingVied = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    DrugsTxt.leftView = paddingVied;
//    DrugsTxt.tag=6;
//    DrugsTxt.leftViewMode = UITextFieldViewModeAlways;
//    self.DrugsTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Drugs" attributes:@{NSForegroundColorAttributeName: color}];
//    DrugsTxt.returnKeyType=UIReturnKeyNext;
//     [self.view addSubview:DrugsTxt];
//    
//    SearchBtn1=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30, screenRect.size.height*0.65, screenRect.size.width*0.40, screenRect.size.height*0.05)];
//    [SearchBtn1 setBackgroundColor:[UIColor clearColor]];
//    SearchBtn1.layer.cornerRadius = 6.0f;
//    [SearchBtn1 addTarget:self action:@selector(SearcgDrugsClick:) forControlEvents:UIControlEventTouchUpInside];
//    [SearchBtn1 setTitle:@"Search" forState:UIControlStateNormal];
//    [SearchBtn1 setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
//    [self.view addSubview:SearchBtn1];

//end here
    
}
-(void)viewDidAppear:(BOOL)animated{
    locationManager = [[CLLocationManager alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if (appDelegate.locationAllow) {
        if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
            NSUInteger code = [CLLocationManager authorizationStatus];
            if (code==2) {
                appDelegate.locationAllow=NO;
            }
            if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                // choose one request according to your business.
                if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                    [locationManager requestAlwaysAuthorization];
                } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                    [locationManager  requestWhenInUseAuthorization];
                } else {
                    NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                }
            }
        }
        
        [locationManager startUpdatingLocation];
        
    }else{
        if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
            NSUInteger code = [CLLocationManager authorizationStatus];
            if (code==2) {
                appDelegate.locationAllow=NO;
                
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Service Disabled"
                //                                                                message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                //                                                               delegate:nil
                //                                                      cancelButtonTitle:@"OK"
                //                                                      otherButtonTitles:nil];
                //                [alert show];
                
            }else{
                if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
                    NSUInteger code = [CLLocationManager authorizationStatus];
                    if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                        // choose one request according to your business.
                        if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                            [locationManager requestAlwaysAuthorization];
                        } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                            [locationManager  requestWhenInUseAuthorization];
                        } else {
                            NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                        }
                    }
                }
                [locationManager startUpdatingLocation];
            }
        }
    }

}
-(IBAction)redioBtnAction:(id)sender{
    
    switch ([sender tag]) {
        case 1:
            if([pharmcayBtn isSelected]==YES)
            {
                [pharmcayBtn setSelected:NO];
                [draugBtn setSelected:NO];
            }
            else{
                [pharmcayBtn setSelected:YES];
                [draugBtn setSelected:NO];
            }
            break;
        case 2:
            if([draugBtn isSelected]==YES)
            {
                [draugBtn setSelected:NO];
                [pharmcayBtn setSelected:NO];
            }
            else{
                [draugBtn setSelected:YES];
                [pharmcayBtn setSelected:NO];
            }
            break;
    }
}

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        searchType=0;
        NSLog(@"Near me");
        zipcodeTxt.text=@"";
        zipcodeTxt.hidden=YES;

    }else if (segment.selectedSegmentIndex == 1){
        searchType=1;
        zipcodeTxt.hidden=NO;
        NSLog(@"Zip code");
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==zipcodeTxt){
        
        if (zipcodeTxt.text.length >= MAX_LENGTH && range.length == 0)
        {
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }

    }
    if(textField==rediusTxt){
        
        if (rediusTxt.text.length >= MAX_LENGTH && range.length == 0)
        {
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSArray  *arrayOfString = [newString componentsSeparatedByString:@"."];
        
        if ([arrayOfString count] > 2 )
            return NO;
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)SearcgDrugsClick:(id)sender{
    if (pharmcayBtn.selected==NO && draugBtn.selected==NO) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please select one option" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
 
    }else if(pharmcayBtn.selected==YES){
        
        
    }else if (draugBtn.selected==YES){
        if ([DrugsTxt.text isEqualToString:@""]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please fill data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }else{
        DrugsFirstListViewController *search=[[DrugsFirstListViewController alloc] initWithNibName:@"DrugsFirstListViewController" bundle:nil];
            search.searchStr=[[NSString alloc]init];
            search.searchStr=DrugsTxt.text;
        [self.navigationController pushViewController:search animated:YES];
        }
        
    }
}

-(IBAction)SearcgCardClick:(id)sender{
//    if (pharmcayBtn.selected==NO && draugBtn.selected==NO) {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please select one option" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        
//    }else if(pharmcayBtn.selected==YES){

    if (searchType==0) {
        if (appDelegate.locationAllow==NO) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Sorry, search not possible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }else{
            SearchListViewController *search=[[SearchListViewController alloc] initWithNibName:@"SearchListViewController" bundle:nil];
            search.longitude=longitude;
            search.latitude=latitude;
            search.rediusStr=rediusTxt.text;
        [self.navigationController pushViewController:search animated:YES];
        }
    }else{
        if ([zipcodeTxt.text isEqualToString:@""]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Zip code field is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [zipcodeTxt becomeFirstResponder];
        }
        else{
            NSString *pinno=zipcodeTxt.text;
            int lengthZip = [pinno length];

            if (lengthZip == 5) {
                SearchListViewController *search=[[SearchListViewController alloc] initWithNibName:@"SearchListViewController" bundle:nil];
                search.rediusStr=rediusTxt.text;
                search.zipCodeStr=zipcodeTxt.text;
                [self.navigationController pushViewController:search animated:YES];

            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid zip code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [zipcodeTxt becomeFirstResponder];

            }
            }
        }
    //}
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    appDelegate.locationAllow=YES;
    CLLocation *newLocation=[locations lastObject];
    latitude=newLocation.coordinate.latitude;
    longitude=newLocation.coordinate.longitude;
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSString *locality = [placemark name];
            NSLog(@"locality %@",locality);
            if([placemark locality]!=nil)
                currentLocation=[NSString stringWithFormat:@"%@",[placemark country]];
            else
                currentLocation=[NSString stringWithFormat:@"%@",[placemark country]];
            
            
            NSLog(@"appDelegate.currentlocation = %@",currentLocation);
            [locationManager stopUpdatingLocation];
        }
    }];
}
-(void)doneWithNumberPad{
    [zipcodeTxt resignFirstResponder];
    [pharmacyNameTxt resignFirstResponder];
    [rediusTxt resignFirstResponder];
}

-(IBAction)CancelAction:(id)sender{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:mainvc animated:YES];
}
-(IBAction)nearMeAction:(id)sender{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Your current mobile location" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"]){
        if (latitude==0 && longitude==0) {
            locationManager = [[CLLocationManager alloc] init];
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
                NSUInteger code = [CLLocationManager authorizationStatus];
                if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                    // choose one request according to your business.
                    if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                        [locationManager requestAlwaysAuthorization];
                    } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                        [locationManager  requestWhenInUseAuthorization];
                    } else {
                        NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                    }
                }
            }
            [locationManager startUpdatingLocation];

        }else{
            SearchListViewController *search=[[SearchListViewController alloc] initWithNibName:@"SearchListViewController" bundle:nil];
            search.longitude=longitude;
            search.latitude=latitude;
            [self.navigationController pushViewController:search animated:YES];
        }
    }
    
    if([title isEqualToString:@"Don't Allow"]){
       appDelegate.locationAllow=NO;
    }else{
        appDelegate.locationAllow=YES;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
