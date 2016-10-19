//
//  ContactListViewController.h
//  demo
//
//  Created by Infinitum on 13/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ContactListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSMutableArray *ContactListArray,*imgArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,retain) NSMutableArray*benefitTypeArray;
@property(nonatomic,readwrite) int index;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(strong,nonatomic) NSString *tokenStr,*idcardsYes;

@end
