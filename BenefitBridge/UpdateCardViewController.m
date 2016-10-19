//
//  UpdateCardViewController.m
//  demo
//
//  Created by Global Networking Resources on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "UpdateCardViewController.h"
#import "UIColor+Expanded.h"
#import "BenefitDetailsViewController.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface UpdateCardViewController ()
{
    BOOL ImgFlag;
    UIImage *chosenImage;
}

@end

@implementation UpdateCardViewController
@synthesize myBenesVO,BackBtn,activityIndicator,forntimageByteStr,BackimageByteStr,forntimgName,BackimgName,activityImageView,testFrontimg,testBackImg,appDelegate,imgfront,imgBack,msgLbl,frontLbl,backLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 50)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setText:[NSString stringWithFormat:@"Update Cards\n%@",myBenesVO.Ins_Type]];
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
    titleLabel.font=font1;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.hidesBackButton = YES;
    [activityIndicator stopAnimating];

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

    CGRect screenRect = [[UIScreen mainScreen] bounds];

    msgLbl = [[UILabel alloc] init];
    [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13, screenRect.size.width*0.90, 35)];
    msgLbl.textAlignment = NSTextAlignmentCenter;
    msgLbl.text=@"Tap to Capture image";
    [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    msgLbl.font=font1s;
    [self.view addSubview:msgLbl];

    frontLbl = [[UILabel alloc] init];
    [frontLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.165, screenRect.size.width*0.90, 25)];
    frontLbl.textAlignment = NSTextAlignmentCenter;
    frontLbl.text=@"Card image - Front";
    [frontLbl setTextColor: [self colorFromHexString:@"#03687f"]];
    frontLbl.font=[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
    [self.view addSubview:frontLbl];

    self.FrontImgVw=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.21,screenRect.size.width*0.50,screenRect.size.height*0.20)];
    [self.view addSubview:self.FrontImgVw];

    
    backLbl = [[UILabel alloc] init];
    [backLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.50, screenRect.size.width*0.90, 25)];
    backLbl.textAlignment = NSTextAlignmentCenter;
    backLbl.text=@"Card image - Back";
    [backLbl setTextColor: [self colorFromHexString:@"#03687f"]];
    backLbl.font=[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
    [self.view addSubview:backLbl];

    self.BackImgVw=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.54,screenRect.size.width*0.50,screenRect.size.height*0.20)];
    [self.view addSubview:self.BackImgVw];

    self.UpdateCardBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30, screenRect.size.height*0.84, screenRect.size.width*0.40, screenRect.size.height*0.05)];
    [self.UpdateCardBtn setBackgroundColor:[UIColor clearColor]];
    self.UpdateCardBtn.layer.cornerRadius = 6.0f;
    [self.UpdateCardBtn addTarget:self action:@selector(UpdateCardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.UpdateCardBtn setTitle:@"Update" forState:UIControlStateNormal];
    [self.UpdateCardBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [self.view addSubview:self.UpdateCardBtn];

    if (imgfront==nil) {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [self.FrontImgVw addGestureRecognizer:singleTap];
        self.FrontImgVw.layer.borderWidth=1.0f;
        self.FrontImgVw.layer.borderColor=[UIColor blueColor].CGColor;

    }else{
        self.FrontImgVw.image = imgfront;
    }
    
    ///for back img //
    if (imgBack==nil) {
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didimageTaped1:)];
        singleTap1.numberOfTapsRequired = 1;
        singleTap1.numberOfTouchesRequired = 1;
        [self.BackImgVw addGestureRecognizer:singleTap1];
        self.BackImgVw.layer.borderWidth=1.0f;
        self.BackImgVw.layer.borderColor=[UIColor blueColor].CGColor;

    }else{
        self.BackImgVw.image = imgBack;
    }
    
    [self.FrontImgVw setUserInteractionEnabled:YES];
    [self.BackImgVw setUserInteractionEnabled:YES];
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
-(void)viewDidLayoutSubviews{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if(self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height))){
        appDelegate.isLandscapeOK=YES;
        
        self.FrontImgVw.layer.frame=CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.21,screenRect.size.width*0.50,screenRect.size.height*0.20);
        self.BackImgVw.layer.frame=CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.54,screenRect.size.width*0.50,screenRect.size.height*0.20);
        
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13, screenRect.size.width*0.90, 35)];

        [frontLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.165, screenRect.size.width*0.90, 25)];
        [backLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.50, screenRect.size.width*0.90, 25)];
        
        self.UpdateCardBtn.layer.frame=CGRectMake(screenRect.size.width*0.30, screenRect.size.height*0.84, screenRect.size.width*0.40, screenRect.size.height*0.05);

    }
    else{
        appDelegate.isLandscapeOK=NO;
        
        self.FrontImgVw.layer.frame=CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.30,screenRect.size.width*0.38,screenRect.size.height*0.40);
        self.BackImgVw.layer.frame=CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.30,screenRect.size.width*0.38,screenRect.size.height*0.40);
        
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.13, screenRect.size.width*0.90, 35)];

        [frontLbl setFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.20, screenRect.size.width*0.40, 25)];
        [backLbl setFrame:CGRectMake(screenRect.size.width*0.50,screenRect.size.height*0.20, screenRect.size.width*0.40, 25)];
        
        self.UpdateCardBtn.layer.frame=CGRectMake(screenRect.size.width*0.37, screenRect.size.height*0.80, screenRect.size.width*0.26, screenRect.size.height*0.10);

    }
}

-(void)viewDidAppear:(BOOL)animated{
    appDelegate.isLandscapeOK=YES;

}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
-(IBAction)BackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)imageTaped:(UIGestureRecognizer *)gestureRecognizer {
    
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    ImgFlag=NO;
    }


- (void)didimageTaped1:(UIGestureRecognizer *)gestureRecognizer {
    
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    ImgFlag=YES;
    
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (ImgFlag==NO)
    {
        testFrontimg=[[UIImageView alloc]init];
        testFrontimg.image = chosenImage;
    }
    else
    {
        testBackImg=[[UIImageView alloc]init];
        testBackImg.image = chosenImage;
    }

    [picker dismissViewControllerAnimated:YES completion:^{
        [self getImage:chosenImage];
    }];
}

-(IBAction)UpdateCardClick:(id)sender
{
    if (imgfront==nil && imgBack==nil) {

    if (self.FrontImgVw.image!=nil)
    {
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        if (self.BackImgVw.image==nil) {
            BackimageByteStr=@"";
            BackimgName=@"";
            [self uploadImg ];

        }else{
            [self uploadImg ];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BenefitBridge"
                                                        message:@"Front Image is Mandatory"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    }else if(imgfront !=nil){
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];

        NSData *ImageDatas = UIImageJPEGRepresentation(imgfront,0.1);
        
        forntimageByteStr=[[NSString alloc]init];
        forntimageByteStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        forntimgName=[[NSString alloc]init];
        forntimgName=[NSString stringWithFormat:@"%@_%@_Frontimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];


        if ([BackimageByteStr isEqualToString:@""] || BackimageByteStr ==nil) {
            BackimageByteStr=@"";
            BackimgName=@"";

        [self uploadImg ];
        }else{
            [self uploadImg ];
        }

    }else if (imgBack !=nil){
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        NSData *ImageDatas = UIImageJPEGRepresentation(imgBack,0.1);
        BackimageByteStr=[[NSString alloc]init];
        BackimageByteStr= [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        BackimgName=[[NSString alloc]init];
        BackimgName=[NSString stringWithFormat:@"%@_%@_Backimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
        if ([forntimageByteStr isEqualToString:@""] || forntimageByteStr ==nil) {
            forntimageByteStr=@"";
            forntimgName=@"";

            [self uploadImg ];
        }else{
            [self uploadImg ];
            
        }
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

-(void)uploadImg{
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
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

    }else{

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM/dd/yyyy HH:mm:ss";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
        NSString *dateStr=[dateFormatter stringFromDate:now];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[prefs objectForKey:@"UserId"] forKey:@"UserID"];
    [dict setValue:[prefs objectForKey:@"LoginId"] forKey:@"LoginID"];
    [dict setValue:[prefs objectForKey:@"SubscriberCode"] forKey:@"SubscriberCode"];
    [dict setValue:myBenesVO.Ins_Type forKey:@"BenefitType"];
    [dict setValue:forntimgName forKey:@"FrontImageName"];
    [dict setValue:BackimgName forKey:@"BackImageName"];
    [dict setValue:forntimageByteStr forKey:@"FrontImage"];
    [dict setValue:BackimageByteStr forKey:@"BackImage"];
    [dict setValue:dateStr forKey:@"ModifiedDate"];

    //convert object to data
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   //[request setURL:[NSURL URLWithString:@"http://192.168.0.192:9810/api/IdCard/UpdateImages"]];
    [request setURL:[NSURL URLWithString:@"http://api.benefitbridge.com/mobileapp/api/IDCard/UpdateImages/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    
    // print json:
    NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding]);
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                [activityIndicator stopAnimating];
                NSLog(@"Failed to submit request");
                [activityImageView removeFromSuperview];

            }
            else
            {
                [activityIndicator stopAnimating];
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];

                NSLog(@"rerturn response %@",content);
                if ([content isEqualToString:@"true"]) {
                    if (NSClassFromString(@"UIAlertController") != Nil) // Yes, Nil
                    {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"BenefitBridge" message:@"Image Uploaded Successfully" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
                                                                    [self dismissViewControllerAnimated:YES completion:nil];
                                                                }]];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Image Uploaded Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    }
                    
                    NSData *nsdatafrontBase64String = [[NSData alloc] initWithBase64EncodedString:forntimageByteStr options:0];
                    NSData *nsdatabackBase64String = [[NSData alloc] initWithBase64EncodedString:BackimageByteStr options:0];

                    [[NSUserDefaults standardUserDefaults] setObject:nsdatafrontBase64String forKey:forntimgName];
                    [[NSUserDefaults standardUserDefaults] setObject:nsdatabackBase64String forKey:BackimgName];

                    [activityImageView removeFromSuperview];

                }else{
                    if (NSClassFromString(@"UIAlertController") != Nil) // Yes, Nil
                    {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"BenefitBridge" message:@"Internet error" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
                                                                    [self dismissViewControllerAnimated:YES completion:nil];
                                                                }]];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    else
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [alert show];
                    }
                    [activityImageView removeFromSuperview];
                }
            }
        }];
    }
}

-(void)displayMsg{
    [activityImageView removeFromSuperview];

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Image Uploaded Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"GoToUpdate"]) {
//        
//        MyBenefitViewController *LoginView = [segue destinationViewController];
//        
//        
//        LoginView.FrontImg=self.FrontImgVw.image;
//        LoginView.BackImg=self.BackImgVw.image;
//        LoginView.ChkImg=@"YesImg";
//    }
//    
}



#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:NULL];

    if (ImgFlag==NO){
        self.FrontImgVw.image = croppedImage;
        NSData *ImageDatas = UIImageJPEGRepresentation(croppedImage,0.1);
        
        forntimageByteStr=[[NSString alloc]init];
        forntimageByteStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        forntimgName=[[NSString alloc]init];
        forntimgName=[NSString stringWithFormat:@"%@_%@_Frontimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
    }else{
        self.BackImgVw.image = croppedImage;
        NSData *ImageDatas = UIImageJPEGRepresentation(croppedImage,0.1);
        BackimageByteStr=[[NSString alloc]init];
        BackimageByteStr= [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        BackimgName=[[NSString alloc]init];
        BackimgName=[NSString stringWithFormat:@"%@_%@_Backimage.png",[prefs objectForKey:@"UserId"],myBenesVO.Ins_Type];
            }
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Action methods

#pragma mark : IBAction

- (IBAction)getImage:(id)sender {
    
    if (ImgFlag==NO) {
        PECropViewController *controller = [[PECropViewController alloc] init];
        controller.delegate = self;
        controller.image = testFrontimg.image;
        
        UIImage *image1 = testFrontimg.image;
        CGFloat width = image1.size.width;
        CGFloat height = image1.size.height;
        CGFloat length = MIN(width, height);
        controller.imageCropRect = CGRectMake((width - length) / 2,
                                              (height - length) / 2,
                                              length,
                                              length);
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        }
        [self presentViewController:navigationController animated:YES completion:NULL];
        
    }
    else
    {
        PECropViewController *controller = [[PECropViewController alloc] init];
        controller.delegate = self;
        controller.image = testBackImg.image;
        
        UIImage *image1 = testBackImg.image;
        CGFloat width = image1.size.width;
        CGFloat height = image1.size.height;
        CGFloat length = MIN(width, height);
        controller.imageCropRect = CGRectMake((width - length) / 2,
                                              (height - length) / 2,
                                              length,
                                              length);
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        }
        [self presentViewController:navigationController animated:YES completion:NULL];
    }
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
