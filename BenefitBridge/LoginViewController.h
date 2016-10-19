//
//  LoginViewController.h
//  demo
//
//  Created by Infinitum on 07/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    LAContext *cont;
    IBOutlet UIButton *login_bt;
}
@property(nonatomic,retain)UITextField *usernameTxt,*passwordTxt;
@property(nonatomic,retain) UIButton *goBtn,*cancelBtn,*forgotBtn;
@property(nonatomic,retain) UIImageView *logoImg;
@property(strong,nonatomic) NSString *tokenStr,*clientCodeToken;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,readwrite) int counter;
@property(nonatomic,retain)NSString *AbbreviatedClientCode;
@property (strong, nonatomic) UIWindow *window;

@end
