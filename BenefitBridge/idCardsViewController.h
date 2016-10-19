//
//  idCardsViewController.h
//  demo
//
//  Created by Infinitum on 13/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBenefitVO.h"
#import "AppDelegate.h"
@interface idCardsViewController : UIViewController{
    
    
    BOOL isTapped;
}
@property (strong,nonatomic)  UIImage *FrontImg;
@property (strong,nonatomic)  UIImage *BackImg;
@property (strong,nonatomic)  NSString *ImgCheck;
@property (strong,nonatomic)  NSString *CheckId;

@property (strong,nonatomic)IBOutlet  UIButton *BackBtn,*frontImgBtn;


@property (nonatomic, retain) IBOutlet UIScrollView *scrollFront;
@property (nonatomic, retain) IBOutlet UIImageView *BackImgVw1,*frontimageView,*backimageview;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollBack;
@property (nonatomic,retain ) IBOutlet UIImageView *BackImgVw;
@property(nonatomic,retain) MYBenefitVO *myBenesVO;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIImage *img,*img1;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain)UILabel *msgLbl,*msgLbl1, *backLbl,*frontLbl,*optionLbl,*optionLbl1,*msgdeleLbl;
@property(nonatomic,retain)UIButton *frontimageBtn,*backimageBtn, * dotLog,* dotLog1;
@property(nonatomic,retain) NSString *frontimageStr,*backimageStr;
@property(nonatomic,retain)NSString *frontImaStr,*BackImaStr;
-(IBAction)BackClick:(id)sender;


@end
