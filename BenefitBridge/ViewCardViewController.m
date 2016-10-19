//
//  ViewCardViewController.m
//  demo
//
//  Created by Global Networking Resources on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "ViewCardViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIColor+Expanded.h"
#import "BenefitDetailsViewController.h"
#import "Reachability.h"
#import "ImgViewViewController.h"
#import "UpdateCardViewController.h"
#import <UIKit/UIKit.h>
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5

@interface ViewCardViewController (UtilityMethods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end
@interface ViewCardViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    BOOL CheckImg,selectfrontimag,selectbackimag,selectfrontimagland,selectbackimagland;
}
@end

@implementation ViewCardViewController
@synthesize scrollBack,scrollFront,BackImgVw,BackImgVw1,BackBtn,myBenesVO,activityIndicator,img,img1,activityImageView,frontImgBtn,frontimageView,backimageview,msgLbl, backLbl,frontLbl,frontimageBtn,backimageBtn,frontimageStr,backimageStr,frontImaStr,BackImaStr,appDelegate,mainLandscapeView,frontimageViewland,backimageviewland,frontimageBtnland,backimageBtnland,msgLbl1,
optionLbl,msgdeleLbl,optionLbl1;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];

    [activityIndicator stopAnimating];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110,50)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:[NSString stringWithFormat:@"View Cards\n%@",myBenesVO.Ins_Type]];
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
    titleLabel.font=font1;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.hidesBackButton = YES;

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(BackAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];


    // add gesture recognizers to the image view
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    [self.BackImgVw1 setTag:ZOOM_VIEW_TAG];
    
}

- (NSUInteger)supportedInterfaceOrientations
{
    appDelegate.isLandscapeOK=YES;
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}


-(void)viewDidAppear:(BOOL)animated{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        frontimageStr=@"";
        backimageStr=@"";

        dispatch_async(dispatch_get_main_queue(), ^(){
            if (img ==nil) {
                appDelegate.isLandscapeOK=YES;
                [self.navigationItem setRightBarButtonItems:@[] animated:NO];

                [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                [self getIDcardsData];
            }else{
                [activityIndicator stopAnimating];
            }
        });
    });
}


- (void)handleDoubleone:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms in
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    UIView *customView = gestureRecognizer.view;
    NSLog(@"customView.tag %ld",(long)customView.tag);
    if (customView.tag == 1) {
        if (selectfrontimag) {
            selectfrontimag=NO;
            [frontimageView setImage:[UIImage imageNamed:@""]];
            [frontimageView setBackgroundColor:[UIColor clearColor]];
            [frontimageBtn removeFromSuperview];
            frontimageStr=[[NSString alloc]init];
            
            if (!selectbackimag) {
                if (img1==nil) {
                    [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                    [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                    rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                    UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                    UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                    rightBtn.titleLabel.font = fontss;
                    [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                    [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
                    
                }else{
                    [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                }
            }
        }else{
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            selectfrontimag=YES;
            //[frontimageView setImage:[UIImage imageNamed:@"check_white.png"]];
            [frontimageView setBackgroundColor:[UIColor colorWithHexString:@"33b5e5"]];
            frontimageBtn= [[UIButton alloc] init];
            [frontimageBtn setFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.05,50, 50)];
            //frontimageBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"check_white.png"]];
            [frontimageBtn setBackgroundImage:[UIImage imageNamed:@"check_white.png"] forState:UIControlStateNormal];
            [self.frontimageView addSubview:self.frontimageBtn];
            
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtn setFrame:CGRectMake(0, 0,30,30)];
            //[rightBtn setTitle:@"Edit" forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn setBackgroundImage:[UIImage imageNamed:@"font-awesome_4-6-3_trash_60_10_851c2b_none.png"] forState:UIControlStateNormal];
            UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
            rightBtn.titleLabel.font = fontss;
            [rightBtn setTintColor:[self colorFromHexString:@"#03687f"]];
            [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
            
            frontimageStr=[NSString stringWithFormat:@"%@_%@_Frontimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
        }
    }else if (customView.tag == 2){
        if (selectbackimag) {
            selectbackimag=NO;
            [backimageview setImage:[UIImage imageNamed:@""]];
            [backimageview setBackgroundColor:[UIColor clearColor]];
            [backimageBtn removeFromSuperview];
            backimageStr=[[NSString alloc]init];
            if (!selectfrontimag) {
                if (img==nil) {
                    
                    [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                    [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                    rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                    UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                    UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                    rightBtn.titleLabel.font = fontss;
                    [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                    [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
                    
                }else{
                    [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                }
            }
            
        }else{
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            selectbackimag=YES;
            //[backimageview setImage:[UIImage imageNamed:@"check_white.png"]];
            [backimageview setBackgroundColor:[UIColor colorWithHexString:@"33b5e5"]];
            backimageBtn= [[UIButton alloc] init];
            [backimageBtn setFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.05,50, 50)];
            //frontimageBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"check_white.png"]];
            [backimageBtn setBackgroundImage:[UIImage imageNamed:@"check_white.png"] forState:UIControlStateNormal];
            [self.backimageview addSubview:self.backimageBtn];
            
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtn setFrame:CGRectMake(0, 0,30,30)];
            //[rightBtn setTitle:@"Edit" forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn setBackgroundImage:[UIImage imageNamed:@"font-awesome_4-6-3_trash_60_10_851c2b_none.png"] forState:UIControlStateNormal];
            UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
            rightBtn.titleLabel.font = fontss;
            [rightBtn setTintColor:[self colorFromHexString:@"#03687f"]];
            [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
            backimageStr=[NSString stringWithFormat:@"%@_%@_Backimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
            
        }
        
    }
}

-(void)deleteData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    if (frontimageStr==nil) {
        frontimageStr=@"";
    }
    if (backimageStr==nil) {
        backimageStr=@"";
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp//api/IdCard/DeleteImages?UserID=%@&LoginId=%@&SubscriberCode=%@&BenefitType=%@&FrontImageName=%@&BackImageName=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"],myBenesVO.Ins_Type,frontimageStr,backimageStr];
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    NSError *error;
    if ([content isEqualToString:@"true"]) {
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        if (selectfrontimag && selectbackimag) {
            [self.BackImgVw1 setImage:[UIImage imageNamed:@""]];
            [frontimageView setImage:[UIImage imageNamed:@""]];
            [frontimageView setBackgroundColor:[UIColor clearColor]];
            [frontimageBtn removeFromSuperview];
            [frontLbl removeFromSuperview];
            self.scrollFront.hidden=YES;
            frontImaStr=@"";
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *strBack=[NSString stringWithFormat:@"%@_%@_Backimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
            NSString *strfront=[NSString stringWithFormat:@"%@_%@_Frontimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:strfront];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:strBack];

            self.scrollBack.hidden=YES;
            [self.BackImgVw setImage:[UIImage imageNamed:@""]];
            [backimageview setImage:[UIImage imageNamed:@""]];
            [backimageview setBackgroundColor:[UIColor clearColor]];
            [backimageBtn removeFromSuperview];
            [backLbl removeFromSuperview];
            BackImaStr=@"";
            selectbackimag=NO;
            selectfrontimag=NO;
            img1=nil;
            img=nil;
            [msgLbl1 removeFromSuperview];
            [msgdeleLbl removeFromSuperview];
            [optionLbl removeFromSuperview];
            [optionLbl1 removeFromSuperview];

            
            [msgLbl removeFromSuperview];
            msgLbl = [[UILabel alloc] init];
            [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01, screenRect.size.width*0.90, 35)];
            msgLbl.textAlignment = NSTextAlignmentCenter;
            //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
            msgLbl.text=@"Image not available";
            msgLbl.lineBreakMode = NSLineBreakByWordWrapping;
            msgLbl.numberOfLines = 0;
            [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
            UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
            msgLbl.font=font1s;
            [self.view addSubview:msgLbl];
            
            UIImageView *plusimage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.72, screenRect.size.height*0.045, 30, 30)];
            [plusimage setImage:[UIImage imageNamed:@"add1.png"]];
            //[self.view addSubview:plusimage];
            
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtn setFrame:CGRectMake(0, 0,45,50)];
            [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
            rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
            //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
            UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
            rightBtn.titleLabel.font = fontss;
            [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
            [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
            
        }else if (selectfrontimag){
            [self.BackImgVw1 setImage:[UIImage imageNamed:@""]];
            [frontimageView setImage:[UIImage imageNamed:@""]];
            [frontimageView setBackgroundColor:[UIColor clearColor]];
            [frontimageBtn removeFromSuperview];
            [frontLbl removeFromSuperview];
            self.scrollFront.hidden=YES;
            frontImaStr=@"";
            selectfrontimag=NO;
            img=nil;
            [optionLbl removeFromSuperview];
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *strfront=[NSString stringWithFormat:@"%@_%@_Frontimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:strfront];
            if ([BackImaStr isEqualToString:@""] || BackImaStr==nil) {
                [msgLbl1 removeFromSuperview];
                [optionLbl removeFromSuperview];
                [msgdeleLbl removeFromSuperview];
                [optionLbl1 removeFromSuperview];

                [msgLbl removeFromSuperview];
                msgLbl = [[UILabel alloc] init];
                [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01, screenRect.size.width*0.90, 60)];
                msgLbl.textAlignment = NSTextAlignmentCenter;
                //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                msgLbl.text=@"Image not available";
                msgLbl.lineBreakMode = NSLineBreakByWordWrapping;
                msgLbl.numberOfLines = 0;
                [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                msgLbl.font=font1s;
                [self.view addSubview:msgLbl];
                
                UIImageView *plusimage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.72, screenRect.size.height*0.045, 30, 30)];
                [plusimage setImage:[UIImage imageNamed:@"add1.png"]];
                //[self.view addSubview:plusimage];
                
                UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                rightBtn.titleLabel.font = fontss;
                [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
            }else{
                [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
               // [rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                rightBtn.titleLabel.font = fontss;
                [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];

            }
        }
        else if (selectbackimag) {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *strBack=[NSString stringWithFormat:@"%@_%@_Backimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:strBack];

            self.scrollBack.hidden=YES;
            [self.BackImgVw setImage:[UIImage imageNamed:@""]];
            [backimageview setImage:[UIImage imageNamed:@""]];
            [backimageview setBackgroundColor:[UIColor clearColor]];
            [backimageBtn removeFromSuperview];
            [backLbl removeFromSuperview];
            BackImaStr=@"";
            selectbackimag=NO;
            img1=nil;
            [optionLbl1 removeFromSuperview];

            if ([frontImaStr isEqualToString:@""] || frontImaStr==nil) {
                [msgLbl1 removeFromSuperview];
                [optionLbl removeFromSuperview];
                [msgdeleLbl removeFromSuperview];
                [optionLbl1 removeFromSuperview];

                [msgLbl removeFromSuperview];
                msgLbl = [[UILabel alloc] init];
                [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01, screenRect.size.width*0.90, 60)];
                msgLbl.textAlignment = NSTextAlignmentCenter;
                //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                msgLbl.text=@"Image not available";
                msgLbl.lineBreakMode = NSLineBreakByWordWrapping;
                msgLbl.numberOfLines = 0;
                [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                msgLbl.font=font1s;
                [self.view addSubview:msgLbl];
                
                UIImageView *plusimage=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.72, screenRect.size.height*0.045, 30, 30)];
                [plusimage setImage:[UIImage imageNamed:@"add1.png"]];
                //[self.view addSubview:plusimage];
                
                UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                rightBtn.titleLabel.font = fontss;
                [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
                
            }else{
                [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                rightBtn.titleLabel.font = fontss;
                [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];

            }
        }
        if (NSClassFromString(@"UIAlertController") != Nil) // Yes, Nil
        {
            [activityImageView removeFromSuperview];

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"BenefitBridge" message:@"Image deleted successfully" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        [self dismissViewControllerAnimated:YES completion:nil];
                                                    }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [activityImageView removeFromSuperview];

        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Image deleted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        }
    }else{
        
        if (NSClassFromString(@"UIAlertController") != Nil) // Yes, Nil
    {
        [activityImageView removeFromSuperview];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"BenefitBridge" message:@"Internet Error" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction *action) {
                                                    [self dismissViewControllerAnimated:YES completion:nil];
                                                }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {

        [activityImageView removeFromSuperview];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    }
}
- (void) clearCurrentView
{
    if (mainLandscapeView.superview)
    {
        [mainLandscapeView removeFromSuperview];
    }
    else if (self.view.superview)
    {
        [self.view removeFromSuperview];
    }
}

-(void)viewDidLayoutSubviews{
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    if(self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height))){
        appDelegate.isLandscapeOK=YES;

        self.scrollFront.layer.frame=CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.15,screenRect.size.width*0.60,screenRect.size.height*0.30);
        
        self.BackImgVw1.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.45,screenRect.size.height*0.20);
        
        self.scrollBack.layer.frame=CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.50,screenRect.size.width*0.60,screenRect.size.height*0.30);
        
        self.BackImgVw.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.45,screenRect.size.height*0.20);

        self.frontimageView.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.45,screenRect.size.height*0.20);
        backimageview.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.45,screenRect.size.height*0.20);
        
        [frontimageBtn setFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.05,50, 50)];
        [backimageBtn setFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.05,50, 50)];
        
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13, screenRect.size.width*0.90, 35)];

        [msgdeleLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.93, screenRect.size.width*0.90, 30)];
        [msgLbl1 setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.90, screenRect.size.width*0.90, 35)];
        [frontLbl setFrame:CGRectMake(screenRect.size.width*0.10,0, screenRect.size.width*0.40, 25)];
        [backLbl setFrame:CGRectMake(screenRect.size.width*0.10,0, screenRect.size.width*0.40, 25)];
        
        [optionLbl setFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.25, screenRect.size.width*0.60,25)];
        [optionLbl1 setFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.25, screenRect.size.width*0.60,25)];
        }
        else{
            appDelegate.isLandscapeOK=NO;
            //isLandscape=YES;
            self.scrollFront.layer.frame=CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20,screenRect.size.width*0.40,screenRect.size.height*0.53);
            
            self.BackImgVw1.layer.frame=CGRectMake(0,screenRect.size.height*0.07,screenRect.size.width*0.40,screenRect.size.height*0.40);
            
            self.scrollBack.layer.frame=CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.20,screenRect.size.width*0.40,screenRect.size.height*0.53);

            self.BackImgVw.layer.frame=CGRectMake(0,screenRect.size.height*0.07,screenRect.size.width*0.40,screenRect.size.height*0.40);

            self.frontimageView.layer.frame=CGRectMake(0,screenRect.size.height*0.07,screenRect.size.width*0.40,screenRect.size.height*0.40);
            backimageview.layer.frame=CGRectMake(0,screenRect.size.height*0.07,screenRect.size.width*0.40,screenRect.size.height*0.40);
            
            [frontimageBtn setFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.09,50, 50)];
            [backimageBtn setFrame:CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.09,50, 50)];
            
            [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13, screenRect.size.width*0.90, 35)];

            [msgdeleLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.82, screenRect.size.width*0.90, 30)];
            [msgLbl1 setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.77, screenRect.size.width*0.90, 35)];
            [frontLbl setFrame:CGRectMake(0,0, screenRect.size.width*0.40, 25)];
            [backLbl setFrame:CGRectMake(0,0, screenRect.size.width*0.40, 25)];
            
            [optionLbl setFrame:CGRectMake(0,screenRect.size.height*0.465, screenRect.size.width*0.40,25)];
            [optionLbl1 setFrame:CGRectMake(0,screenRect.size.height*0.465, screenRect.size.width*0.40,25)];

        }
}
- (void)didPresentAlertView:(UIAlertView *)alertView
{
    // UIAlertView in landscape mode
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.1];
    alertView.transform = CGAffineTransformRotate(alertView.transform, 3.14159/2);
    [UIView commitAnimations];
}
-(IBAction)UpdatecardAction:(id)sender{
    UpdateCardViewController *updatecard=[[UpdateCardViewController alloc] initWithNibName:@"UpdateCardViewController" bundle:nil];
    updatecard.myBenesVO=myBenesVO;
    updatecard.imgfront=[[UIImage alloc]init];
    updatecard.imgBack=[[UIImage alloc]init];
    updatecard.imgfront=img;
    updatecard.imgBack=img1;
    img=nil;
    [self.navigationController pushViewController:updatecard animated:YES];
}

-(IBAction)deleteAction:(id)sender{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        NSString *title = @"BenefitBridge";
        NSString *message = @"No internet connection available";
        NSString *buttonTitle = @"OK";
        if (NSClassFromString(@"UIAlertController") != Nil) // Yes, Nil
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        [self dismissViewControllerAnimated:YES completion:nil];
                                                    }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:title
                                        message:message
                                       delegate:self
                              cancelButtonTitle:buttonTitle
                              otherButtonTitles:nil] show];
        }

//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
        [activityIndicator stopAnimating];
    }else{
        
        NSString *title = @"Warning";
        NSString *message = @"Are you sure that you want to delete this image ?";
        NSString *buttonTitle = @"YES";
        NSString *buttonTitle1 = @"NO";

        if (NSClassFromString(@"UIAlertController") != Nil) // Yes, Nil
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *deleteData) {                                                        [self dismissViewControllerAnimated:YES completion:nil];
                                                        [self deleteData];
                                                        NSLog(@"Yes action");

                                                    }]];
            
            [alert addAction: [UIAlertAction
                                       actionWithTitle:buttonTitle1
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *cancel)
                                       {
                                           NSLog(@"No action");
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                       }]];

            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:title
                                        message:message
                                       delegate:self
                              cancelButtonTitle:buttonTitle
                              otherButtonTitles:buttonTitle1] show];
        }

//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Are you sure that you want to delete this image ?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
//        [alert show];
    }
}

-(IBAction)cancel:(id)sender{
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"]){
        [self deleteData];
    }
    
}

- (void) threadStartAnimating:(id)data {
    UIImage *statusImage = [UIImage imageNamed:@"tmp-0.gif"];
    activityImageView = [[UIImageView alloc]
                         initWithImage:statusImage];
    
    [activityImageView setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
    activityImageView.layer.cornerRadius=8.0f;
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"tmp-0.gif"],
                                         [UIImage imageNamed:@"tmp-1.gif"],
                                         [UIImage imageNamed:@"tmp-2.gif"],
                                         [UIImage imageNamed:@"tmp-3.gif"],
                                         [UIImage imageNamed:@"tmp-4.gif"],
                                         [UIImage imageNamed:@"tmp-5.gif"],
                                         [UIImage imageNamed:@"tmp-6.gif"],
                                         [UIImage imageNamed:@"tmp-7.gif"],
                                         [UIImage imageNamed:@"tmp-8.gif"],
                                         [UIImage imageNamed:@"tmp-9.gif"],
                                         [UIImage imageNamed:@"tmp-10.gif"],
                                         [UIImage imageNamed:@"tmp-11.gif"],
                                         [UIImage imageNamed:@"tmp-12.gif"],
                                         [UIImage imageNamed:@"tmp-13.gif"],
                                         [UIImage imageNamed:@"tmp-14.gif"],
                                         [UIImage imageNamed:@"tmp-15.gif"],
                                         [UIImage imageNamed:@"tmp-16.gif"],
                                         [UIImage imageNamed:@"tmp-17.gif"],
                                         [UIImage imageNamed:@"tmp-18.gif"],
                                         [UIImage imageNamed:@"tmp-19.gif"],
                                         [UIImage imageNamed:@"tmp-20.gif"],
                                         [UIImage imageNamed:@"tmp-21.gif"],
                                         [UIImage imageNamed:@"tmp-22.gif"],
                                         [UIImage imageNamed:@"tmp-23.gif"],
                                         [UIImage imageNamed:@"tmp-24.gif"],
                                         [UIImage imageNamed:@"tmp-25.gif"],
                                         [UIImage imageNamed:@"tmp-26.gif"],
                                         [UIImage imageNamed:@"tmp-27.gif"],
                                         [UIImage imageNamed:@"tmp-28.gif"],
                                         [UIImage imageNamed:@"tmp-29.gif"],
                                         [UIImage imageNamed:@"tmp-30.gif"],
                                         [UIImage imageNamed:@"tmp-31.gif"],
                                         [UIImage imageNamed:@"tmp-32.gif"],
                                         [UIImage imageNamed:@"tmp-33.gif"],
                                         [UIImage imageNamed:@"tmp-34.gif"],
                                         [UIImage imageNamed:@"tmp-35.gif"],
                                         [UIImage imageNamed:@"tmp-36.gif"],
                                         [UIImage imageNamed:@"tmp-37.gif"],
                                         [UIImage imageNamed:@"tmp-38.gif"],
                                         [UIImage imageNamed:@"tmp-39.gif"],
                                         [UIImage imageNamed:@"tmp-40.gif"],
                                         [UIImage imageNamed:@"tmp-41.gif"],
                                         [UIImage imageNamed:@"tmp-42.gif"],
                                         [UIImage imageNamed:@"tmp-43.gif"],
                                         [UIImage imageNamed:@"tmp-44.gif"],
                                         [UIImage imageNamed:@"tmp-45.gif"],
                                         [UIImage imageNamed:@"tmp-46.gif"],
                                         [UIImage imageNamed:@"tmp-47.gif"],
                                         [UIImage imageNamed:@"tmp-48.gif"],
                                         [UIImage imageNamed:@"tmp-49.gif"],
                                         [UIImage imageNamed:@"tmp-50.gif"],
                                         [UIImage imageNamed:@"tmp-51.gif"],
                                         [UIImage imageNamed:@"tmp-52.gif"],
                                         [UIImage imageNamed:@"tmp-53.gif"],
                                         [UIImage imageNamed:@"tmp-54.gif"],
                                         [UIImage imageNamed:@"tmp-55.gif"],
                                         [UIImage imageNamed:@"tmp-56.gif"],
                                         [UIImage imageNamed:@"tmp-57.gif"],
                                         [UIImage imageNamed:@"tmp-58.gif"],
                                         [UIImage imageNamed:@"tmp-59.gif"], nil];
    
    activityImageView.animationDuration = 1.5;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    activityImageView.frame = CGRectMake(
                                         screenRect.size.width/2
                                         -35,
                                         screenRect.size.height/2
                                         -85,70,
                                         70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
}


-(void)getIDcardsData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];
        
    }else{
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/mobileapp/api/IDCard/GetAllIdCard?UserID=%@&LoginID=%@&SubscriberCode=%@&BenefitType=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"],myBenesVO.Ins_Type];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@" User name : %@",[prefs objectForKey:@"username"]);
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
            
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            [msgLbl1 removeFromSuperview];
            [optionLbl removeFromSuperview];
            [msgdeleLbl removeFromSuperview];
            [msgLbl removeFromSuperview];

            msgLbl = [[UILabel alloc] init];
            [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01, screenRect.size.width*0.90, 35)];
            msgLbl.textAlignment = NSTextAlignmentCenter;
            //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
            msgLbl.text=@"Image not available";
            [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
            UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
            msgLbl.font=font1s;
            [self.view addSubview:msgLbl];
            
            [self.navigationItem setRightBarButtonItems:@[] animated:NO];
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtn setFrame:CGRectMake(0, 0,45,50)];
            [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
            rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
            //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
            UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
            rightBtn.titleLabel.font = fontss;
            [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
            [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];

        }else{
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            if ([userArray count]>0) {
                
                NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
                NSDictionary *activityData=[userArray objectAtIndex:0];
                
                frontImaStr=[[NSString alloc]init];
                BackImaStr=[[NSString alloc]init];
                if ([activityData objectForKey:@"IdCardFront"] != [NSNull null])
                    frontImaStr=[activityData objectForKey:@"IdCardFront"];
                
                if ([activityData objectForKey:@"IdCardBack"] != [NSNull null])
                    BackImaStr=[activityData objectForKey:@"IdCardBack"];
                CGRect screenRect = [[UIScreen mainScreen] bounds];
                
                if (![frontImaStr isEqualToString:@""] && frontImaStr!=nil) {
                    
                    
                            self.scrollFront=[[UIScrollView alloc]init];
                            self.scrollFront.layer.frame=CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.15,screenRect.size.width*0.70,screenRect.size.height*0.30);
                            [self.scrollFront removeFromSuperview];
                            [self.view addSubview:self.scrollFront];
                    
                    [BackImgVw1 removeFromSuperview];
                            self.BackImgVw1 =[[UIImageView alloc]init];
                            self.BackImgVw1.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.50,screenRect.size.height*0.20);
                            [self.BackImgVw1 removeFromSuperview];
                            [self.scrollFront addSubview:self.BackImgVw1];

                    
                            self.scrollBack=[[UIScrollView alloc]init];
                            self.scrollBack.layer.frame=CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.50,screenRect.size.width*0.70,screenRect.size.height*0.30);
                            [self.scrollBack removeFromSuperview];
                            [self.view addSubview:self.scrollBack];
                    
                        [BackImgVw removeFromSuperview];
                            self.BackImgVw =[[UIImageView alloc]init];
                            self.BackImgVw.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.50,screenRect.size.height*0.20);
                            [self.BackImgVw removeFromSuperview];
                            [self.scrollBack addSubview:self.BackImgVw];

                    

                    self.BackBtn.layer.cornerRadius=10.0f;
                    self.scrollBack.userInteractionEnabled = YES;
                    self.scrollBack.maximumZoomScale = 3.0f;
                    self.scrollBack.minimumZoomScale = 1.0f;
                    self.scrollFront.tag = 1;
                    self.scrollBack.tag = 2;
                    

                    NSData *nsdatafrontBase64String = [[NSData alloc] initWithBase64EncodedString:frontImaStr options:0];
                    NSString *mode=[prefs objectForKey:@"mode"];
                    if ([mode isEqualToString:@"offline"]) {
                    NSString * forntimgName=[NSString stringWithFormat:@"%@_%@_Frontimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
                    [[NSUserDefaults standardUserDefaults] setObject:nsdatafrontBase64String forKey:forntimgName];
                    }
                    self.scrollFront.hidden=NO;

                    img = [UIImage imageWithData: nsdatafrontBase64String];
                    self.BackImgVw1.contentMode = UIViewContentModeScaleAspectFit;
                    self.BackImgVw1.image=img;
                    

                    [frontLbl removeFromSuperview];
                    frontLbl = [[UILabel alloc] init];
                    [frontLbl setFrame:CGRectMake(screenRect.size.width*0.10,0, screenRect.size.width*0.50, 25)];
                    frontLbl.textAlignment = NSTextAlignmentCenter;
                    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                    frontLbl.text=@"Card image - Front";
                    [frontLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                    frontLbl.font=[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                    [self.scrollFront addSubview:frontLbl];
                    
                    [optionLbl removeFromSuperview];
                    optionLbl = [[UILabel alloc] init];
                    [optionLbl setFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.25, screenRect.size.width*0.60,25)];
                    optionLbl.textAlignment = NSTextAlignmentCenter;
                    optionLbl.lineBreakMode = NSLineBreakByWordWrapping;
                    optionLbl.numberOfLines = 0;
                    [optionLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                    optionLbl.text=@"Double tap image to zoom";
                    optionLbl.font = [UIFont fontWithName:@"Open Sans" size:13.0];
                    [self.scrollFront addSubview:optionLbl];

                    frontimageView=[[UIImageView alloc]init];
                    self.frontimageView.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.50,screenRect.size.height*0.20);
                    [self.frontimageView removeFromSuperview];
                    frontimageView.alpha = 0.5; //Alpha runs from 0.0 to 1.0
                    [self.scrollFront addSubview:self.frontimageView];
                    self.frontimageView.contentMode = UIViewContentModeScaleAspectFit;
                    

                    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
                    [doubleTap setNumberOfTapsRequired:2];
                    [self.scrollFront addGestureRecognizer:doubleTap];
                    

                    UITapGestureRecognizer *doubleTapone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleone:)];
                    [doubleTapone setNumberOfTapsRequired:1];
                    [self.scrollFront addGestureRecognizer:doubleTapone];
                    

                    [doubleTapone requireGestureRecognizerToFail:doubleTap];

                    
                    if (![BackImaStr isEqualToString:@""] && BackImaStr!=nil) {
                        NSData *nsdataBackBase64String = [[NSData alloc] initWithBase64EncodedString:BackImaStr options:0];
                        NSString *mode=[prefs objectForKey:@"mode"];
                        if ([mode isEqualToString:@"offline"]) {
                        NSString *  BackimgName=[NSString stringWithFormat:@"%@_%@_Backimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
                        [[NSUserDefaults standardUserDefaults] setObject:nsdataBackBase64String forKey:BackimgName];
                        }
                        self.scrollBack.hidden=NO;

                        img1 = [UIImage imageWithData: nsdataBackBase64String];
                        self.BackImgVw.contentMode = UIViewContentModeScaleAspectFit;
                        self.BackImgVw.image=img1;

                        backimageview=[[UIImageView alloc]init];
                        backimageview.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.50,screenRect.size.height*0.20);
                        [backimageview removeFromSuperview];
                        backimageview.alpha = 0.5; //Alpha runs from 0.0 to 1.0
                        [self.scrollBack addSubview:backimageview];
                        self.backimageview.contentMode = UIViewContentModeScaleAspectFit;

                        [backLbl removeFromSuperview];
                        backLbl = [[UILabel alloc] init];
                        [backLbl setFrame:CGRectMake(screenRect.size.width*0.10,0, screenRect.size.width*0.50, 25)];
                        backLbl.textAlignment = NSTextAlignmentCenter;
                        //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                        backLbl.text=@"Card image - Back";
                        [backLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                        backLbl.font=[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                        [self.scrollBack addSubview:backLbl];
                        
                        [optionLbl1 removeFromSuperview];
                        optionLbl1 = [[UILabel alloc] init];
                        [optionLbl1 setFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.25, screenRect.size.width*0.60,25)];
                        optionLbl1.textAlignment = NSTextAlignmentCenter;
                        optionLbl1.lineBreakMode = NSLineBreakByWordWrapping;
                        optionLbl1.numberOfLines = 0;
                        [optionLbl1 setTextColor: [self colorFromHexString:@"#03687f"]];
                        optionLbl1.text=@"Double tap image to zoom";
                        optionLbl1.font = [UIFont fontWithName:@"Open Sans" size:13.0];
                        [self.scrollBack addSubview:optionLbl1];

                        UITapGestureRecognizer *doubleTapback = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
                        [doubleTapback setNumberOfTapsRequired:2];
                        [self.scrollBack addGestureRecognizer:doubleTapback];
                        
                        UITapGestureRecognizer *doubleTapbackone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleone:)];
                        [doubleTapbackone setNumberOfTapsRequired:1];
                        [self.scrollBack addGestureRecognizer:doubleTapbackone];
                        

                        [doubleTapbackone requireGestureRecognizerToFail:doubleTapback];

                    }else{
                        [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                        [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                        [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                        rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                        [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                        //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                        UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                        UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                        rightBtn.titleLabel.font = fontss;
                        [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                        [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
                        
                    }
                    
                    CGRect screenRect = [[UIScreen mainScreen] bounds];
                    
                    
                    [msgLbl removeFromSuperview];
                    [msgdeleLbl removeFromSuperview];
                    msgdeleLbl = [[UILabel alloc] init];
                    [msgdeleLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.83, screenRect.size.width*0.90, 30)];
                    msgdeleLbl.textAlignment = NSTextAlignmentLeft;
                    msgdeleLbl.lineBreakMode = NSLineBreakByWordWrapping;
                    msgdeleLbl.numberOfLines = 0;
                    [msgdeleLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                    //NSString *str=@"\uf111";
                    NSString *str=@"";
                    NSString *str1=@"Tap to select, press ";
                    NSString *str2=@"\uf1f8";
                    NSString *str3=@" to delete image";
                    UIFont *ArialFont = [UIFont fontWithName:@"FontAwesome" size:9.0];
                    NSDictionary *arialdict = [NSDictionary dictionaryWithObject: ArialFont forKey:NSFontAttributeName];
                    NSMutableAttributedString *AattrString = [[NSMutableAttributedString alloc] initWithString:str attributes: arialdict];
                    UIFont *VerdanaFont = [UIFont fontWithName:@"Open Sans" size:12.0];
                    NSDictionary *veradnadict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:NSFontAttributeName];
                    NSMutableAttributedString *VattrString = [[NSMutableAttributedString alloc]initWithString: str1 attributes:veradnadict];
                    UIFont *ArialFont1 = [UIFont fontWithName:@"FontAwesome" size:15.0];
                    NSDictionary *arialdict1 = [NSDictionary dictionaryWithObject: ArialFont1 forKey:NSFontAttributeName];
                    NSMutableAttributedString *AattrString1 = [[NSMutableAttributedString alloc] initWithString:str2 attributes: arialdict1];
                    UIFont *ArialFont2 = [UIFont fontWithName:@"Open Sans" size:12.0];
                    NSDictionary *arialdict2 = [NSDictionary dictionaryWithObject: ArialFont2 forKey:NSFontAttributeName];
                    NSMutableAttributedString *AattrString2 = [[NSMutableAttributedString alloc] initWithString:str3 attributes: arialdict2];
                    [AattrString appendAttributedString:VattrString];
                    [AattrString appendAttributedString:AattrString1];
                    [AattrString appendAttributedString:AattrString2];
                    msgdeleLbl.attributedText = AattrString;
                    [self.view addSubview:msgdeleLbl];
                    
                    [msgLbl1 removeFromSuperview];
                    msgLbl1 = [[UILabel alloc] init];
                    [msgLbl1 setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.80, screenRect.size.width*0.90, 35)];
                    msgLbl1.textAlignment = NSTextAlignmentLeft;
                    msgLbl1.lineBreakMode = NSLineBreakByWordWrapping;
                    msgLbl1.numberOfLines = 0;
                    [msgLbl1 setTextColor: [self colorFromHexString:@"#03687f"]];
                    NSString *str4=@"";
                    NSString *str5=@"Other options:";
                    UIFont *ArialFont4 = [UIFont fontWithName:@"FontAwesome" size:9.0];
                    NSDictionary *arialdict5 = [NSDictionary dictionaryWithObject: ArialFont4 forKey:NSFontAttributeName];
                    NSMutableAttributedString *AattrString5 = [[NSMutableAttributedString alloc] initWithString:str4 attributes: arialdict5];
                    UIFont *VerdanaFont5 = [UIFont fontWithName:@"Open Sans" size:12.0];
                    NSDictionary *veradnadict5 = [NSDictionary dictionaryWithObject:VerdanaFont5 forKey:NSFontAttributeName];
                    NSMutableAttributedString *VattrString5 = [[NSMutableAttributedString alloc]initWithString: str5 attributes:veradnadict5];
                    //[AattrString5 appendAttributedString:VattrString5];
                    msgLbl1.attributedText = VattrString5;
                    [self.view addSubview:msgLbl1];
                    
                    
                }
                else if (![BackImaStr isEqualToString:@""] && BackImaStr!=nil) {
                    NSData *nsdataBackBase64String = [[NSData alloc] initWithBase64EncodedString:BackImaStr options:0];
                    NSString *mode=[prefs objectForKey:@"mode"];
                    if ([mode isEqualToString:@"offline"]) {
                        NSString *  BackimgName=[NSString stringWithFormat:@"%@_%@_Backimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
                        [[NSUserDefaults standardUserDefaults] setObject:nsdataBackBase64String forKey:BackimgName];
                    }

                    self.scrollBack=[[UIScrollView alloc]init];
                    self.scrollBack.layer.frame=CGRectMake(screenRect.size.width*0.15,screenRect.size.height*0.50,screenRect.size.width*0.70,screenRect.size.height*0.30);
                    [self.scrollBack removeFromSuperview];
                    [self.view addSubview:self.scrollBack];
                    
                    [BackImgVw removeFromSuperview];
                    self.BackImgVw =[[UIImageView alloc]init];
                    self.BackImgVw.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.50,screenRect.size.height*0.20);
                    [self.BackImgVw removeFromSuperview];
                    [self.scrollBack addSubview:self.BackImgVw];

                    self.scrollBack.hidden=NO;
                    self.scrollBack.userInteractionEnabled = YES;
                    self.scrollBack.maximumZoomScale = 3.0f;
                    self.scrollBack.minimumZoomScale = 1.0f;
                    self.scrollFront.tag = 1;
                    self.scrollBack.tag = 2;

                    img1 = [UIImage imageWithData: nsdataBackBase64String];
                    self.BackImgVw.contentMode = UIViewContentModeScaleAspectFit;
                    self.BackImgVw.image=img1;

                    backimageview=[[UIImageView alloc]init];
                    backimageview.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.05,screenRect.size.width*0.50,screenRect.size.height*0.20);
                    [backimageview removeFromSuperview];
                    backimageview.alpha = 0.5; //Alpha runs from 0.0 to 1.0
                    [self.scrollBack addSubview:backimageview];
                    self.backimageview.contentMode = UIViewContentModeScaleAspectFit;
                    
                    [backLbl removeFromSuperview];
                    backLbl = [[UILabel alloc] init];
                    [backLbl setFrame:CGRectMake(screenRect.size.width*0.10,0, screenRect.size.width*0.50, 25)];
                    backLbl.textAlignment = NSTextAlignmentCenter;
                    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                    backLbl.text=@"Card image - Back";
                    [backLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                    backLbl.font=[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                    [self.scrollBack addSubview:backLbl];
                    
                    [optionLbl1 removeFromSuperview];
                    optionLbl1 = [[UILabel alloc] init];
                    [optionLbl1 setFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.25, screenRect.size.width*0.60,25)];
                    optionLbl1.textAlignment = NSTextAlignmentCenter;
                    optionLbl1.lineBreakMode = NSLineBreakByWordWrapping;
                    optionLbl1.numberOfLines = 0;
                    [optionLbl1 setTextColor: [self colorFromHexString:@"#03687f"]];
                    optionLbl1.text=@"Double tap image to zoom";
                    optionLbl1.font = [UIFont fontWithName:@"Open Sans" size:13.0];
                    [self.scrollBack addSubview:optionLbl1];

                    [msgLbl removeFromSuperview];
                    [msgdeleLbl removeFromSuperview];
                    msgdeleLbl = [[UILabel alloc] init];
                    [msgdeleLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.83, screenRect.size.width*0.90, 30)];
                    msgdeleLbl.textAlignment = NSTextAlignmentLeft;
                    msgdeleLbl.lineBreakMode = NSLineBreakByWordWrapping;
                    msgdeleLbl.numberOfLines = 0;
                    [msgdeleLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                    //NSString *str=@"\uf111";
                    NSString *str=@"";
                    NSString *str1=@"Tap to select, press ";
                    NSString *str2=@"\uf1f8";
                    NSString *str3=@" to delete image";
                    UIFont *ArialFont = [UIFont fontWithName:@"FontAwesome" size:9.0];
                    NSDictionary *arialdict = [NSDictionary dictionaryWithObject: ArialFont forKey:NSFontAttributeName];
                    NSMutableAttributedString *AattrString = [[NSMutableAttributedString alloc] initWithString:str attributes: arialdict];
                    UIFont *VerdanaFont = [UIFont fontWithName:@"Open Sans" size:12.0];
                    NSDictionary *veradnadict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:NSFontAttributeName];
                    NSMutableAttributedString *VattrString = [[NSMutableAttributedString alloc]initWithString: str1 attributes:veradnadict];
                    UIFont *ArialFont1 = [UIFont fontWithName:@"FontAwesome" size:15.0];
                    NSDictionary *arialdict1 = [NSDictionary dictionaryWithObject: ArialFont1 forKey:NSFontAttributeName];
                    NSMutableAttributedString *AattrString1 = [[NSMutableAttributedString alloc] initWithString:str2 attributes: arialdict1];
                    UIFont *ArialFont2 = [UIFont fontWithName:@"Open Sans" size:12.0];
                    NSDictionary *arialdict2 = [NSDictionary dictionaryWithObject: ArialFont2 forKey:NSFontAttributeName];
                    NSMutableAttributedString *AattrString2 = [[NSMutableAttributedString alloc] initWithString:str3 attributes: arialdict2];
                    [AattrString appendAttributedString:VattrString];
                    [AattrString appendAttributedString:AattrString1];
                    [AattrString appendAttributedString:AattrString2];
                    msgdeleLbl.attributedText = AattrString;
                    [self.view addSubview:msgdeleLbl];
                    
                    [msgLbl1 removeFromSuperview];
                    msgLbl1 = [[UILabel alloc] init];
                    [msgLbl1 setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.80, screenRect.size.width*0.90, 35)];
                    msgLbl1.textAlignment = NSTextAlignmentLeft;
                    msgLbl1.lineBreakMode = NSLineBreakByWordWrapping;
                    msgLbl1.numberOfLines = 0;
                    [msgLbl1 setTextColor: [self colorFromHexString:@"#03687f"]];
                    NSString *str4=@"";
                    NSString *str5=@"Other options:";
                    UIFont *ArialFont4 = [UIFont fontWithName:@"FontAwesome" size:9.0];
                    NSDictionary *arialdict5 = [NSDictionary dictionaryWithObject: ArialFont4 forKey:NSFontAttributeName];
                    NSMutableAttributedString *AattrString5 = [[NSMutableAttributedString alloc] initWithString:str4 attributes: arialdict5];
                    UIFont *VerdanaFont5 = [UIFont fontWithName:@"Open Sans" size:12.0];
                    NSDictionary *veradnadict5 = [NSDictionary dictionaryWithObject:VerdanaFont5 forKey:NSFontAttributeName];
                    NSMutableAttributedString *VattrString5 = [[NSMutableAttributedString alloc]initWithString: str5 attributes:veradnadict5];
                    //[AattrString5 appendAttributedString:VattrString5];
                    msgLbl1.attributedText = VattrString5;
                    [self.view addSubview:msgLbl1];
                    
                    
                    UITapGestureRecognizer *doubleTapback = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
                    [doubleTapback setNumberOfTapsRequired:2];
                    [self.scrollBack addGestureRecognizer:doubleTapback];
                    
                    UITapGestureRecognizer *doubleTapbackone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleone:)];
                    [doubleTapbackone setNumberOfTapsRequired:1];
                    [self.scrollBack addGestureRecognizer:doubleTapbackone];
                    

                    [doubleTapbackone requireGestureRecognizerToFail:doubleTapback];

                    if ([frontImaStr isEqualToString:@""] || frontImaStr==nil) {
                        [self.navigationItem setRightBarButtonItems:@[] animated:NO];
                        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                        [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                        [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                        rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                        [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                        //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                        UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                        UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                        rightBtn.titleLabel.font = fontss;
                        [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                        [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
                    }
                }
                else{
                    CGRect screenRect = [[UIScreen mainScreen] bounds];
                    [msgLbl removeFromSuperview];
                    [msgdeleLbl removeFromSuperview];
                    msgLbl = [[UILabel alloc] init];
                    [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01, screenRect.size.width*0.90, 35)];
                    msgLbl.textAlignment = NSTextAlignmentCenter;
                    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                    msgLbl.text=@"No image available";
                    [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                    msgLbl.font=font1s;
                    [self.view addSubview:msgLbl];
                    
                    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                    [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                    rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                    //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                    UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                    UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                    rightBtn.titleLabel.font = fontss;
                    [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                    [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
                }
            }else{
                CGRect screenRect = [[UIScreen mainScreen] bounds];
                [msgLbl removeFromSuperview];
                [msgdeleLbl removeFromSuperview];
                msgLbl = [[UILabel alloc] init];
                [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.01, screenRect.size.width*0.90, 35)];
                msgLbl.textAlignment = NSTextAlignmentCenter;
                //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
                msgLbl.text=@"No image available";
                [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
                UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
                msgLbl.font=font1s;
                [self.view addSubview:msgLbl];
                
                UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [rightBtn setFrame:CGRectMake(0, 0,45,50)];
                [rightBtn setTitle:@"  Add\nimage" forState:UIControlStateNormal];
                rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                [rightBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
                //[rightBtn setBackgroundImage:[UIImage imageNamed:@"add1.png"] forState:UIControlStateNormal];
                UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                UIFont * fontss =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
                rightBtn.titleLabel.font = fontss;
                [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
                [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];
                
            }
        }
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];
    }
}

-(IBAction)BackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
#pragma mark TapDetectingImageViewDelegate methods


- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms in
    [frontimageView setImage:[UIImage imageNamed:@""]];
    [backimageview setImage:[UIImage imageNamed:@""]];
    [frontimageView setBackgroundColor:[UIColor clearColor]];
    [backimageview setBackgroundColor:[UIColor clearColor]];
    [frontimageBtn removeFromSuperview];
    [backimageBtn removeFromSuperview];
    
    UIView *customView = gestureRecognizer.view;
    
    if (customView.tag == 1) {
        isTapped = YES;
        ImgViewViewController *modelvc=[[ImgViewViewController alloc] initWithNibName:@"ImgViewViewController" bundle:nil];
        modelvc.image=[[UIImage alloc]init];
        modelvc.image=img;
        [self.navigationController pushViewController:modelvc animated:NO];
    }else if (customView.tag == 2){
        isTapped = YES;
        ImgViewViewController *modelvc=[[ImgViewViewController alloc] initWithNibName:@"ImgViewViewController" bundle:nil];
        modelvc.image=[[UIImage alloc]init];
        modelvc.image=img1;
        [self.navigationController pushViewController:modelvc animated:NO];
    }else if (customView.tag == 3){
        isTapped = YES;
        ImgViewViewController *modelvc=[[ImgViewViewController alloc] initWithNibName:@"ImgViewViewController" bundle:nil];
        modelvc.image=[[UIImage alloc]init];
        modelvc.image=img;
        [self.navigationController pushViewController:modelvc animated:NO];
    }else if (customView.tag == 4){
        isTapped = YES;
        ImgViewViewController *modelvc=[[ImgViewViewController alloc] initWithNibName:@"ImgViewViewController" bundle:nil];
        modelvc.image=[[UIImage alloc]init];
        modelvc.image=img1;
        [self.navigationController pushViewController:modelvc animated:NO];
    }
}

-(IBAction)BackClick:(id)sender
{
    if ([self.CheckId isEqualToString:@"IdCard"]) {
        
        [self performSegueWithIdentifier:@"Goback" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"Pushback" sender:self];
    }
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([[segue identifier] isEqualToString:@"ViewImg"]) {
//        
//        UpdateImageViewController *LoginView = [segue destinationViewController];
//        if (CheckImg==NO)
//        {
//            LoginView.BackImage=[UIImage imageNamed:@"Front view of card.PNG"];
//        }
//        else
//        {
//            LoginView.BackImage=[UIImage imageNamed:@"backview of card.PNG"];
//            
//        }
//        
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
