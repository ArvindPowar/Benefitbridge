//
//  IdCardsDetalisViewController.h
//  demo
//
//  Created by Infinitum on 16/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface IdCardsDetalisViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSMutableArray *myBenefitArray,*imgArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(strong,nonatomic) NSString *tokenStr,*idcardsYes;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain)UIButton *transperentBtn;
@property(nonatomic,retain)UIButton *transperentBtn2;
@end
