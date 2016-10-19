//
//  BenefitDetailsViewController.h
//  demo
//
//  Created by Global Networking Resources on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "MYBenefitVO.h"
#import "AppDelegate.h"
@interface BenefitDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) IBOutlet UIView * firatview,*firstsecondView,*secondView,*BeneficiaryView;
@property(nonatomic,retain) IBOutlet AsyncImageView * bannerlogoImg;
@property(nonatomic,retain) IBOutlet UIButton * viewBtn,*updatecardBtn;
@property(nonatomic,retain) IBOutlet UILabel *groupnameLbl,*offLBl,*detectLbb,*converedLbl,*reletionLbl,*nameLbl,*reletionnameLbl,*covrageLbl,*covragedispLbl;
@property(nonatomic,retain) MYBenefitVO *myBeneVO;
@property(strong,nonatomic) NSString *tokenStr;
@property(strong,nonatomic) NSMutableArray *coveredRelestionArray,*ProductPlicyNumberArray,*BeneficiaryArray;
@property(nonatomic,readwrite) int HeightY;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UILabel *placenameLbl,*placenameLbl1,*descriptionLbl,*descriptionLbl1,*carrierLbl,*carrierLbl1,*policynoLbl,*policynoLbl1,*effectivedateLbl,*effectivedateLbl1;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(strong,nonatomic) NSMutableArray *inbenefitArray,*outbenefitArray,*commonArray,*otherArray,*attributenameArray,*indexarraycount;
@property(strong,nonatomic) NSString *productdiStr,*ProductNameStr,*ProductTypeDescriptionStr,*CarrierNameStr,*PolicyNumbeStr,*EffectiveDatStr,*dectiveValueStr;
@property(strong,nonatomic) UISegmentedControl *segmentedControl;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain) AppDelegate *appDelegate;

@end
