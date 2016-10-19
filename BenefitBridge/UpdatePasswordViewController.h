//
//  UpdatePasswordViewController.h
//  demo
//
//  Created by Infinitum on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePasswordViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain)UILabel *oldpassLbl,*newpassLbl,*confirmpassLbl;
@property(nonatomic,retain)UITextField *oldTxt,*newsTxt,*confirmtxt;
@property(nonatomic,retain)UIButton *updateBtn,*cancelBtn;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
