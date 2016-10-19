//
//  MyRxViewController.h
//  BenefitBridge
//
//  Created by Infinitum on 28/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MyRxViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSMutableArray *mainArray;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,retain) UISearchBar *searchBar;
@property(nonatomic,retain)UILabel *msgLbl;
@property(nonatomic,retain)UIImageView *activityImageView;

@end
