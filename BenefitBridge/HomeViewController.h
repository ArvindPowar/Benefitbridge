//
//  HomeViewController.h
//  demo
//
//  Created by Infinitum on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSMutableArray *activityDetailsArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,retain) UIButton *mybenefitBtn,*idcardsBtn,*myRxBtn,*providercontactBtn,*findpharmacyBtn;

@end
