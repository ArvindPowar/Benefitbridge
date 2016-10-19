//
//  ViewController.h
//  demo
//
//  Created by Infinitum on 06/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController : UIViewController<UITextFieldDelegate,CustomIOS7AlertViewDelegate,UIAlertViewDelegate>
{
    LAContext *cont;
    IBOutlet UIButton *login_bt;
}


@property(nonatomic,retain)UIImageView *logoImg,*nameImg;
@property(nonatomic,retain)UIButton *submitBtn;
@property(nonatomic,retain)UITextField *keyText;
@property(strong,nonatomic)IBOutlet UIButton *CheckBtn;
@property(strong,nonatomic) NSString *tokenStr;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(nonatomic,retain)UIImageView *animatedImageView;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollview;
@property(nonatomic,retain) CustomIOS7AlertView *condtionAlertView;
@property(nonatomic,readwrite) int counter;

@end

