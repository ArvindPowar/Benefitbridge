//
//  MyProfileViewController.h
//  demo
//
//  Created by Infinitum on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MyProfileViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain)UILabel *firstnameLbl,*lastnameLbl,*emailLbl;
@property(nonatomic,retain)UITextField *firstnameTxt,*lastnameTxt,*emailtxt;
@property (nonatomic, retain)  UISwitch *fingerLogin,*offlineSwitch;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(strong,nonatomic) NSString *tokenStr,*idcardsYes;
@property(nonatomic,retain) NSMutableArray *myBenefitArray,*imgArray;
@property(nonatomic,retain)NSString *frontImaStr,*BackImaStr;
@property(nonatomic,retain) NSMutableArray *ContactListArray;
@property(nonatomic,retain) NSMutableArray*benefitTypeArray;

@end
