//
//  PharmacyDetalisViewController.m
//  BenefitBridge
//
//  Created by Infinitum on 04/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "PharmacyDetalisViewController.h"

@interface PharmacyDetalisViewController ()

@end

@implementation PharmacyDetalisViewController
@synthesize phrVO,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"Pharmacy Detalis";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
    //[leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UILabel *NameLbl,*lineLbl,*DistanceLbl,*address,*cityLbl,*phoneNoLbl;
    
    NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.12, screenRect.size.width*0.55, screenRect.size.height*0.07)];
    NameLbl.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:screenRect.size.width*0.04];
    NameLbl.textColor=[UIColor blackColor];
    NSString *name=[NSString stringWithFormat:@"%@    %.2f mi",phrVO.Name,[phrVO.Distance doubleValue]];
    NameLbl.text=name;
    NameLbl.textAlignment = NSTextAlignmentLeft;
    NameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    NameLbl.numberOfLines = 0;
    [self.view addSubview:NameLbl];
    
    address=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.195, screenRect.size.width*0.90, screenRect.size.height*0.07)];
    address.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.045];
    address.textColor=[UIColor blackColor];
    NSString * addressStr=[NSString stringWithFormat:@"%@, %@",phrVO.Address1,phrVO.Address2];
    address.text=addressStr;
    address.textAlignment = NSTextAlignmentLeft;
    address.lineBreakMode = NSLineBreakByWordWrapping;
    address.numberOfLines = 0;
    [self.view addSubview:address];
    
    cityLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.27, screenRect.size.width*0.90, screenRect.size.height*0.07)];
    cityLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.045];
    cityLbl.textColor=[UIColor blackColor];
    NSString *cityStr=[NSString stringWithFormat:@"%@, %@, %@",phrVO.City,phrVO.State,phrVO.Zip];
    cityLbl.text=cityStr;
    cityLbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:cityLbl];

    phoneNoLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.345, screenRect.size.width*0.70, screenRect.size.height*0.05)];
    phoneNoLbl.font = [UIFont fontWithName:@"Open Sans" size:screenRect.size.width*0.045];
    phoneNoLbl.textColor=[UIColor blackColor];
    phoneNoLbl.text=phrVO.PharmacyPhone;
    phoneNoLbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneNoLbl];

    if (![phrVO.PharmacyPhone isEqualToString:@""] || phrVO.PharmacyPhone!=nil) {
    UIButton *phoneBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.80,screenRect.size.height*0.345,40,40)];
    [phoneBtn addTarget:self
               action:@selector(CallBtn:)
     forControlEvents:UIControlEventTouchUpInside];
    [phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneBtn setBackgroundImage:[UIImage imageNamed:@"fa-phone_60_10_03687f_none.png"]forState:UIControlStateNormal];
    [self.view addSubview:phoneBtn];
    }
    int yheight=5;
    if (phrVO.Has24hrServiceBool) {
        UIImageView *has24=[[UIImageView alloc] initWithFrame:CGRectMake(yheight, screenRect.size.height*0.45, 40, 40)];
        [has24 setImage:[UIImage imageNamed:@"24Hrs.png"]];
        [self.view addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (phrVO.HasCompoundingBool) {
        UIImageView *has24=[[UIImageView alloc] initWithFrame:CGRectMake(yheight, screenRect.size.height*0.45, 40, 40)];
        [has24 setImage:[UIImage imageNamed:@"Compunding.png"]];
        [self.view addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (phrVO.HasDeliveryBool) {
        UIImageView *has24=[[UIImageView alloc] initWithFrame:CGRectMake(yheight, screenRect.size.height*0.45, 40, 40)];
        [has24 setImage:[UIImage imageNamed:@"Delivery.png"]];
        [self.view addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (phrVO.HasDriveupBool) {
        UIImageView *has24=[[UIImageView alloc] initWithFrame:CGRectMake(yheight, screenRect.size.height*0.45, 40, 40)];
        [has24 setImage:[UIImage imageNamed:@"DriveThrough.png"]];
        [self.view addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (phrVO.HasDurableEquipmentBool) {
        UIImageView *has24=[[UIImageView alloc] initWithFrame:CGRectMake(yheight, screenRect.size.height*0.45, 40, 40)];
        [has24 setImage:[UIImage imageNamed:@"DurableEquipments.png"]];
        [self.view addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;

    }
    if (phrVO.HasEPrescriptionsBool) {
        UIImageView *has24=[[UIImageView alloc] initWithFrame:CGRectMake(yheight, screenRect.size.height*0.45, 40, 40)];
        [has24 setImage:[UIImage imageNamed:@"ePrescription.png"]];
        [self.view addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
    if (phrVO.HasHandicapAccessBool) {
        UIImageView *has24=[[UIImageView alloc] initWithFrame:CGRectMake(yheight, screenRect.size.height*0.45, 40, 40)];
        [has24 setImage:[UIImage imageNamed:@"DisableAccess.png"]];
        [self.view addSubview:has24];
        yheight=yheight+screenRect.size.width*0.135;
    }
}
-(void)CallBtn:(UIButton *)Btn{
    
    NSString* Strr2 = [phrVO.PharmacyPhone stringByReplacingOccurrencesOfString:@"-"   withString:@""];
    NSLog(@"phone number :- %@",Strr2);
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        NSString *phoneNumber =Strr2;
        NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURLString]];
    } else {
        UIAlertView *warning =[[UIAlertView alloc] initWithTitle:@"Note" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [warning show];
    }
}

-(IBAction)CancelAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
