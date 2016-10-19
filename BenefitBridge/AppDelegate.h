//
//  AppDelegate.h
//  BenefitBridge
//
//  Created by Infinitum on 17/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <LocalAuthentication/LocalAuthentication.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LAContext *cont;
    IBOutlet UIButton *login_bt;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navController;
@property(nonatomic,retain)NSString * UrlStringId,*keytext,*currentlocation;
@property(nonatomic,readwrite)BOOL offline,contact,touchid;
@property(nonatomic,retain) NSMutableArray*benefitTypeArray;
@property(nonatomic,retain) NSMutableArray *ContactListArray;
@property(nonatomic,readwrite) int index,indexs,push,drugArrayindex;
@property (assign, nonatomic) BOOL shouldRotate,issingOut,contactsubmitdeleteupdate;
@property(nonatomic,readwrite) BOOL isLandscapeOK,backBool;
@property(nonatomic,readwrite) int counter;
@property(nonatomic,readwrite)BOOL locationAllow,drugAdd;
@property(nonatomic,retain) NSMutableArray *mainArray;


@end

