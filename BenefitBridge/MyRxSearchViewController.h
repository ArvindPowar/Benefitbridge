//
//  MyRxSearchViewController.h
//  BenefitBridge
//
//  Created by Infinitum on 29/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DosageVO.h"
@interface MyRxSearchViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (strong,nonatomic)IBOutlet  UIButton *SearchBtn;
@property(nonatomic,retain) UITextField *DrugsTxt;
@property(nonatomic,retain)DosageVO *dosageVO;
@property (strong,nonatomic)IBOutlet  UIButton *parweekBtn,*parmonthBtn,*asneededBtn,*submitBtn,*pardayBtnOne,*pardayBtntwo,*pardayBtnthree,*pardayBtnfour;
@property(nonatomic,retain) UIToolbar* numberToolbar;
@property(nonatomic,retain) UITextField * nooftabletTxt;
@property(nonatomic,retain)UILabel *msgLbl,*tabletnameLbl,*perdayLbl,*perweekLbl,*permonthLbl,*asneededLbl,*perdaytwoLbl,*perdaythreeLbl,*perdayfourLbl;
@property(nonatomic,retain)NSString *captionnameStr;
@property(nonatomic,retain)UIImageView *activityImageView;

@end
