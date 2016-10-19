//
//  ContactViewController.h
//  demo
//
//  Created by Infinitum on 11/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactVO.h"
#import "AppDelegate.h"
@interface ContactViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,retain) UIImageView *logoImg;
@property(strong,nonatomic)IBOutlet UITextField *firstNameTxt,*lastNameTxt,*addressTxt,*cityTxt,*stateTxt,*countryTxt,*zipTxt,*PhonenoTxt,*BenefitTypeTxt,*SpecialityTxt;
@property(strong,nonatomic)IBOutlet UILabel *firstnameLbl,*lastnameLbl,*addressLbl,*cityLbl,*stateLbl,*countryLbl,*zipLbl,*phonenoLbl,*benefittypeLbl,*SpecialityLbl;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) UIPickerView *BenefitPickerView;
@property(nonatomic,retain)  UIToolbar *BenefitPickertoolbar;
@property(nonatomic,retain) NSMutableArray*benefitTypeArray,*mainbenefitarray,*tempArray;
@property(nonatomic,retain)NSString *editing,*selectedStrState,*selectedStrBenefit,*selectedStrspecility;
@property(nonatomic,retain) UIButton *updateBtn;
@property(nonatomic,retain) UIView *listView;
@property(nonatomic,retain) UIButton *listofBenefitBtn;
@property(nonatomic,retain) UIScrollView *benefitScrollview,*btnscrollview;
@property(nonatomic,readwrite) BOOL islistviewVisible,selectedTxtfieldbenefit,selectedTxtfieldstate,selectedTxtfieldspeclaity;
@property(nonatomic,retain) ContactVO *contactVOS;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain) UIToolbar* numberToolbar,*numberToolbarzip;
@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) IBOutlet UIPickerView *benefitpickerview,*specialitypickerview,*statepickerview;
@property(nonatomic,retain) IBOutlet UIToolbar *toolbarbenefit,*toolbarspeciality,*toolbarstate;
@property(nonatomic,readwrite)int heigth,heigth1;
@end
