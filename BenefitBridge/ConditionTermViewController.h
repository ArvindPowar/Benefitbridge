//
//  ConditionTermViewController.h
//  demo
//
//  Created by Infinitum on 25/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ConditionTermViewController : UIViewController
@property(nonatomic,retain) UIImageView *logoImg;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(nonatomic,retain) UIButton *cancelBtn;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollview;

@end
