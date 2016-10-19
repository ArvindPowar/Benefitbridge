//
//  DrugsFirstListViewController.h
//  BenefitBridge
//
//  Created by Infinitum on 22/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "CMPopTipView.h"

@interface DrugsFirstListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CustomIOS7AlertViewDelegate,CLLocationManagerDelegate,CMPopTipViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSMutableArray *DrugsArray;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain)NSString * tokenStr,*searchStr;
@property(nonatomic,retain)UILabel *msgLbl;
@property (strong,nonatomic)IBOutlet  UIButton *SearchBtn;
@property(nonatomic,retain) UITextField *DrugsTxt;
@property(nonatomic,retain) UISearchBar *searchBar;

@end
