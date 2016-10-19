//
//  ViewCardViewController.h
//  demo
//
//  Created by Global Networking Resources on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBenefitVO.h"
#import "AppDelegate.h"
@interface ViewCardViewController : UIViewController{
    
    
    BOOL isTapped;
}
@property (strong,nonatomic)  UIImage *FrontImg;
@property (strong,nonatomic)  UIImage *BackImg;
@property (strong,nonatomic)  NSString *ImgCheck;
@property (strong,nonatomic)  NSString *CheckId;

@property (strong,nonatomic)IBOutlet  UIButton *BackBtn;


@property (nonatomic, retain) IBOutlet UIScrollView *scrollFront,*scrollFrontLandscape;
@property (nonatomic, retain) IBOutlet UIImageView *BackImgVw1,*backimageview1landscape;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollBack,*scrollbackLandscape;
@property (nonatomic,retain ) IBOutlet UIImageView *BackImgVw,*backimagVwlandscape;
@property(nonatomic,retain) MYBenefitVO *myBenesVO;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(nonatomic,retain)UIImage *img,*img1;
@property(nonatomic,retain)UIImageView *activityImageView;
@property (strong,nonatomic)IBOutlet  UIButton *frontImgBtn;
@property (nonatomic, retain) IBOutlet UIImageView *frontimageView,*backimageview,*frontimageViewland,*backimageviewland;
@property(nonatomic,retain)UILabel *msgLbl, *backLbl,*frontLbl,*msgLbl1,*msgdeleLbl,*optionLbl,*optionLbl1;
@property(nonatomic,retain)UIButton *frontimageBtn,*backimageBtn,*frontimageBtnland,*backimageBtnland;
@property(nonatomic,retain) NSString *frontimageStr,*backimageStr;
@property(nonatomic,retain)NSString *frontImaStr,*BackImaStr;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIView *mainPortraitView;
@property(nonatomic,retain) IBOutlet UIView *mainLandscapeView;

-(IBAction)BackClick:(id)sender;


@end
