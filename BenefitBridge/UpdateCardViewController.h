//
//  UpdateCardViewController.h
//  demo
//
//  Created by Global Networking Resources on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"
#import "MYBenefitVO.h"
#import "AppDelegate.h"
@interface UpdateCardViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,PECropViewControllerDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate>
{
    //ImageCropView* imageCropView;
    UIImage* image;
}

@property (strong,nonatomic)IBOutlet  UIButton *UpdateCardBtn;
@property (strong,nonatomic)IBOutlet  UIImageView *FrontImgVw,*testFrontimg;
@property (strong,nonatomic)IBOutlet  UIImageView *BackImgVw,*testBackImg;
//@property (nonatomic, strong) IBOutlet ImageCropView* imageCropView;
@property(nonatomic,retain) MYBenefitVO *myBenesVO;
@property (strong,nonatomic)IBOutlet  UIButton *BackBtn;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) NSString * forntimageByteStr,*BackimageByteStr,*forntimgName,*BackimgName;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIImage *imgfront,*imgBack;
-(IBAction)UpdateCardClick:(id)sender;
@property(nonatomic,retain)UILabel *msgLbl,*frontLbl,*backLbl;
@end
