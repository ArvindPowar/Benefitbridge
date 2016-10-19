//
//  SearchViewController.h
//  demo
//
//  Created by Infinitum on 02/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface SearchViewController : UIViewController<CLLocationManagerDelegate,UITextFieldDelegate>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSString *longitudeLabel,*latitudeLabel,*currentLocation;
@property (strong,nonatomic)IBOutlet  UIButton *SearchBtn,*nearMeBtn,*zipBtn,*pharmcayBtn,*draugBtn,*SearchBtn1;
@property(nonatomic,retain) UITextField *pharmacyNameTxt,*zipcodeTxt,*rediusTxt,*DrugsTxt;
@property(nonatomic,retain) UIToolbar* numberToolbar;
@property(strong,nonatomic) UISegmentedControl *segmentedControl;
@property(nonatomic,readwrite)int searchType;
@end
