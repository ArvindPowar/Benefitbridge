//
//  ForgotpassViewController.h
//  demo
//
//  Created by Infinitum on 11/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotpassViewController : UIViewController<UITextFieldDelegate>
@property(strong,nonatomic)IBOutlet UITextField *FirstNametext;
@property(strong,nonatomic)IBOutlet UITextField *LastNametext;
@property(strong,nonatomic)IBOutlet UITextField *SSNtext;

@property(strong,nonatomic)IBOutlet UIButton *GoBtn;
@property(strong,nonatomic)IBOutlet UIButton *CancelBtn;
@property(nonatomic,retain) UIImageView *logoImg;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
