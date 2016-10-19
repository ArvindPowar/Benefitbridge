//
//  ForgotPassNextViewController.h
//  demo
//
//  Created by Infinitum on 11/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPassNextViewController : UIViewController
<UITextFieldDelegate>
@property(strong,nonatomic)IBOutlet UITextField *Usernametext;
@property(strong,nonatomic)IBOutlet UITextField *Passwordtext;
@property(strong,nonatomic)IBOutlet UITextField *ConfirmPasstext;
@property(strong,nonatomic)IBOutlet UITextField *EmailAddtext;

@property(strong,nonatomic)IBOutlet UIButton *GoBtn;
@property(strong,nonatomic)IBOutlet UIButton *CancelBtn;
@property(nonatomic,retain) UIImageView *logoImg;
@property(strong,nonatomic)IBOutlet UILabel *usernameLbl,*passwordLbl,*confirmLbl,*emailLbl;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
