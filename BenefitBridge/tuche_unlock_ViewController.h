//
//  tuche_unlock_ViewController.h
//  demo
//
//  Created by Infinitum on 18/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "AppDelegate.h"

@interface tuche_unlock_ViewController : UIViewController<UIAlertViewDelegate>
{
    LAContext *cont;
    IBOutlet UIButton *login_bt;
}
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(nonatomic,retain)UIImageView *logoImg,*nameImg;
@property(nonatomic,retain) UIButton * FingurBtn;
@property(strong,nonatomic)IBOutlet UIButton *CheckBtn,*enterpasswordBtn;
@property(nonatomic,readwrite) int counter;
-(void)unlocked_succ;
@end
