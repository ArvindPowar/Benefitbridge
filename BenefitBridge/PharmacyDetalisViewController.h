//
//  PharmacyDetalisViewController.h
//  BenefitBridge
//
//  Created by Infinitum on 04/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PharmacyVO.h"
#import "AppDelegate.h"

@interface PharmacyDetalisViewController : UIViewController
@property(nonatomic,retain) PharmacyVO *phrVO;
@property(nonatomic,retain) AppDelegate *appDelegate;

@end
