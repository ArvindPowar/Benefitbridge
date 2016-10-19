//
//  DrugsDetalisViewController.h
//  BenefitBridge
//
//  Created by Infinitum on 22/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DrugFirstVO.h"
@interface DrugsDetalisViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,retain)NSString * drugIDStr;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)NSString * tokenStr,*searchStr,*tabletNameStr,*captionnameStr,*lableNameStr,*dosageIDStr;
@property(nonatomic,retain)UILabel *msgLbl,*tabletnameLbl,*perdayLbl,*perdaytwoLbl,*perdaythreeLbl,*perdayfourLbl,*perweekLbl,*permonthLbl,*asneededLbl;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain) NSMutableArray *DrugsDetailsArray;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,retain)DrugFirstVO* pharVO;
@property (strong,nonatomic)IBOutlet  UIButton *dosageBtn,*dosageBtn1,*dosageBtn2,*dosageBtn3,*dosageBtn4,*dosageBtn5,*dosageBtn6,*dosageBtn7,*dosageBtn8,*dosageBtn9,*dosageBtn10,*dosageBtn11,*dosageBtn12,*dosageBtn13,*dosageBtn14,*dosageBtn15,*dosageBtn16,*dosageBtn17,*dosageBtn18,*dosageBtn19,*dosageBtn20;
@property (strong,nonatomic)IBOutlet  UIButton *pardayBtnOne,*pardayBtntwo,*pardayBtnthree,*pardayBtnfour,*parweekBtn,*parmonthBtn,*asneededBtn,*submitBtn;
@property(nonatomic,retain) UIToolbar* numberToolbar;
@property(nonatomic,readwrite)int height;
@property(nonatomic,retain) UITextField * nooftabletTxt;
@property(nonatomic,retain) UIScrollView *scrollView;

@end
