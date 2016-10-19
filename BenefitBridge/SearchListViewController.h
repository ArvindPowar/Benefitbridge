//
//  SearchListViewController.h
//  demo
//
//  Created by Infinitum on 02/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "CMPopTipView.h"

@interface SearchListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CustomIOS7AlertViewDelegate,CLLocationManagerDelegate,CMPopTipViewDelegate>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSMutableArray *PharmacyArray,*filterArray,*mainpharmacyArray;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain) CustomIOS7AlertView *filterAlertView;
@property(nonatomic,retain)UIButton *filterBtn,*filterBtn1,*filterBtn2,*filterBtn3,*filterBtn4,*filterBtn5,*filterBtn6,*filterBtn7,*filterBtn8;
@property(nonatomic,readwrite)BOOL Has24hrServiceBool,HasCompoundingBool,HasDeliveryBool,HasDriveupBool,HasDurableEquipmentBool,HasEPrescriptionsBool,HasHandicapAccessBool,IsHomeInfusionBool,IsLongTermCareBool;
@property(nonatomic) double longitude;
@property(nonatomic) double latitude;
@property(nonatomic,retain)NSString * tokenStr,*zipCodeStr,*rediusStr;
@property(nonatomic,retain)UILabel *msgLbl;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,readwrite) CLLocationCoordinate2D currentLocation;
@property(nonatomic,retain) MKPointAnnotation *annotation;

@end
