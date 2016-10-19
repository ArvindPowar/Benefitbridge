//
//  SearchListViewController.m
//  demo
//
//  Created by Infinitum on 02/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "SearchListViewController.h"
#import "UIColor+Expanded.h"
#import "Reachability.h"
#import "MapViewController.h"
#import "PharmacyVO.h"
#import "PharmacyDetalisViewController.h"
#import "MapViewController.h"
#import "ContactVO.h"

#define foo4random() (1.0 * (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX)

#pragma mark - Private interface

@interface SearchListViewController ()
@property(nonatomic) double currentLong;
@property(nonatomic) double curretnlatit;

@property (nonatomic, strong)	NSArray			*colorSchemes;
@property (nonatomic, strong)	NSDictionary	*contents;
@property (nonatomic, strong)	id				currentPopTipViewTarget;
@property (nonatomic, strong)	NSDictionary	*titles;
@property (nonatomic, strong)	NSMutableArray	*visiblePopTipViews;
@end

@implementation SearchListViewController
@synthesize appDelegate,PharmacyArray,tableViewMain,activityImageView,filterAlertView,filterBtn,filterBtn1,filterBtn2,filterBtn3,filterBtn4,filterBtn5,filterBtn6,filterBtn7,filterBtn8,Has24hrServiceBool,HasCompoundingBool,HasDeliveryBool,HasDriveupBool,HasDurableEquipmentBool,HasEPrescriptionsBool,HasHandicapAccessBool,IsHomeInfusionBool,IsLongTermCareBool,longitude,latitude,tokenStr,zipCodeStr,rediusStr,filterArray,mainpharmacyArray,msgLbl,locationManager,currentLocation,annotation;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Pharmacy List";
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
    
    UIButton *RightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [RightBtn setFrame:CGRectMake(0, 0,40,40)];
    //[leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
    RightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [RightBtn addTarget:self action:@selector(FilterAction:) forControlEvents:UIControlEventTouchUpInside];
    [RightBtn setBackgroundImage:[UIImage imageNamed:@"Filter.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnr = [[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    RightBtn.titleLabel.font = font;
    [RightBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    [self.navigationItem setRightBarButtonItems:@[btnr] animated:NO];

    PharmacyArray=[[NSMutableArray alloc]init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,0,screenRect.size.width,screenRect.size.height);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    tableViewMain.separatorInset = UIEdgeInsetsZero;
    tableViewMain.layoutMargins = UIEdgeInsetsZero;
    [self.view addSubview:tableViewMain];

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

    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    [self performSelector:@selector(SearchData) withObject:nil afterDelay:1.0 ];

    self.visiblePopTipViews = [NSMutableArray array];
    

    self.contents = [NSDictionary dictionaryWithObjectsAndKeys:
                     // Rounded rect buttons
                     @"  24hr Service   ", [NSNumber numberWithInt:0],
                     @"  Compounding   ", [NSNumber numberWithInt:1],
                     @"  Delivery   ", [NSNumber numberWithInt:2],
                     @"  Driveup   ", [NSNumber numberWithInt:3],
                     @"  Durable Equipment   ", [NSNumber numberWithInt:4],
                     @"  E Prescriptions   ", [NSNumber numberWithInt:5],
                     @"  Handicap Access   ", [NSNumber numberWithInt:6],

                     nil];
    self.titles = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"Title", [NSNumber numberWithInt:14],
                   @"Auto Orientation", [NSNumber numberWithInt:12],
                   nil];
    
    // Array of (backgroundColor, textColor) pairs.
    // NSNull for either means leave as default.
    // A color scheme will be picked randomly per CMPopTipView.
    self.colorSchemes = [NSArray arrayWithObjects:
                         //[NSArray arrayWithObjects:[NSNull null], [NSNull null], nil],
                         //[NSArray arrayWithObjects:[UIColor colorWithRed:134.0/255.0 green:74.0/255.0 blue:110.0/255.0 alpha:1.0], [NSNull null], nil],
                         //[NSArray arrayWithObjects:[UIColor darkGrayColor], [NSNull null], nil],
                         [NSArray arrayWithObjects:[UIColor grayColor], [UIColor whiteColor], nil],
                         //[NSArray arrayWithObjects:[UIColor orangeColor], [UIColor blueColor], nil],
                         //[NSArray arrayWithObjects:[UIColor colorWithRed:220.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],[NSNull null], nil],
                         nil];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation=[locations lastObject];
    _curretnlatit=newLocation.coordinate.latitude;
    _currentLong=newLocation.coordinate.longitude;
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:_curretnlatit longitude:_currentLong] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSString *locality = [placemark name];
            NSLog(@"locality %@",locality);
//            if([placemark locality]!=nil)
//                currentLocation=[NSString stringWithFormat:@"%@",[placemark country]];
//            else
//                currentLocation=[NSString stringWithFormat:@"%@",[placemark country]];
            
            
            NSLog(@"appDelegate.currentlocation = %@",currentLocation);
            [locationManager stopUpdatingLocation];
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated{
}
- (IBAction)FilterAction:(id)sender
{
    filterAlertView = [[CustomIOS7AlertView alloc] init];
    [filterAlertView setContainerView:[self FiltermenuAlert]];
    [filterAlertView setDelegate:self];
    [filterAlertView setUseMotionEffects:true];
    [filterAlertView show];
}
-(UIView *)FiltermenuAlert{
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 450)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    [topButton setTitle:@"Filter Pharmacies having" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    [topButton setBackgroundColor:[UIColor clearColor]];
    [topButton setFont:[UIFont boldSystemFontOfSize:20]];
    [topButton setTitleColor:[UIColor colorWithHexString:@"03687f"] forState:UIControlStateNormal];
    [demoView addSubview:topButton];
    
    NSMutableArray *filterfieldArray=[[NSMutableArray alloc]init];
    filterfieldArray=[[NSMutableArray alloc]initWithObjects:@"24hr Service",@"Compounding",@"Delivery",@"Driveup",@"Durable Equipment",@"E Prescriptions",@"Handicap Access",nil];
    int hight=50;
    for (int count=0; count<[filterfieldArray count]; count++){
        UILabel* lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(5, hight,290,1)];
        [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
        [demoView addSubview:lineLbl];

       UILabel * NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(10,hight+2,230,48)];
        NameLbl.tag=3;
        NameLbl.font = [UIFont fontWithName:@"Open Sans" size:17];
        NameLbl.textColor=[UIColor blackColor];
        NameLbl.text=[filterfieldArray objectAtIndex:count];
        [demoView addSubview:NameLbl];
        
        if (count==0) {
            filterBtn=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
            [filterBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [filterBtn setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
            if (Has24hrServiceBool) {
                filterBtn.selected=YES;
            }
            filterBtn.layer.cornerRadius = 6.0f;
            [filterBtn setTag:count+1];
            [filterBtn addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [filterBtn setBackgroundColor:[UIColor clearColor]];
            [demoView addSubview:filterBtn];
        }else if (count==1){
            filterBtn1=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
            [filterBtn1 setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [filterBtn1 setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
            if (HasCompoundingBool) {
                filterBtn1.selected=YES;
            }
            filterBtn1.layer.cornerRadius = 6.0f;
            [filterBtn1 setTag:count+1];
            [filterBtn1 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [filterBtn1 setBackgroundColor:[UIColor clearColor]];
            [demoView addSubview:filterBtn1];

        }else if (count==2){
            filterBtn2=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
            [filterBtn2 setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [filterBtn2 setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
            if (HasDeliveryBool) {
                filterBtn2.selected=YES;
            }
            filterBtn2.layer.cornerRadius = 6.0f;
            [filterBtn2 setTag:count+1];
            [filterBtn2 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [filterBtn2 setBackgroundColor:[UIColor clearColor]];
            [demoView addSubview:filterBtn2];
            
        }else if (count==3){
            filterBtn3=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
            [filterBtn3 setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [filterBtn3 setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
            if (HasDriveupBool) {
                filterBtn3.selected=YES;
            }
            filterBtn3.layer.cornerRadius = 6.0f;
            [filterBtn3 setTag:count+1];
            [filterBtn3 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [filterBtn3 setBackgroundColor:[UIColor clearColor]];
            [demoView addSubview:filterBtn3];
            
        }else if (count==4){
            filterBtn4=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
            [filterBtn4 setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [filterBtn4 setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
            if (HasDurableEquipmentBool) {
                filterBtn4.selected=YES;
            }
            filterBtn4.layer.cornerRadius = 6.0f;
            [filterBtn4 setTag:count+1];
            [filterBtn4 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [filterBtn4 setBackgroundColor:[UIColor clearColor]];
            [demoView addSubview:filterBtn4];
            
        }else if (count==5){
            filterBtn5=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
            [filterBtn5 setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [filterBtn5 setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
            if (HasEPrescriptionsBool) {
                filterBtn5.selected=YES;
            }
            filterBtn5.layer.cornerRadius = 6.0f;
            [filterBtn5 setTag:count+1];
            [filterBtn5 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [filterBtn5 setBackgroundColor:[UIColor clearColor]];
            [demoView addSubview:filterBtn5];
            
        }else if (count==6){
            filterBtn6=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
            [filterBtn6 setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [filterBtn6 setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
            if (HasHandicapAccessBool) {
                filterBtn6.selected=YES;
            }
            filterBtn6.layer.cornerRadius = 6.0f;
            [filterBtn6 setTag:count+1];
            [filterBtn6 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [filterBtn6 setBackgroundColor:[UIColor clearColor]];
            [demoView addSubview:filterBtn6];
            
        }
//            else if (count==7){
//            filterBtn7=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
//            [filterBtn7 setBackgroundImage:[UIImage imageNamed:@"ic_check_box_outline_blank_white_2x.png"] forState:UIControlStateNormal];
//            [filterBtn7 setBackgroundImage:[UIImage imageNamed:@"ic_check_box_white_2x.png"] forState:UIControlStateSelected];
//            if (IsHomeInfusionBool) {
//                filterBtn7.selected=YES;
//            }
//            filterBtn7.layer.cornerRadius = 6.0f;
//            [filterBtn7 setTag:count+1];
//            [filterBtn7 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//            [filterBtn7 setBackgroundColor:[UIColor grayColor]];
//            [demoView addSubview:filterBtn7];
//            
//        }else if (count==8){
//            filterBtn8=[[UIButton alloc]initWithFrame:CGRectMake(250,hight+10,30,30)];
//            [filterBtn8 setBackgroundImage:[UIImage imageNamed:@"ic_check_box_outline_blank_white_2x.png"] forState:UIControlStateNormal];
//            [filterBtn8 setBackgroundImage:[UIImage imageNamed:@"ic_check_box_white_2x.png"] forState:UIControlStateSelected];
//            if (IsLongTermCareBool) {
//                filterBtn8.selected=YES;
//            }
//            filterBtn8.layer.cornerRadius = 6.0f;
//            [filterBtn8 setTag:count+1];
//            [filterBtn8 addTarget:self action:@selector(redioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//            [filterBtn8 setBackgroundColor:[UIColor grayColor]];
//            [demoView addSubview:filterBtn8];
//        }
        hight=hight+50;
    }
    
    UILabel* lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(5, hight,290,1)];
    [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
    [demoView addSubview:lineLbl];

    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,400,149,50)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [demoView addSubview:cancelBtn];
    
    UIButton *ApplyBtn=[[UIButton alloc] initWithFrame:CGRectMake(150,400,149,50)];
    [ApplyBtn setTitle:@"Apply" forState:UIControlStateNormal];
    [ApplyBtn addTarget:self
                  action:@selector(applyFilter:)
        forControlEvents:UIControlEventTouchUpInside];
    [ApplyBtn setBackgroundColor:[UIColor colorWithHexString:@"d08c2a"]];
    [ApplyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [demoView addSubview:ApplyBtn];

    return demoView;
}

-(IBAction)redioBtnAction:(id)sender{
    
    switch ([sender tag]) {
        case 1:
            if([filterBtn isSelected]==YES)
            {
                [filterBtn setSelected:NO];
            }
            else{
                [filterBtn setSelected:YES];
            }
            break;
        case 2:
            if([filterBtn1 isSelected]==YES)
            {
                [filterBtn1 setSelected:NO];
            }
            else{
                [filterBtn1 setSelected:YES];
             
            }
            break;
        case 3:
            if([filterBtn2 isSelected]==YES)
            {
                [filterBtn2 setSelected:NO];
            }
            else{
                [filterBtn2 setSelected:YES];
                
            }
            break;
        case 4:
            if([filterBtn3 isSelected]==YES)
            {
               
                [filterBtn3 setSelected:NO];
            }
            else{
                [filterBtn3 setSelected:YES];
                
            }
            break;
        case 5:
            if([filterBtn4 isSelected]==YES)
            {
                
                [filterBtn4 setSelected:NO];
            }
            else{
                [filterBtn4 setSelected:YES];
                
            }
            break;
        case 6:
            if([filterBtn5 isSelected]==YES)
            {
               
                [filterBtn5 setSelected:NO];
            }
            else{
                [filterBtn5 setSelected:YES];
                
            }
            break;
        case 7:
            if([filterBtn6 isSelected]==YES)
            {
                [filterBtn6 setSelected:NO];
            }
            else{
                [filterBtn6 setSelected:YES];
                
            }
            break;
    }
}

-(void)closeAlert:(id)sender{
    [filterAlertView close];
}
-(void)applyFilter:(id)sender{
    
    if (filterBtn.selected==YES) {
        Has24hrServiceBool=true;
    }else{
        Has24hrServiceBool=false;
    }
    if (filterBtn1.selected==YES) {
        HasCompoundingBool=true;
    }else{
        HasCompoundingBool=false;
     }
    if (filterBtn2.selected==YES) {
        HasDeliveryBool=true;
    }else{
        HasDeliveryBool=false;
    }
    if (filterBtn3.selected==YES) {
        HasDriveupBool=true;
    }else{
        HasDriveupBool=false;
    }
    if (filterBtn4.selected==YES) {
        HasDurableEquipmentBool=true;
    }else{
        HasDurableEquipmentBool=false;
    }
    if (filterBtn5.selected==YES) {
        HasEPrescriptionsBool=true;
    }else{
        HasEPrescriptionsBool=false;
    }
    if (filterBtn6.selected==YES) {
        HasHandicapAccessBool=true;
    }else{
        HasHandicapAccessBool=false;
    }

    if (Has24hrServiceBool==false && HasCompoundingBool==false && HasCompoundingBool==false && HasDriveupBool==false && HasDurableEquipmentBool==false && HasEPrescriptionsBool==false && HasHandicapAccessBool==false) {
        PharmacyArray=[[NSMutableArray alloc]init];
        for (int count=0; count<[mainpharmacyArray count]; count++) {
            PharmacyVO *pVOs=[mainpharmacyArray objectAtIndex:count];
            [PharmacyArray addObject:pVOs];
        }
        [filterAlertView close];
        [tableViewMain reloadData];

    }else{
        
    filterArray=[[NSMutableArray alloc]init];

    for (int count=0; count<[mainpharmacyArray count]; count++) {
        PharmacyVO *pVOs=[mainpharmacyArray objectAtIndex:count];
        [filterArray addObject:pVOs];
          }
    
        PharmacyArray=[[NSMutableArray alloc]init];
        
        for (int count=0; count<[filterArray count]; count++) {
            PharmacyVO *pVO=[filterArray objectAtIndex:count];
            if (Has24hrServiceBool) {
                if (pVO.Has24hrServiceBool==false) {
                    continue;
                }
            }
            
            if (HasCompoundingBool) {
                if (pVO.HasCompoundingBool==false) {
                    continue;
                }
            }

            if (HasDeliveryBool) {
                if (pVO.HasDeliveryBool==false) {
                    continue;
                }
            }

            if (HasDriveupBool) {
                if (pVO.HasDriveupBool==false) {
                    continue;
                }
            }

            if (HasDurableEquipmentBool) {
                if (pVO.HasDurableEquipmentBool==false) {
                    continue;
                }
            }

            if (HasEPrescriptionsBool) {
                if (pVO.HasEPrescriptionsBool==false) {
                    continue;
                }
            }

            if (HasHandicapAccessBool) {
                if (pVO.HasHandicapAccessBool==false) {
                    continue;
                }
            }
            [PharmacyArray addObject:pVO];
            
        }
    
    [filterAlertView close];
    [tableViewMain reloadData];
    }
    if ([PharmacyArray count]>0) {
        [msgLbl removeFromSuperview];
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        [msgLbl removeFromSuperview];
        msgLbl = [[UILabel alloc] init];
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.width*0.90, 35)];
        msgLbl.textAlignment = NSTextAlignmentCenter;
        //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
        msgLbl.text=@"No pharmacy found";
        [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        msgLbl.font=font1s;
        [self.view addSubview:msgLbl];
    }

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
        PharmacyArray=[[NSMutableArray alloc]init];
        mainpharmacyArray=[[NSMutableArray alloc]init];

        NSString *token=[NSString stringWithFormat:@"Bearer %@",tokenStr];
        NSError *error;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://192.168.0.192:9810/api/IdCard/UpdateImages"]];
        if ([zipCodeStr isEqualToString:@""] || zipCodeStr==nil) {
            NSString *lats=[NSString stringWithFormat:@"%f,%f",latitude,longitude];
            NSString *url=[NSString stringWithFormat:@"https://www.drxwebservices.com/APITools/v1/Pharmacies/Search?latlng=%@&radius=2",lats];
            [request setURL:[NSURL URLWithString:url]];
        }else{
            
            NSString *url=[NSString stringWithFormat:@"https://www.drxwebservices.com/APITools/v1/Pharmacies/Search?zip=%@&radius=2",zipCodeStr];
            [request setURL:[NSURL URLWithString:url]];
        }

        //        NSString *url=[NSString stringWithFormat:@"https://www.drxwebservices.com/APITools/v1/Drugs/41425"];
        //        [request setURL:[NSURL URLWithString:url]];
        
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
            NSString * msg = [userDict objectForKey:@"Message"];
            if (msg==nil) {
                NSArray *activityArray=[userDict objectForKey:@"PharmacyList"];
                for (int count=0; count<[activityArray count]; count++) {
                    NSDictionary *activityData=[activityArray objectAtIndex:count];
                    PharmacyVO *Pvo=[[PharmacyVO alloc] init];
                    Pvo.PharmacyID=[[NSString alloc] init];
                    Pvo.Name=[[NSString alloc] init];
                    Pvo.Address1=[[NSString alloc] init];
                    Pvo.Address2=[[NSString alloc] init];
                    Pvo.City=[[NSString alloc] init];
                    Pvo.State=[[NSString alloc] init];
                    Pvo.Zip=[[NSString alloc] init];
                    Pvo.Distance=[[NSString alloc] init];
                    Pvo.PharmacyPhone=[[NSString alloc] init];
                    Pvo.Latitude=[[NSString alloc] init];
                    Pvo.Longitude=[[NSString alloc] init];
                    Pvo.Chain=[[NSString alloc] init];
                    Pvo.ChainName=[[NSString alloc] init];

                    if ([activityData objectForKey:@"PharmacyID"] != [NSNull null])
                        Pvo.PharmacyID=[activityData objectForKey:@"PharmacyID"];
                    
                    if ([activityData objectForKey:@"Name"] != [NSNull null])
                        Pvo.Name=[activityData objectForKey:@"Name"];
                    
                    if ([activityData objectForKey:@"Address1"] != [NSNull null])
                        Pvo.Address1=[activityData objectForKey:@"Address1"];
                    
                    if ([activityData objectForKey:@"Address2"] != [NSNull null])
                        Pvo.Address2=[activityData objectForKey:@"Address2"];
                    
                    if ([activityData objectForKey:@"City"] != [NSNull null])
                        Pvo.City=[activityData objectForKey:@"City"];
                    
                    if ([activityData objectForKey:@"State"] != [NSNull null])
                        Pvo.State=[activityData objectForKey:@"State"];
                    
                    if ([activityData objectForKey:@"Zip"] != [NSNull null])
                        Pvo.Zip=[activityData objectForKey:@"Zip"];
                    
                    if ([activityData objectForKey:@"Distance"] != [NSNull null])
                        Pvo.Distance=[activityData objectForKey:@"Distance"];
                    
                    if ([activityData objectForKey:@"PharmacyPhone"] != [NSNull null])
                        Pvo.PharmacyPhone=[activityData objectForKey:@"PharmacyPhone"];
                    
                    if ([activityData objectForKey:@"Latitude"] != [NSNull null])
                        Pvo.Latitude=[activityData objectForKey:@"Latitude"];
                    
                    if ([activityData objectForKey:@"Longitude"] != [NSNull null])
                        Pvo.Longitude =[activityData objectForKey:@"Longitude"];
                    
                    if ([activityData objectForKey:@"Chain"] != [NSNull null])
                        Pvo.Chain=[activityData objectForKey:@"Chain"];
                    
                    if ([activityData objectForKey:@"ChainName"] != [NSNull null])
                        Pvo.ChainName=[activityData objectForKey:@"ChainName"];

                    NSDictionary *userDict1=[activityData objectForKey:@"PharmacyServices"];

                    if ([userDict1 objectForKey:@"Has24hrService"] != [NSNull null]){
                       NSString *test1 =[userDict1 objectForKey:@"Has24hrService"];
                        Pvo.Has24hrServiceBool=[test1 boolValue];
                    }
                    if ([userDict1 objectForKey:@"HasCompounding"] != [NSNull null]){
                        NSString *test1 =[userDict1 objectForKey:@"HasCompounding"];
                        Pvo.HasCompoundingBool=[test1 boolValue];
                    }
                    if ([userDict1 objectForKey:@"HasDelivery"] != [NSNull null]){
                        NSString *test1 =[userDict1 objectForKey:@"HasDelivery"];
                        Pvo.HasDeliveryBool=[test1 boolValue];
                    }
                    if ([userDict1 objectForKey:@"HasDriveup"] != [NSNull null]){
                        NSString *test1 =[userDict1 objectForKey:@"HasDriveup"];
                        Pvo.HasDriveupBool=[test1 boolValue];
                    }
                    if ([userDict1 objectForKey:@"HasDurableEquipment"] != [NSNull null]){
                        NSString *test1 =[userDict1 objectForKey:@"HasDurableEquipment"];
                        Pvo.HasDurableEquipmentBool=[test1 boolValue];
                    }
                    
                    if ([userDict1 objectForKey:@"HasEPrescriptions"] != [NSNull null]){
                        NSString *test1 =[userDict1 objectForKey:@"HasEPrescriptions"];
                        Pvo.HasEPrescriptionsBool=[test1 boolValue];
                    }
                    if ([userDict1 objectForKey:@"HasHandicapAccess"] != [NSNull null]){
                        NSString *test1 =[userDict1 objectForKey:@"HasHandicapAccess"];
                        Pvo.HasHandicapAccessBool=[test1 boolValue];
                    }
                    if ([userDict1 objectForKey:@"IsHomeInfusion"] != [NSNull null]){
                        NSString *test1 =[userDict1 objectForKey:@"IsHomeInfusion"];
                        Pvo.IsHomeInfusionBool=[test1 boolValue];
                    }
                    if ([userDict1 objectForKey:@"IsLongTermCare"] != [NSNull null]){
                        NSString *test1 =[userDict1 objectForKey:@"IsLongTermCare"];
                        Pvo.IsLongTermCareBool=[test1 boolValue];
                    }
                    [PharmacyArray addObject:Pvo];
                    [mainpharmacyArray addObject:Pvo];
                        }
                    }
            else{
                        if ([msg isEqualToString:@"The request to the authorization server is not in a valid format"]) {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Server problem please try some time later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
//change here alert message "service problem"
                        }else{
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            }
                        }
                        NSLog(@"Message %@",msg);
                    }
                if ([PharmacyArray count]>0) {
                    [msgLbl removeFromSuperview];
                }else{
                    CGRect screenRect = [[UIScreen mainScreen] bounds];
                    [msgLbl removeFromSuperview];
                    msgLbl = [[UILabel alloc] init];
                    [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.width*0.90, 35)];
                    msgLbl.textAlignment = NSTextAlignmentCenter;
                    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                    msgLbl.text=@"No pharmacy found";
                    [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                    msgLbl.font=font1s;
                    [self.view addSubview:msgLbl];
                }
                [activityImageView removeFromSuperview];
                [tableViewMain reloadData];
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

-(IBAction)CancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [PharmacyArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    PharmacyVO *pVOS=[PharmacyArray objectAtIndex:indexPath.row];
    NSString *name=[NSString stringWithFormat:@"%@",pVOS.Name];
    NSUInteger lengthch=[name length];
    if (pVOS.Has24hrServiceBool || pVOS.HasCompoundingBool || pVOS.HasDeliveryBool || pVOS.HasDriveupBool ||pVOS.HasDurableEquipmentBool || pVOS.HasEPrescriptionsBool || pVOS.HasHandicapAccessBool) {
        if (lengthch>34) {
            return screenRect.size.height*0.31;

        }else{
            return screenRect.size.height*0.28;

        }
    }else{
        if (lengthch>34) {
        return screenRect.size.height*0.21;
        }else{
            return screenRect.size.height*0.19;
  
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *NameLbl,*lineLbl,*address,*phoneNoLbl,*cityLbl,*distanceLbl;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView *backgroundView;
    PharmacyVO *pVOS=[PharmacyArray objectAtIndex:indexPath.row];
    NSString *name=[NSString stringWithFormat:@"%@",pVOS.Name];
    NSUInteger lengthch=[name length];

    if (pVOS.Has24hrServiceBool || pVOS.HasCompoundingBool || pVOS.HasDeliveryBool || pVOS.HasDriveupBool ||pVOS.HasDurableEquipmentBool || pVOS.HasEPrescriptionsBool || pVOS.HasHandicapAccessBool) {
        if (lengthch>34) {
        backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01, 2, screenRect.size.width*0.98, screenRect.size.height*0.30)];
            
            lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.305, screenRect.size.width*0.90,1)];

        }else{
            backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01, 2, screenRect.size.width*0.98, screenRect.size.height*0.27)];
            lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.275, screenRect.size.width*0.90,1)];

        }
    }else{
        if (lengthch>34) {
        backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01, 2, screenRect.size.width*0.98, screenRect.size.height*0.20)];
            lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.205, screenRect.size.width*0.90,1)];

        }else{
            backgroundView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.01, 2, screenRect.size.width*0.98, screenRect.size.height*0.18)];
            lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.185, screenRect.size.width*0.90,1)];

        }
    }
    [backgroundView setBackgroundColor:[UIColor colorWithHexString:@"f7f8f8"]];
    backgroundView.layer.cornerRadius=2.5f;
    backgroundView.layer.borderWidth=1.0f;
    backgroundView.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;
    //[cell.contentView addSubview:backgroundView];

    int hiegth=0;
    if (lengthch>34) {
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,0, screenRect.size.width*0.75, screenRect.size.height*0.08)];
        hiegth=screenRect.size.height*0.08;

    }else{
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,0, screenRect.size.width*0.75, screenRect.size.height*0.05)];
        hiegth=screenRect.size.height*0.05;

    }
    NameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    NameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    NameLbl.text=name;
    NameLbl.textAlignment = NSTextAlignmentLeft;
    NameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    NameLbl.numberOfLines = 0;
    [cell.contentView addSubview:NameLbl];
    
    distanceLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.80,0, screenRect.size.width*0.18, screenRect.size.height*0.05)];
    distanceLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    distanceLbl.textColor=[UIColor colorWithHexString:@"#851c2b"];
    NSString *distance=[NSString stringWithFormat:@"%.2f mi",[pVOS.Distance doubleValue]];
    distanceLbl.text=distance;
    distanceLbl.lineBreakMode = NSLineBreakByWordWrapping;
    distanceLbl.numberOfLines = 0;
    distanceLbl.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:distanceLbl];
    
    address=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hiegth, screenRect.size.width*0.90, screenRect.size.height*0.08)];
    address.font = [UIFont fontWithName:@"Open Sans" size:14];
    address.textColor=[UIColor blackColor];
    NSString * addressStr=[[NSString alloc]init];
    if ([pVOS.Address2 isEqualToString:@""] || pVOS.Address2==nil) {
        addressStr=[NSString stringWithFormat:@"%@\n%@, %@, %@",pVOS.Address1,pVOS.City,pVOS.State,pVOS.Zip];
    }else{
        addressStr=[NSString stringWithFormat:@"%@, %@\n%@, %@, %@",pVOS.Address1,pVOS.Address2,pVOS.City,pVOS.State,pVOS.Zip];
    }

    NSUInteger length=[addressStr length];
    NSMutableAttributedString *yourString = [[NSMutableAttributedString alloc] initWithString:addressStr];
    [yourString addAttribute:NSUnderlineStyleAttributeName
                       value:[NSNumber numberWithInt:1]
                       range:(NSRange){0,length}];

    address.attributedText=[yourString copy];
    address.textAlignment = NSTextAlignmentLeft;
    address.lineBreakMode = NSLineBreakByWordWrapping;
    address.numberOfLines = 0;
    [cell.contentView addSubview:address];
    
    UIButton *mapBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,hiegth, screenRect.size.width*0.90, screenRect.size.height*0.08)];
    [mapBtn addTarget:self
                 action:@selector(MapAction:)
       forControlEvents:UIControlEventTouchUpInside];
    mapBtn.tag=indexPath.row;
    [mapBtn setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:mapBtn];

    hiegth=hiegth+screenRect.size.height*0.08;
    
    phoneNoLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, hiegth, screenRect.size.width*0.40, screenRect.size.height*0.04)];
    phoneNoLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    phoneNoLbl.textColor=[UIColor colorWithHexString:@"#ce8b2a"];
    phoneNoLbl.text=pVOS.PharmacyPhone;
    phoneNoLbl.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:phoneNoLbl];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *mydatas = [[NSData alloc] init];
    mydatas=[prefs objectForKey:@"ContactList"];
    NSError *error;
    BOOL alredyContact=NO;
    if (mydatas !=nil) {
        NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydatas options:0 error:&error];
        NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
        for (int count=0; count<[userArray count]; count++) {
            
            NSDictionary *activityData=[userArray objectAtIndex:count];
            ContactVO *ContactVo=[[ContactVO alloc] init];
            ContactVo.PhNo=[[NSString alloc] init];
            if ([activityData objectForKey:@"PhNo"] != [NSNull null]){
                ContactVo.PhNo=[activityData objectForKey:@"PhNo"];
                NSString* Strr = [ContactVo.PhNo stringByReplacingOccurrencesOfString:@"-"   withString:@""];
                NSString* Strr1 = [pVOS.PharmacyPhone stringByReplacingOccurrencesOfString:@"-"   withString:@""];
                if ([Strr isEqualToString:Strr1]) {
                    alredyContact=YES;
                    break;
                }else{
                    alredyContact=NO;
                }
                
            }
        }
    }
    
    if (alredyContact==YES) {
        
    }else{
        UIButton *addpharmacycontactbtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.55,hiegth-5,35,35)];
        [addpharmacycontactbtn addTarget:self
                                  action:@selector(submitPharmacyContact:)
                        forControlEvents:UIControlEventTouchUpInside];
        [addpharmacycontactbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addpharmacycontactbtn.tag=indexPath.row;
        [addpharmacycontactbtn setBackgroundImage:[UIImage imageNamed:@"user_plus.png"]forState:UIControlStateNormal];
        [cell.contentView addSubview:addpharmacycontactbtn];

    }

    if (![pVOS.PharmacyPhone isEqualToString:@""] || pVOS.PharmacyPhone!=nil) {
        UIButton *phoneBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.45,hiegth,25,25)];
        [phoneBtn addTarget:self
                     action:@selector(CallBtn:)
           forControlEvents:UIControlEventTouchUpInside];
        [phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        phoneBtn.tag=indexPath.row;
        [phoneBtn setBackgroundImage:[UIImage imageNamed:@"fa-phone_60_10_03687f_none"]forState:UIControlStateNormal];
        [cell.contentView addSubview:phoneBtn];
    }
    
    hiegth=hiegth+screenRect.size.height*0.06;

    int yheight=screenRect.size.width*0.015;
    if (pVOS.Has24hrServiceBool) {
        UIButton *has24=[[UIButton alloc] initWithFrame:CGRectMake(yheight,hiegth, 40, 40)];
        [has24 setBackgroundImage:[UIImage imageNamed:@"24hr_Icon.png"] forState:UIControlStateNormal];
        [has24 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        has24.tag=0;
        [cell.contentView addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (pVOS.HasCompoundingBool) {
        UIButton *has24=[[UIButton alloc] initWithFrame:CGRectMake(yheight, hiegth, 40, 40)];
        [has24 setBackgroundImage:[UIImage imageNamed:@"Compunding_Icon.png"] forState:UIControlStateNormal];
        [has24 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        has24.tag=1;
        [cell.contentView addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (pVOS.HasDeliveryBool) {
        UIButton *has24=[[UIButton alloc] initWithFrame:CGRectMake(yheight, hiegth, 40, 40)];
        [has24 setBackgroundImage:[UIImage imageNamed:@"Delivery_Icon.png"] forState:UIControlStateNormal];
        [has24 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        has24.tag=2;
        [cell.contentView addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (pVOS.HasDriveupBool) {
        UIButton *has24=[[UIButton alloc] initWithFrame:CGRectMake(yheight, hiegth, 40, 40)];
        [has24 setBackgroundImage:[UIImage imageNamed:@"Driveup_Icon.png"] forState:UIControlStateNormal];
        [has24 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        has24.tag=3;
        [cell.contentView addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (pVOS.HasDurableEquipmentBool) {
        UIButton *has24=[[UIButton alloc] initWithFrame:CGRectMake(yheight, hiegth, 40, 40)];
        [has24 setBackgroundImage:[UIImage imageNamed:@"DurableEquipment_Icon.png"] forState:UIControlStateNormal];
        [has24 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        has24.tag=4;
        [cell.contentView addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (pVOS.HasEPrescriptionsBool) {
        UIButton *has24=[[UIButton alloc] initWithFrame:CGRectMake(yheight, hiegth, 40, 40)];
        [has24 setBackgroundImage:[UIImage imageNamed:@"e_Priscription_icon.png"] forState:UIControlStateNormal];
        [has24 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        has24.tag=5;
        [cell.contentView addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (pVOS.HasHandicapAccessBool) {
        UIButton *has24=[[UIButton alloc] initWithFrame:CGRectMake(yheight, hiegth, 40, 40)];
        [has24 setBackgroundImage:[UIImage imageNamed:@"Handicap_Icon.png"] forState:UIControlStateNormal];
        [has24 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        has24.tag=6;
        [cell.contentView addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }

    [lineLbl setBackgroundColor:[UIColor colorWithHexString:@"a6ccc6"]];
    [cell.contentView addSubview:lineLbl];
    
    tableView.backgroundColor=[UIColor clearColor];
    [cell setBackgroundColor:[UIColor clearColor]];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//   PharmacyDetalisViewController  *pharmacy=[[PharmacyDetalisViewController alloc] initWithNibName:@"PharmacyDetalisViewController" bundle:nil];
//    PharmacyVO* pharVO=[PharmacyArray objectAtIndex:indexPath.row];
//    pharmacy.phrVO=[[PharmacyVO alloc]init];
//    pharmacy.phrVO=pharVO;
//    [self.navigationController pushViewController:pharmacy animated:YES];
}

- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}

- (IBAction)buttonAction:(id)sender
{
    [self dismissAllPopTipViews];
    
    if (sender == self.currentPopTipViewTarget) {
        // Dismiss the popTipView and that is all
        self.currentPopTipViewTarget = nil;
    }
    else {
        NSString *contentMessage = nil;
        UIView *contentView = nil;
        NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
        id content = [self.contents objectForKey:key];
        if ([content isKindOfClass:[UIView class]]) {
            contentView = content;
        }
        else if ([content isKindOfClass:[NSString class]]) {
            contentMessage = content;
        }
        else {
            contentMessage = @"";
        }
        NSArray *colorScheme = [self.colorSchemes objectAtIndex:foo4random()*[self.colorSchemes count]];
        UIColor *backgroundColor = [UIColor grayColor];
        UIColor *textColor = [UIColor whiteColor];
        
        NSString *title = [self.titles objectForKey:key];
        
        CMPopTipView *popTipView;
        if (contentView) {
            popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
        }
        else if (title) {
            popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
        }
        else {
            popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
        }
        popTipView.delegate = self;
        
        if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
            popTipView.backgroundColor = backgroundColor;
        }
        if (textColor && ![textColor isEqual:[NSNull null]]) {
            popTipView.textColor = textColor;
        }
        
       // popTipView.animation = arc4random() % 2;
        popTipView.has3DStyle = (BOOL)(arc4random() % 2);
        
        popTipView.dismissTapAnywhere = YES;
        [popTipView autoDismissAnimated:YES atTimeInterval:3.0];
        
        if ([sender isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)sender;
            [popTipView presentPointingAtView:button inView:self.view animated:YES];
        }
        else {
            UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
            [popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
        }
        
        [self.visiblePopTipViews addObject:popTipView];
        self.currentPopTipViewTarget = sender;
    }
}
#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}


#pragma mark - UIViewController methods

- (void)willAnimateRotationToInterfaceOrientation:(__unused UIInterfaceOrientation)toInterfaceOrientation duration:(__unused NSTimeInterval)duration
{
    for (CMPopTipView *popTipView in self.visiblePopTipViews) {
        id targetObject = popTipView.targetObject;
        [popTipView dismissAnimated:NO];
        
        if ([targetObject isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)targetObject;
            [popTipView presentPointingAtView:button inView:self.view animated:NO];
        }
        else {
            UIBarButtonItem *barButtonItem = (UIBarButtonItem *)targetObject;
            [popTipView presentPointingAtBarButtonItem:barButtonItem animated:NO];
        }
    }
}

-(void)CallBtn:(UIButton *)Btn{
        PharmacyVO* pharVO=[PharmacyArray objectAtIndex:Btn.tag];

    NSString* Strr2 = [pharVO.PharmacyPhone stringByReplacingOccurrencesOfString:@"-"   withString:@""];
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
-(void)MapAction:(UIButton *)Btn{
//    MapViewController *map=[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
        PharmacyVO* pharVO=[PharmacyArray objectAtIndex:Btn.tag];
//        map.latiStr=[[NSString alloc]init];
//        map.longStr=[[NSString alloc]init];
//        map.pharmacynameStr=[[NSString alloc]init];
//        map.latiStr=pharVO.Latitude;
//        map.longStr=pharVO.Longitude;
//        map.currentLong=_currentLong;
//        map.curretnlatit=_curretnlatit;
//        map.pharmacynameStr=pharVO.Name;
//        [self.navigationController pushViewController:map animated:YES];
    if (appDelegate.locationAllow==NO) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Sorry, can't provide directions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
    NSString *googleMapUrlString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%f,%f&daddr=%f,%f", _curretnlatit, _currentLong, [pharVO.Latitude doubleValue], [pharVO.Longitude doubleValue]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapUrlString]];
    }
}


-(IBAction)OpenmapAction:(id)sender{
    MapViewController *map=[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [self.navigationController pushViewController:map animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)submitPharmacyContact:(UIButton *)Btn{
    PharmacyVO* pharVO=[PharmacyArray objectAtIndex:Btn.tag];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityImageView removeFromSuperview];
        
    }else{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        NSString * addressStr=[[NSString alloc]init];
        if ([pharVO.Address2 isEqualToString:@""] || pharVO.Address2==nil) {
            addressStr=[NSString stringWithFormat:@"%@",pharVO.Address1];
        }else{
            addressStr=[NSString stringWithFormat:@"%@, %@",pharVO.Address1,pharVO.Address2];
        }

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/Contacts/InsertContacts?UserID=%@&LoginID=%@&SubscriberCode=%@&BenefitType=%@&DrFirstName=%@&DrLastName=%@&Address=%@&City=%@&State=%@&Zip=%@&Phno=%@&Speciality=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"],@"Pharmacy",pharVO.Name,@"",addressStr,pharVO.City,pharVO.State,pharVO.Zip,pharVO.PharmacyPhone,@""];
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    if (![content isEqualToString:@""]) {
        
        [self getContactData];
        [tableViewMain reloadData];
    }else{
        [activityImageView removeFromSuperview];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    }
    
}
-(void)getContactData{
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
        NSData *mydata = [[NSData alloc] init];
        
            NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/Contacts/GetAllContacts?UserID=%@&LoginID=%@&SubscriberCode=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"]];
            mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            NSLog(@" User name : %@",[prefs objectForKey:@"username"]);
            
            NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                          length:[mydata length] encoding: NSUTF8StringEncoding];
            if ([content isEqualToString:@""]) {
                [activityImageView removeFromSuperview];
        }
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:mydata forKey:@"ContactList"];
            [prefsusername synchronize];
            
            [self getTokenData];
        
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
            [activityImageView removeFromSuperview];
            
        }else{
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            [prefsusername setObject:mydata forKey:@"ContactCode"];
            [prefsusername synchronize];
            
            [activityImageView removeFromSuperview];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Pharmacy Contact added successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }
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
