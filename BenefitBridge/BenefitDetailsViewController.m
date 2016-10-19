//
//  BenefitDetailsViewController.m
//  demo
//
//  Created by Global Networking Resources on 08/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "BenefitDetailsViewController.h"
#import "UIColor+Expanded.h"
#import "ViewCardViewController.h"
#import "UpdateCardViewController.h"
#import "MyBenefitViewController.h"
#import "Reachability.h"
#import "CoveredRelectionVO.h"
#import "PlanDetalisVO.h"
#import "TestUpdateCardViewController.h"
#import "HsaFsAVO.h"
@interface BenefitDetailsViewController ()

@end

@implementation BenefitDetailsViewController
@synthesize firatview,firstsecondView,bannerlogoImg,viewBtn,updatecardBtn,offLBl,detectLbb,converedLbl,reletionLbl,nameLbl,reletionnameLbl,myBeneVO,tokenStr,coveredRelestionArray,HeightY,scrollView,ProductPlicyNumberArray,secondView,placenameLbl,placenameLbl1,descriptionLbl,descriptionLbl1,carrierLbl,carrierLbl1,policynoLbl,policynoLbl1,effectivedateLbl,effectivedateLbl1,groupnameLbl,tableViewMain,inbenefitArray,outbenefitArray,productdiStr,segmentedControl,commonArray,otherArray,attributenameArray,indexarraycount,activityIndicator,ProductNameStr,ProductTypeDescriptionStr,CarrierNameStr,PolicyNumbeStr,EffectiveDatStr,dectiveValueStr,activityImageView,covrageLbl,covragedispLbl,BeneficiaryArray,BeneficiaryView,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate=[[UIApplication sharedApplication] delegate];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=myBeneVO.Ins_Type;
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;
    [activityIndicator stopAnimating];
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

    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    
    coveredRelestionArray=[[NSMutableArray alloc]init];

}
- (NSUInteger)supportedInterfaceOrientations
{
    appDelegate.isLandscapeOK=NO;
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    appDelegate.isLandscapeOK=NO;

    if ([coveredRelestionArray count]<=0 ) {
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        [self getTokenData];
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

-(void)displayView{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    HeightY=screenRect.size.height*0.34;
    int counts=[coveredRelestionArray count];
    if (([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"] || [myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"])){
        HeightY=HeightY+(48*counts);

    }else{
        HeightY=HeightY+(40*counts);

    }
    firatview=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.02, screenRect.size.width*0.90, HeightY)];
    [firatview setBackgroundColor:[UIColor colorWithHexString:@"f7f8f7"]];
    firatview.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;
    firatview.layer.cornerRadius=2.5f;
    firatview.layer.borderWidth=1.0f;
    UIImageView * logoImg;
    UILabel *inn_TypeLbl;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
    logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.30,7,45,45)];
    inn_TypeLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.39,5, screenRect.size.width*0.50, 45)];

    }else{
        logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.27,5,35,35)];
        inn_TypeLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.37,2, screenRect.size.width*0.40, 45)];

    }
    if ([myBeneVO.Ins_Type isEqualToString:@"Medical"]) {
        [logoImg setImage:[UIImage imageNamed:@"Medical_Icon.png"]];
    }else if ([myBeneVO.Ins_Type isEqualToString:@"Dental"]){
        [logoImg setImage:[UIImage imageNamed:@"Dental_Icon.png"]];
    }else if ([myBeneVO.Ins_Type isEqualToString:@"Vision"]){
        [logoImg setImage:[UIImage imageNamed:@"Vision_Icon.png"]];
    }else if ([myBeneVO.Ins_Type isEqualToString:@"Group Term Life"]){
        [logoImg setImage:[UIImage imageNamed:@"life_icon.png"]];
    }else if ([myBeneVO.Ins_Type isEqualToString:@"Voluntary Term Life"]){
        [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
    }else if ([myBeneVO.Ins_Type isEqualToString:@"Accidental Death and Dismemberment"]){
        [logoImg setImage:[UIImage imageNamed:@"Accident_Ins_Icon.png"]];
    }else if ([myBeneVO.Ins_Type isEqualToString:@"Critical Illness"]){
        [logoImg setImage:[UIImage imageNamed:@"Critical_ins_Icon.png"]];
    }else if ([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"]){
        [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
    }else{
        [logoImg setImage:[UIImage imageNamed:@"default_icon.png"]];
    }
    //[firatview addSubview:logoImg];
    
    int len = [myBeneVO.Ins_Type length];
    
    if (len < 10) {
        inn_TypeLbl.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:16];
    }else if (len > 11 && len < 20){
        inn_TypeLbl.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:14];
    }else if (len > 21 && len < 30){
        inn_TypeLbl.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:12];
    }else if (len > 31 && len < 40){
        inn_TypeLbl.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:10];
    }
    inn_TypeLbl.textColor=[UIColor colorWithHexString:@"03687F"];
    inn_TypeLbl.text=myBeneVO.Ins_Type;
    inn_TypeLbl.lineBreakMode = NSLineBreakByWordWrapping;
    inn_TypeLbl.numberOfLines = 0;
    inn_TypeLbl.textAlignment = NSTextAlignmentLeft;
   // [firatview addSubview:inn_TypeLbl];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    int heigY=screenRect.size.height*0.02;
    bannerlogoImg=[[AsyncImageView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.18,heigY, screenRect.size.width*0.50, screenRect.size.height*0.08)];
    [bannerlogoImg setBackgroundColor:[UIColor clearColor]];
    NSString *urlStr=[NSString stringWithFormat:@"https://www.benefitbridge.com/images/carrierlogo/%@",myBeneVO.Carrier_Logo];
    [bannerlogoImg loadImageFromURL:[NSURL URLWithString:urlStr]];
    //mediaImage.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"feed1.png"]];
    [bannerlogoImg.layer setMasksToBounds:YES];
    bannerlogoImg.clipsToBounds=YES;
    [firatview addSubview:bannerlogoImg];
    
    heigY=heigY+screenRect.size.height*0.08;
    groupnameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.01,heigY, screenRect.size.width*0.88, 50)];
    groupnameLbl.font = [UIFont fontWithName:@"Open Sans" size:12];
    groupnameLbl.textColor=[UIColor blackColor];
    groupnameLbl.text=myBeneVO.Group_Name;
    groupnameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    groupnameLbl.numberOfLines = 0;
    groupnameLbl.textAlignment = NSTextAlignmentCenter;
    [firatview addSubview:groupnameLbl];
    

    if (![dectiveValueStr isEqualToString:@""] && dectiveValueStr !=nil) {
        heigY=heigY+screenRect.size.height*0.06;

        offLBl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigY, screenRect.size.width*0.39, 30)];
        offLBl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
        offLBl.textColor=[UIColor blackColor];
        offLBl.text=@"Office Visit: $30";
        offLBl.lineBreakMode = NSLineBreakByWordWrapping;
        offLBl.numberOfLines = 0;
        offLBl.textAlignment = NSTextAlignmentRight;
        //[firatview addSubview:offLBl];

        detectLbb=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigY, screenRect.size.width*0.78,30)];
        detectLbb.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
        detectLbb.textColor=[UIColor blackColor];
        NSString * str=[NSString stringWithFormat:@"Deductible: %@",dectiveValueStr];
        detectLbb.text=str;
        detectLbb.textAlignment = NSTextAlignmentCenter;
        detectLbb.lineBreakMode = NSLineBreakByWordWrapping;
        detectLbb.numberOfLines = 0;
        [firatview addSubview:detectLbb];
        
        heigY=heigY+screenRect.size.height*0.05;

    }else{
        heigY=heigY+screenRect.size.height*0.08;

    }
    
    
    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.035];

    viewBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.03,heigY, screenRect.size.width*0.41, screenRect.size.height*0.05)];
    [viewBtn setBackgroundColor:[UIColor clearColor]];
    viewBtn.layer.cornerRadius = 6.0f;
    [viewBtn addTarget:self action:@selector(ViewCardAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewBtn setTitle:@"View Card" forState:UIControlStateNormal];
    [viewBtn.titleLabel setFont:customFontdregs];
    [viewBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [firatview addSubview:viewBtn];
    
    updatecardBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.46, heigY, screenRect.size.width*0.40, screenRect.size.height*0.05)];
    [updatecardBtn setBackgroundColor:[UIColor clearColor]];
    updatecardBtn.layer.cornerRadius = 6.0f;
    [updatecardBtn addTarget:self action:@selector(UpdatecardAction:) forControlEvents:UIControlEventTouchUpInside];
    [updatecardBtn setTitle:@"Update Card" forState:UIControlStateNormal];
    [updatecardBtn.titleLabel setFont:customFontdregs];
    [updatecardBtn setBackgroundColor:[UIColor colorWithHexString:@"D08C2A"]];
    [firatview addSubview:updatecardBtn];
    
    int secondviewHeight=50;
    if (([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"] || [myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"])){
        secondviewHeight=secondviewHeight+(counts*43);

    }else{
        secondviewHeight=secondviewHeight+(counts*37);

    }
    firstsecondView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.03,screenRect.size.height*0.26, screenRect.size.width*0.835,secondviewHeight)];
    [firstsecondView setBackgroundColor:[UIColor whiteColor]];
    
    
    int boolValue = [myBeneVO.Category intValue];
    NSLog(@"boolValue %d",boolValue);
    
    if (([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"] || [myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"]) && boolValue==2) {
        converedLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.015,4, screenRect.size.width*0.25, 30)];
        reletionLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.285,4, screenRect.size.width*0.25,30)];
        covrageLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.56,4, screenRect.size.width*0.25, 30)];

        converedLbl.text=@" COVERED";
        reletionLbl.text=@" RELATION";
        covrageLbl.text=@" COVERAGE";

        covrageLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
        covrageLbl.textColor=[UIColor blackColor];
        covrageLbl.lineBreakMode = NSLineBreakByWordWrapping;
        covrageLbl.numberOfLines = 0;
        covrageLbl.textAlignment = NSTextAlignmentLeft;
        [covrageLbl setBackgroundColor:[UIColor colorWithHexString:@"4e7fc0"]];
        [firstsecondView addSubview:covrageLbl];

    }else if (([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"] || [myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"]) && boolValue==3) {
        converedLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.01,4, screenRect.size.width*0.40, 30)];
        reletionLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,4, screenRect.size.width*0.39,30)];
        converedLbl.text=@" COVERED";
        reletionLbl.text=@" CONTRIBUTION";

    }else{
        converedLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.01,4, screenRect.size.width*0.40, 30)];
        reletionLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,4, screenRect.size.width*0.39,30)];
        converedLbl.text=@" COVERED";
        reletionLbl.text=@" RELATION";

    }
    
    converedLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
    converedLbl.textColor=[UIColor whiteColor];
    converedLbl.lineBreakMode = NSLineBreakByWordWrapping;
    converedLbl.numberOfLines = 0;
    converedLbl.textAlignment = NSTextAlignmentLeft;
    [converedLbl setBackgroundColor:[UIColor colorWithHexString:@"4e7fc0"]];
    [firstsecondView addSubview:converedLbl];
    
   
    reletionLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
    reletionLbl.textColor=[UIColor whiteColor];
      reletionLbl.textAlignment = NSTextAlignmentLeft;
    reletionLbl.lineBreakMode = NSLineBreakByWordWrapping;
    reletionLbl.numberOfLines = 0;
    [reletionLbl setBackgroundColor:[UIColor colorWithHexString:@"4e7fc0"]];
    [firstsecondView addSubview:reletionLbl];
    
    int hei=37;
    for (int count=0; count<[coveredRelestionArray count]; count++) {
        CoveredRelectionVO *coVO=[coveredRelestionArray objectAtIndex:count];
    
        
        if (([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"] || [myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"]) && boolValue==2) {
        nameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0155,hei, screenRect.size.width*0.25, 40)];
        reletionnameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.29,hei, screenRect.size.width*0.25,40)];
        covragedispLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.565,hei, screenRect.size.width*0.25, 60)];
            
            if ([coVO.relation isEqualToString:@"EE"]) {
                reletionnameLbl.text=@"EMPLOYEE";
                
            }else{
                reletionnameLbl.text=coVO.relation;
                
            }
            //covragedispLbl.text=[NSString stringWithFormat:@"$%.0f",[myBeneVO.Coverage floatValue]];
            
            
            if ([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"]) {
                NSArray* allDataar = [myBeneVO.Coverage componentsSeparatedByString: @"/"];
                
                if ([allDataar count]>1) {
                    covragedispLbl.text=[NSString stringWithFormat:@"Unreimbursed Medical (Annual):$%.0f\nDependent Care (Annual):$%.0f",[[allDataar objectAtIndex:0] floatValue],[[allDataar objectAtIndex:1] floatValue] ];
                    
                }else{
                    covragedispLbl.text=[NSString stringWithFormat:@"Unreimbursed Medical (Annual):$%.0f\nDependent Care (Annual): $0",[myBeneVO.Coverage floatValue]];
                    
                }
                
            }
            
            if ([myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"]) {
                covragedispLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,hei, screenRect.size.width*0.39,40)];
                
                covragedispLbl.text=[NSString stringWithFormat:@"Contribution (Annual): $%.0f",[myBeneVO.Coverage floatValue] ];
                
            }
            covragedispLbl.font = [UIFont fontWithName:@"Open Sans" size:10];

            
            
            //covragedispLbl.font = [UIFont fontWithName:@"Open Sans" size:12];
            covragedispLbl.textColor=[UIColor colorWithHexString:@"434444"];
            covragedispLbl.textAlignment = NSTextAlignmentLeft;
            covragedispLbl.lineBreakMode = NSLineBreakByWordWrapping;
            covragedispLbl.numberOfLines = 0;
            [covragedispLbl setBackgroundColor:[UIColor clearColor]];
            [firstsecondView addSubview:covragedispLbl];

        }else if (([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"] || [myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"]) && boolValue==3) {
            nameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.015,hei, screenRect.size.width*0.40, 60)];
            
            
            if ([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"]) {
                reletionnameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,hei, screenRect.size.width*0.39,60)];
                NSArray* allDataar = [myBeneVO.Coverage componentsSeparatedByString: @"/"];

                if ([allDataar count]>1) {
                    reletionnameLbl.text=[NSString stringWithFormat:@"Unreimbursed Medical (Annual):$%.0f\nDependent Care (Annual):$%.0f",[[allDataar objectAtIndex:0] floatValue],[[allDataar objectAtIndex:1] floatValue] ];

                }else{
                    reletionnameLbl.text=[NSString stringWithFormat:@"Unreimbursed Medical (Annual):$%.0f\nDependent Care (Annual): $0",[myBeneVO.Coverage floatValue]];

                }

            }

            if ([myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"]) {
                reletionnameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.43,hei, screenRect.size.width*0.39,40)];
                
                reletionnameLbl.text=[NSString stringWithFormat:@"Contribution (Annual): $%.0f",[myBeneVO.Coverage floatValue] ];
                
            }
            reletionnameLbl.font = [UIFont fontWithName:@"Open Sans" size:10];


        }else{
            nameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.015,hei, screenRect.size.width*0.40, 40)];
            
            reletionnameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.435,hei, screenRect.size.width*0.39,40)];

            if ([coVO.relation isEqualToString:@"EE"]) {
                reletionnameLbl.text=@"EMPLOYEE";
                
            }else{
                reletionnameLbl.text=coVO.relation;
                
            }
            reletionnameLbl.font = [UIFont fontWithName:@"Open Sans" size:12];

        }
        
        nameLbl.font = [UIFont fontWithName:@"Open Sans" size:12];
        nameLbl.textColor=[UIColor colorWithHexString:@"434444"];
        NSString *str=[NSString stringWithFormat:@"%@ %@",coVO.Member_FirstName,coVO.Member_LastName];
        nameLbl.text=str;
        nameLbl.lineBreakMode = NSLineBreakByWordWrapping;
        nameLbl.numberOfLines = 0;
        nameLbl.textAlignment = NSTextAlignmentLeft;
        [nameLbl setBackgroundColor:[UIColor clearColor]];
        [firstsecondView addSubview:nameLbl];

        reletionnameLbl.textColor=[UIColor colorWithHexString:@"434444"];
    reletionnameLbl.textAlignment = NSTextAlignmentLeft;
    reletionnameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    reletionnameLbl.numberOfLines = 0;
    [reletionnameLbl setBackgroundColor:[UIColor clearColor]];
    [firstsecondView addSubview:reletionnameLbl];
        hei=hei+40;
    }
    [firatview addSubview:firstsecondView];
    [scrollView addSubview:firatview];

    HeightY=HeightY+20;
    
    if ([BeneficiaryArray count]>0) {
        int countss=[BeneficiaryArray count];

        int viewhigt=(50*countss)+50;
        BeneficiaryView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,HeightY, screenRect.size.width*0.90, viewhigt)];
        [BeneficiaryView setBackgroundColor:[UIColor colorWithHexString:@"f7f8f7"]];
        BeneficiaryView.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;
        BeneficiaryView.layer.cornerRadius=2.5f;
        BeneficiaryView.layer.borderWidth=1.0f;
        BeneficiaryView.layer.cornerRadius=2.5f;
        int heigYs=7;

    UILabel   * nameLbls=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.01,heigYs, screenRect.size.width*0.23, 45)];
        nameLbls.font = [UIFont fontWithName:@"OpenSans-Bold" size:11];
        nameLbls.textColor=[UIColor blackColor];
        nameLbls.text=@"NAME";
        nameLbls.textAlignment = NSTextAlignmentLeft;
        [nameLbls setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
        [BeneficiaryView addSubview:nameLbls];

        UILabel   * releationLbls=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.25,heigYs, screenRect.size.width*0.23, 45)];
        releationLbls.font = [UIFont fontWithName:@"OpenSans-Bold" size:11];
        releationLbls.textColor=[UIColor blackColor];
        releationLbls.text=@"RELATION";
        releationLbls.textAlignment = NSTextAlignmentLeft;
        [releationLbls setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
        [BeneficiaryView addSubview:releationLbls];

        UILabel   * TypeLbls=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.49,heigYs, screenRect.size.width*0.23, 45)];
        TypeLbls.font = [UIFont fontWithName:@"OpenSans-Bold" size:11];
        TypeLbls.textColor=[UIColor blackColor];
        TypeLbls.text=@"BENEFICIARY";
        TypeLbls.textAlignment = NSTextAlignmentLeft;
        [TypeLbls setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
        [BeneficiaryView addSubview:TypeLbls];

        UILabel   * prsentageLbls=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.73,heigYs, screenRect.size.width*0.15, 45)];
        prsentageLbls.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
        prsentageLbls.textColor=[UIColor blackColor];
        prsentageLbls.text=@"   %";
        prsentageLbls.textAlignment = NSTextAlignmentLeft;
        [prsentageLbls setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
        [BeneficiaryView addSubview:prsentageLbls];


        int heis=47;

        for (int count=0; count<[BeneficiaryArray count]; count++) {
            HsaFsAVO *hsaVO=[BeneficiaryArray objectAtIndex:count];
            
            
     UILabel * namesLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.012,heis, screenRect.size.width*0.23, 45)];
    UILabel * reletionnamesLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.252,heis, screenRect.size.width*0.23, 45)];
    UILabel * typesLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.492,heis, screenRect.size.width*0.23, 45)];
    UILabel *prsentagesLbls=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.735,heis, screenRect.size.width*0.15, 45)];

            namesLbl.text=hsaVO.FirstName;
            reletionnamesLbl.text=hsaVO.Relation;
            typesLbl.text=hsaVO.BeneficiaryType;
            prsentagesLbls.text=[NSString stringWithFormat:@"%d",[hsaVO.Percentage intValue]];

            
            namesLbl.font = [UIFont fontWithName:@"Open Sans" size:12];
            namesLbl.textColor=[UIColor colorWithHexString:@"434444"];
            namesLbl.textAlignment = NSTextAlignmentLeft;
            namesLbl.lineBreakMode = NSLineBreakByWordWrapping;
            namesLbl.numberOfLines = 0;
            [namesLbl setBackgroundColor:[UIColor clearColor]];
            [BeneficiaryView addSubview:namesLbl];

            reletionnamesLbl.font = [UIFont fontWithName:@"Open Sans" size:12];
            reletionnamesLbl.textColor=[UIColor colorWithHexString:@"434444"];
            reletionnamesLbl.textAlignment = NSTextAlignmentLeft;
            reletionnamesLbl.lineBreakMode = NSLineBreakByWordWrapping;
            reletionnamesLbl.numberOfLines = 0;
            [reletionnamesLbl setBackgroundColor:[UIColor clearColor]];
            [BeneficiaryView addSubview:reletionnamesLbl];

            typesLbl.font = [UIFont fontWithName:@"Open Sans" size:12];
            typesLbl.textColor=[UIColor colorWithHexString:@"434444"];
            typesLbl.textAlignment = NSTextAlignmentLeft;
            typesLbl.lineBreakMode = NSLineBreakByWordWrapping;
            typesLbl.numberOfLines = 0;
            [typesLbl setBackgroundColor:[UIColor clearColor]];
            [BeneficiaryView addSubview:typesLbl];

            prsentagesLbls.font = [UIFont fontWithName:@"Open Sans" size:12];
            prsentagesLbls.textColor=[UIColor colorWithHexString:@"434444"];
            prsentagesLbls.textAlignment = NSTextAlignmentLeft;
            prsentagesLbls.lineBreakMode = NSLineBreakByWordWrapping;
            prsentagesLbls.numberOfLines = 0;
            [prsentagesLbls setBackgroundColor:[UIColor clearColor]];
            [BeneficiaryView addSubview:prsentagesLbls];
                
            heis=heis+47;
        }
        
        [scrollView addSubview:BeneficiaryView];

        
        HeightY=HeightY+(50*counts)+50;

    }
    
    
    if (![ProductNameStr isEqualToString:@""] && ProductNameStr !=nil) {
        
        UILabel * placedetalisLbl=[[UILabel alloc] initWithFrame:CGRectMake(0,HeightY, screenRect.size.width, 45)];
        placedetalisLbl.font = [UIFont fontWithName:@"OpenSans-ExtraBold" size:14];
        placedetalisLbl.textColor=[UIColor colorWithHexString:@"03687f"];
        placedetalisLbl.lineBreakMode = NSLineBreakByWordWrapping;
        placedetalisLbl.numberOfLines = 0;
        placedetalisLbl.text=@"Plan Details";
        placedetalisLbl.textAlignment = NSTextAlignmentCenter;
        [placedetalisLbl setBackgroundColor:[UIColor clearColor]];
        [self.scrollView addSubview:placedetalisLbl];
        HeightY=HeightY+50;
    
    secondView=[[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,HeightY, screenRect.size.width*0.90, 270)];
    [secondView setBackgroundColor:[UIColor whiteColor]];
    secondView.layer.borderColor = [UIColor colorWithHexString:@"e4e3e2"].CGColor;
    secondView.layer.cornerRadius=2.5f;
    secondView.layer.borderWidth=1.0f;
    secondView.layer.cornerRadius=2.5f;
    int heigY=7;


    placenameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0155,heigY, screenRect.size.width*0.42, 45)];
    placenameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
    placenameLbl.textColor=[UIColor darkGrayColor];
    placenameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    placenameLbl.numberOfLines = 0;
    placenameLbl.text=@" Plan Name";
    placenameLbl.textAlignment = NSTextAlignmentLeft;
    [placenameLbl setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    [secondView addSubview:placenameLbl];
    
        
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.46,heigY, screenRect.size.width*0.42,45)];
    [customView setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    [secondView addSubview:customView];

    placenameLbl1=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.465,heigY, screenRect.size.width*0.42,45)];
    placenameLbl1.font = [UIFont fontWithName:@"Open Sans" size:12];
    placenameLbl1.textColor=[UIColor darkGrayColor];
    placenameLbl1.textAlignment = NSTextAlignmentLeft;
    placenameLbl1.lineBreakMode = NSLineBreakByWordWrapping;
    placenameLbl1.numberOfLines = 0;
    [placenameLbl1 setBackgroundColor:[UIColor clearColor]];
    [secondView addSubview:placenameLbl1];

    heigY=heigY+53;
    
    descriptionLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0155,heigY, screenRect.size.width*0.42, 45)];
    descriptionLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
    descriptionLbl.textColor=[UIColor darkGrayColor];
    descriptionLbl.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionLbl.numberOfLines = 0;
    descriptionLbl.text=@" Description";
    descriptionLbl.textAlignment = NSTextAlignmentLeft;
    [descriptionLbl setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
    [secondView addSubview:descriptionLbl];
    
    UIView* customView1 = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.46,heigY, screenRect.size.width*0.42,45)];
    [customView1 setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
    [secondView addSubview:customView1];

    descriptionLbl1=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.465,heigY, screenRect.size.width*0.42,45)];
    descriptionLbl1.font = [UIFont fontWithName:@"Open Sans" size:12];
    descriptionLbl1.textColor=[UIColor darkGrayColor];
    descriptionLbl1.textAlignment = NSTextAlignmentLeft;
    descriptionLbl1.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionLbl1.numberOfLines = 0;
    [descriptionLbl1 setBackgroundColor:[UIColor clearColor]];
    [secondView addSubview:descriptionLbl1];

    heigY=heigY+53;

    carrierLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0155,heigY, screenRect.size.width*0.42, 45)];
    carrierLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
    carrierLbl.textColor=[UIColor darkGrayColor];
    carrierLbl.lineBreakMode = NSLineBreakByWordWrapping;
    carrierLbl.numberOfLines = 0;
    carrierLbl.text=@" Carrier";
    carrierLbl.textAlignment = NSTextAlignmentLeft;
    [carrierLbl setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    [secondView addSubview:carrierLbl];
    
    UIView* customView2 = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.46,heigY, screenRect.size.width*0.42,45)];
    [customView2 setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    [secondView addSubview:customView2];

    carrierLbl1=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.465,heigY, screenRect.size.width*0.42,45)];
    carrierLbl1.font = [UIFont fontWithName:@"Open Sans" size:12];
    carrierLbl1.textColor=[UIColor darkGrayColor];
    carrierLbl1.textAlignment = NSTextAlignmentLeft;
    carrierLbl1.lineBreakMode = NSLineBreakByWordWrapping;
    carrierLbl1.numberOfLines = 0;
    [carrierLbl1 setBackgroundColor:[UIColor clearColor]];
    [secondView addSubview:carrierLbl1];

    heigY=heigY+53;

    policynoLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0155,heigY, screenRect.size.width*0.42, 45)];
    policynoLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
    policynoLbl.textColor=[UIColor darkGrayColor];
    policynoLbl.lineBreakMode = NSLineBreakByWordWrapping;
    policynoLbl.numberOfLines = 0;
    policynoLbl.text=@" Policy Number";
    policynoLbl.textAlignment = NSTextAlignmentLeft;
    [policynoLbl setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
    [secondView addSubview:policynoLbl];
    
        
        UIView* customView3 = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.46,heigY, screenRect.size.width*0.42,45)];
        [customView3 setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
        [secondView addSubview:customView3];

    policynoLbl1=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.465,heigY, screenRect.size.width*0.42,45)];
    policynoLbl1.font = [UIFont fontWithName:@"Open Sans" size:12];
    policynoLbl1.textColor=[UIColor darkGrayColor];
    policynoLbl1.textAlignment = NSTextAlignmentLeft;
    policynoLbl1.lineBreakMode = NSLineBreakByWordWrapping;
    policynoLbl1.numberOfLines = 0;
    [policynoLbl1 setBackgroundColor:[UIColor clearColor]];
    [secondView addSubview:policynoLbl1];

    heigY=heigY+53;

    effectivedateLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.0155,heigY, screenRect.size.width*0.42, 45)];
    effectivedateLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
    effectivedateLbl.textColor=[UIColor darkGrayColor];
    effectivedateLbl.lineBreakMode = NSLineBreakByWordWrapping;
    effectivedateLbl.numberOfLines = 0;
    effectivedateLbl.text=@" Effective Date";
    effectivedateLbl.textAlignment = NSTextAlignmentLeft;
    [effectivedateLbl setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    [secondView addSubview:effectivedateLbl];
    
        UIView* customView5 = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.46,heigY, screenRect.size.width*0.42,45)];
        [customView5 setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
        [secondView addSubview:customView5];

    effectivedateLbl1=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.465,heigY, screenRect.size.width*0.42,45)];
    effectivedateLbl1.font = [UIFont fontWithName:@"Open Sans" size:12];
    effectivedateLbl1.textColor=[UIColor darkGrayColor];
    effectivedateLbl1.textAlignment = NSTextAlignmentLeft;
    effectivedateLbl1.lineBreakMode = NSLineBreakByWordWrapping;
    effectivedateLbl1.numberOfLines = 0;
    [effectivedateLbl1 setBackgroundColor:[UIColor clearColor]];
    [secondView addSubview:effectivedateLbl1];
    
        placenameLbl1.text= ProductNameStr;
        descriptionLbl1.text=ProductTypeDescriptionStr;
        carrierLbl1.text=CarrierNameStr;
        policynoLbl1.text=PolicyNumbeStr;
        effectivedateLbl1.text=EffectiveDatStr;

    [scrollView addSubview:secondView];
        HeightY=HeightY+300;
    }
    NSArray *itemArray;
    if ([inbenefitArray count]>0 && [outbenefitArray count]>0  && [otherArray count]>0) {
        itemArray = [NSArray arrayWithObjects: @"In Network", @"Out of Network", @"Other", nil];
    }else if ([inbenefitArray count]>0 && [outbenefitArray count]>0){
        itemArray = [NSArray arrayWithObjects: @"In Network", @"Out of Network", nil];
    }else if ([inbenefitArray count]>0 && [otherArray count]>0){
        itemArray = [NSArray arrayWithObjects: @"In Network", @"Other", nil];
    }else if ([outbenefitArray count]>0 && [otherArray count]>0){
        itemArray = [NSArray arrayWithObjects: @"Out of Network", @"Other", nil];
    }else if ([inbenefitArray count]>0){
        itemArray = [NSArray arrayWithObjects: @"In Network", nil];

    }else if ([outbenefitArray count]>0){
        itemArray = [NSArray arrayWithObjects: @"Out of Network", nil];
        
    }else if ([otherArray count]>0){
        itemArray = [NSArray arrayWithObjects: @"Other", nil];
    }
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(screenRect.size.width*0.05, HeightY, screenRect.size.width*0.90,35);
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor colorWithHexString:@"e8e8e7"];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"03687f"]} forState:UIControlStateSelected];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"434444"]} forState:UIControlStateDisabled];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"OpenSans-ExtraBold" size:13.0], UITextAttributeFont, nil] forState:UIControlStateNormal];

    [scrollView addSubview:segmentedControl];

    HeightY=HeightY+50;

    if ([commonArray count]>0) {
        int countss=[commonArray count];
        NSLog(@"count array %d",countss);
        int heights;
        if (countss<22) {
            heights=70*countss;

        }else if(countss<40){
            heights=65*countss;

        }else{
            heights=75*countss;

        }
        tableViewMain=[[UITableView alloc]init];
        tableViewMain.frame=CGRectMake(screenRect.size.width*0.05,HeightY,screenRect.size.width*0.90,heights);
        tableViewMain.dataSource = self;
        tableViewMain.delegate = self;
        [tableViewMain setBackgroundColor:[UIColor clearColor]];
        self.tableViewMain.separatorColor = [UIColor clearColor];
        [self.tableViewMain.layer setBorderColor:[UIColor colorWithHexString:@"e4e3e2"].CGColor];
        [self.tableViewMain.layer setBorderWidth:2.0f];

        tableViewMain.scrollEnabled=false;
        [scrollView addSubview:tableViewMain];
        HeightY=HeightY+heights;
        scrollView.contentSize=CGSizeMake(screenRect.size.width, HeightY+200);

   
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        UILabel *msgLbl = [[UILabel alloc] init];
        [msgLbl setFrame:CGRectMake(screenRect.size.width*0.05,HeightY, screenRect.size.width*0.90, 35)];
        msgLbl.textAlignment = NSTextAlignmentCenter;
        //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
        msgLbl.text=@"No plan details available";
        [msgLbl setTextColor: [self colorFromHexString:@"#03687f"]];
        UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
        msgLbl.font=font1s;
        [scrollView addSubview:msgLbl];
        
        scrollView.contentSize=CGSizeMake(screenRect.size.width, HeightY+250);

    }

    [activityIndicator stopAnimating];
    [activityImageView removeFromSuperview];

}
- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    commonArray=[[NSMutableArray alloc]init];
    if(segment.selectedSegmentIndex == 0)
    {
        if ([inbenefitArray count]>0) {
            commonArray=inbenefitArray;

        }else{
            if ([outbenefitArray count]>0) {
                commonArray=outbenefitArray;
 
            }else{
                commonArray=otherArray;
            }
        }


    }else if (segment.selectedSegmentIndex == 1){
        commonArray=outbenefitArray;

    }else{
        commonArray=otherArray;
    }
    for (int count=0; count<[commonArray count]; count++) {
        PlanDetalisVO *plandetVO=[[PlanDetalisVO alloc] init];

        NSSortDescriptor *priceDescriptor = [NSSortDescriptor
                                             sortDescriptorWithKey:@"AttributeOrderId"
                                             ascending:YES
                                             selector:@selector(compare:)];
        NSArray *descriptors = @[priceDescriptor];
        [commonArray sortUsingDescriptors:descriptors];

    }
    
    attributenameArray=[[NSMutableArray alloc]init];
    for (int count=0; count<[commonArray count]; count++) {
        PlanDetalisVO *plandetVO=[[PlanDetalisVO alloc] init];
        plandetVO=[commonArray objectAtIndex:count];
    [attributenameArray addObject:plandetVO.AttributeSectionName];
        
        NSLog(@"plandetVO.AttributeName %@",plandetVO.AttributeName);
        if ([coveredRelestionArray count]>0) {
            int valueArray=[coveredRelestionArray count];
            if (valueArray >1) {
                if ([plandetVO.AttributeName isEqualToString:@"Annual Deductible/Family"]) {
                    dectiveValueStr=[[NSString alloc]init];
                    dectiveValueStr=plandetVO.AttributeValue;
                }
            }else{
                if([plandetVO.AttributeName isEqualToString:@"Annual Deductible/Individual"]){
                    dectiveValueStr=[[NSString alloc]init];
                    dectiveValueStr=plandetVO.AttributeValue;
                }
            }

        }
    }
    
  NSMutableArray * array2=[[NSMutableArray alloc]init];
    array2=attributenameArray;
    attributenameArray=[[NSMutableArray alloc]init];
    for (id obj in array2)
    {
        if (![attributenameArray containsObject:obj])
        {
            [attributenameArray addObject: obj];
        }
    }

    for (int count=0; count<[commonArray count]; count++) {
        PlanDetalisVO *plandetVO=[[PlanDetalisVO alloc] init];
        
        NSSortDescriptor *priceDescriptor = [NSSortDescriptor
                                             sortDescriptorWithKey:@"AttributeName"
                                             ascending:YES
                                             selector:@selector(compare:)];
        NSArray *descriptors = @[priceDescriptor];
        [commonArray sortUsingDescriptors:descriptors];
        
    }


    [tableViewMain reloadData];
}

-(void)getTokenData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[activityIndicator stopAnimating];
    }else{

        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/Auth/GenerateToken/mobileapp"];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];

        }else{
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSString *messages = [[NSString alloc]init];
            messages = [userDict objectForKey:@"Password"];
            tokenStr = [[NSString alloc]init];
            tokenStr = [userDict objectForKey:@"Token"];
            NSLog(@"Token :%@",tokenStr);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^(){
                    if ([myBeneVO.Ins_Type isEqualToString:@"Flexible Spending Account"]) {
                        int boolValue = [myBeneVO.Category intValue];
                        NSLog(@"boolValue %d",boolValue);
                        if (boolValue==2) {
                            [self getBeneficiaryAllocation];
                            
                        }
                    }else if ([myBeneVO.Ins_Type isEqualToString:@"Health Spending Account"]){
                        int boolValue = [myBeneVO.Category intValue];
                        NSLog(@"boolValue %d",boolValue);
                        if (boolValue==2) {
                            [self getBeneficiaryAllocation];
                            
                        }

                    }

                    [self getCoveredRelationData];
                });
                
            });
        }
    }
}

-(void)getBeneficiaryAllocation{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];
        
    }else{
        BeneficiaryArray=[[NSMutableArray alloc]init];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/Employee/GetBeneficiaryAllocation/%@/%@/%@/%@",tokenStr,[prefs objectForKey:@"SubscriberCode"],myBeneVO.Group_ID,myBeneVO.Div_ID];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@"Token test : %@",tokenStr);
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];
            
        }else{
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
            for (int count=0; count<[userArray count]; count++){
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                HsaFsAVO *BeneficiaryVo=[[HsaFsAVO alloc] init];
                BeneficiaryVo.BeneficiaryType=[[NSString alloc] init];
                BeneficiaryVo.DOB=[[NSString alloc] init];
                BeneficiaryVo.DivID=[[NSString alloc] init];
                BeneficiaryVo.FirstName=[[NSString alloc] init];
                BeneficiaryVo.GroupID=[[NSString alloc] init];
                BeneficiaryVo.LastName=[[NSString alloc] init];
                BeneficiaryVo.MemberType=[[NSString alloc] init];
                BeneficiaryVo.Member_Code=[[NSString alloc] init];
                BeneficiaryVo.MiddleName=[[NSString alloc] init];
                BeneficiaryVo.Percentage=[[NSString alloc] init];
                BeneficiaryVo.Relation=[[NSString alloc] init];
                BeneficiaryVo.SubscriberName=[[NSString alloc] init];
                
                if ([activityData objectForKey:@"BeneficiaryType"] != [NSNull null])
                    BeneficiaryVo.BeneficiaryType=[activityData objectForKey:@"BeneficiaryType"];
                
                if ([activityData objectForKey:@"DOB"] != [NSNull null])
                    BeneficiaryVo.DOB=[activityData objectForKey:@"DOB"];
                
                if ([activityData objectForKey:@"DivID"] != [NSNull null])
                    BeneficiaryVo.DivID=[activityData objectForKey:@"DivID"];
                
                if ([activityData objectForKey:@"FirstName"] != [NSNull null])
                    BeneficiaryVo.FirstName=[activityData objectForKey:@"FirstName"];
                
                if ([activityData objectForKey:@"GroupID"] != [NSNull null])
                    BeneficiaryVo.GroupID=[activityData objectForKey:@"GroupID"];
                
                if ([activityData objectForKey:@"LastName"] != [NSNull null])
                    BeneficiaryVo.LastName=[activityData objectForKey:@"LastName"];
                
                if ([activityData objectForKey:@"MemberType"] != [NSNull null])
                    BeneficiaryVo.MemberType=[activityData objectForKey:@"MemberType"];
                
                if ([activityData objectForKey:@"Member_Code"] != [NSNull null])
                    BeneficiaryVo.Member_Code=[activityData objectForKey:@"Member_Code"];
                
                if ([activityData objectForKey:@"MiddleName"] != [NSNull null])
                    BeneficiaryVo.MiddleName=[activityData objectForKey:@"MiddleName"];
                
                if ([activityData objectForKey:@"Percentage"] != [NSNull null])
                    BeneficiaryVo.Percentage=[activityData objectForKey:@"Percentage"];
                
                if ([activityData objectForKey:@"Relation"] != [NSNull null])
                    BeneficiaryVo.Relation =[activityData objectForKey:@"Relation"];
                
                if ([activityData objectForKey:@"SubscriberName"] != [NSNull null])
                    BeneficiaryVo.SubscriberName=[activityData objectForKey:@"SubscriberName"];
                
                
                    [BeneficiaryArray addObject:BeneficiaryVo];
            }
        }
    }

}
-(void)getCoveredRelationData{
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
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/EmployeeSelfService/EmployeeSelfService/Election/GetDependentsAndCoverage/%@/%@/%@/%@/%@/%@",tokenStr,[prefs objectForKey:@"SubscriberCode"],[prefs objectForKey:@"clientcode"],myBeneVO.Ins_Type,myBeneVO.Group_ID,myBeneVO.Div_ID];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@"Token test : %@",tokenStr);
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [activityIndicator stopAnimating];
            [activityImageView removeFromSuperview];

        }else{
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                CoveredRelectionVO *covRleVo=[[CoveredRelectionVO alloc] init];
                covRleVo.Approved=[[NSString alloc] init];
                covRleVo.CalcAge=[[NSString alloc] init];
                covRleVo.Coverage=[[NSString alloc] init];
                covRleVo.Disabled=[[NSString alloc] init];
                covRleVo.Effective_From=[[NSString alloc] init];
                covRleVo.Effective_To=[[NSString alloc] init];
                covRleVo.Existing_Provider=[[NSString alloc] init];
                covRleVo.HasCoverage=[[NSString alloc] init];
                covRleVo.MRN=[[NSString alloc] init];
                covRleVo.MemDOB=[[NSString alloc] init];
                covRleVo.Member_Code=[[NSString alloc] init];
                covRleVo.Member_FirstName=[[NSString alloc] init];
                covRleVo.Member_LastName=[[NSString alloc] init];
                covRleVo.Member_MiddleName=[[NSString alloc] init];
                covRleVo.NDEVisible=[[NSString alloc] init];
                covRleVo.Premium=[[NSString alloc] init];
                covRleVo.Provider_ID=[[NSString alloc] init];
                covRleVo.Provider_Name=[[NSString alloc] init];
                covRleVo.Student=[[NSString alloc] init];
                covRleVo.SubxGrpID=[[NSString alloc] init];
                covRleVo.category=[[NSString alloc] init];
                covRleVo.rel_order=[[NSString alloc] init];
                covRleVo.relation=[[NSString alloc] init];
                
                if ([activityData objectForKey:@"Approved"] != [NSNull null])
                    covRleVo.Approved=[activityData objectForKey:@"Approved"];
                    
                    if ([activityData objectForKey:@"CalcAge"] != [NSNull null])
                    covRleVo.CalcAge=[activityData objectForKey:@"CalcAge"];
                        
                    if ([activityData objectForKey:@"Coverage"] != [NSNull null])
                    covRleVo.Coverage=[activityData objectForKey:@"Coverage"];
                        
                    if ([activityData objectForKey:@"Disabled"] != [NSNull null])
                    covRleVo.Disabled=[activityData objectForKey:@"Disabled"];
                                
                    if ([activityData objectForKey:@"Effective_From"] != [NSNull null])
                    covRleVo.Effective_From=[activityData objectForKey:@"Effective_From"];
                                    
                    if ([activityData objectForKey:@"Effective_To"] != [NSNull null])
                    covRleVo.Effective_To=[activityData objectForKey:@"Effective_To"];
                                        
                    if ([activityData objectForKey:@"Existing_Provider"] != [NSNull null])
                    covRleVo.Existing_Provider=[activityData objectForKey:@"Existing_Provider"];
                        
                    if ([activityData objectForKey:@"HasCoverage"] != [NSNull null])
                    covRleVo.HasCoverage=[activityData objectForKey:@"HasCoverage"];
                                                
                    if ([activityData objectForKey:@"MRN"] != [NSNull null])
                    covRleVo.MRN=[activityData objectForKey:@"MRN"];
                        
                    if ([activityData objectForKey:@"MemDOB"] != [NSNull null])
                    covRleVo.MemDOB=[activityData objectForKey:@"MemDOB"];
                            
                    if ([activityData objectForKey:@"Member_Code"] != [NSNull null])
                    covRleVo.Member_Code =[activityData objectForKey:@"Member_Code"];
                                
                    if ([activityData objectForKey:@"Member_FirstName"] != [NSNull null])
                    covRleVo.Member_FirstName=[activityData objectForKey:@"Member_FirstName"];
                                    
                    if ([activityData objectForKey:@"Member_LastName"] != [NSNull null])
                    covRleVo.Member_LastName=[activityData objectForKey:@"Member_LastName"];
                                        
                    if ([activityData objectForKey:@"Member_MiddleName"] != [NSNull null])
                    covRleVo.Member_MiddleName=[activityData objectForKey:@"Member_MiddleName"];
                                            
                    if ([activityData objectForKey:@"NDEVisible"] != [NSNull null])
                    covRleVo.NDEVisible =[activityData objectForKey:@"NDEVisible"];
                                                
                    if ([activityData objectForKey:@"Premium"] != [NSNull null])
                    covRleVo.Premium=[activityData objectForKey:@"Premium"];
                                                    
                    if ([activityData objectForKey:@"Provider_ID"] != [NSNull null])
                    covRleVo.Provider_ID=[activityData objectForKey:@"Provider_ID"];
                                                        
                    if ([activityData objectForKey:@"Provider_Name"] != [NSNull null])
                    covRleVo.Provider_Name=[activityData objectForKey:@"Provider_Name"];
                        
                    if ([activityData objectForKey:@"Student"] != [NSNull null])
                    covRleVo.Student=[activityData objectForKey:@"Student"];
                            
                    if ([activityData objectForKey:@"SubxGrpID"] != [NSNull null])
                    covRleVo.SubxGrpID=[activityData objectForKey:@"SubxGrpID"];
                                
                    if ([activityData objectForKey:@"category"] != [NSNull null])
                    covRleVo.category=[activityData objectForKey:@"category"];
                                    
                    if ([activityData objectForKey:@"rel_order"] != [NSNull null])
                    covRleVo.rel_order=[activityData objectForKey:@"rel_order"];
                                        
                    if ([activityData objectForKey:@"relation"] != [NSNull null])
                    covRleVo.relation=[activityData objectForKey:@"relation"];
                
                
                BOOL boolValue = [covRleVo.HasCoverage boolValue];

                NSLog(@"boolValue %d",boolValue);
                if (boolValue==1) {
                    [coveredRelestionArray addObject:covRleVo];

                }
                
            }
            [self getProductPlicyNumberData];
        }
    }
}


-(void)getProductPlicyNumberData{
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
        ProductPlicyNumberArray=[[NSMutableArray alloc]init];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/BenefitpointPlanService/BenefitPointService/Products/GetProductByPolicyNumber/%@/%@/%@/%@/?policyNumber=%@",tokenStr,[prefs objectForKey:@"clientcode"],@"3",myBeneVO.Ins_Type,myBeneVO.Carrier_Group_Num];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@"Token test : %@",tokenStr);
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [self gettableviewData];
            [self displayView];
        }else{

            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            
            NSUserDefaults *prefsusername = [NSUserDefaults standardUserDefaults];
            if ([userDict objectForKey:@"ProductName"] != [NSNull null]){
            [prefsusername setObject:[userDict objectForKey:@"ProductName"] forKey:@"ProductName"];
                ProductNameStr=[[NSString alloc]init];
                ProductNameStr=[userDict objectForKey:@"ProductName"];
            }
            if ([userDict objectForKey:@"ProductTypeDescription"] != [NSNull null]){
                ProductTypeDescriptionStr=[[NSString alloc]init];
                ProductTypeDescriptionStr=[userDict objectForKey:@"ProductTypeDescription"];
            }
            if ([userDict objectForKey:@"CarrierName"] != [NSNull null]){
                CarrierNameStr=[[NSString alloc]init];
                CarrierNameStr=[userDict objectForKey:@"CarrierName"];
            }
            if ([userDict objectForKey:@"PolicyNumber"] != [NSNull null]){
                PolicyNumbeStr=[[NSString alloc]init];
                PolicyNumbeStr=[userDict objectForKey:@"PolicyNumber"];
            }
            if ([userDict objectForKey:@"EffectiveDate"] != [NSNull null]){
                EffectiveDatStr=[[NSString alloc]init];
                NSString *string2s = [userDict objectForKey:@"EffectiveDate"];
                NSArray* allDataarss = [string2s componentsSeparatedByString: @"-"];
                NSString *string2ss = [allDataarss objectAtIndex:0];
                NSArray* allDataarsss = [string2ss componentsSeparatedByString: @"("];
                NSString *string2sss = [allDataarsss objectAtIndex:1];
                long miseconds=[string2sss longLongValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:(miseconds / 1000.0)];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"MM/dd/YYYY hh:mm a";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:date]);
                EffectiveDatStr=[dateFormatter stringFromDate:date];

            }
            if ([userDict objectForKey:@"ProductId"] != [NSNull null]){
                productdiStr=[userDict objectForKey:@"ProductId"];
            }
            [prefsusername synchronize];
           [self gettableviewData];
        }
    }
}

-(void)gettableviewData{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //[activityIndicator stopAnimating];
        [activityImageView removeFromSuperview];

    }else{
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        inbenefitArray=[[NSMutableArray alloc]init];
        outbenefitArray=[[NSMutableArray alloc]init];
        otherArray=[[NSMutableArray alloc]init];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://api.benefitbridge.com/BenefitpointPlanService/BenefitPointService/BenefitSummaries/GetBenefitSummaryDetailsByProductId/%@/%@",productdiStr,tokenStr];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@"Token test : %@",tokenStr);
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        if ([content isEqualToString:@""]) {
            [self displayView];

        }else{
            NSArray *userArray=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSLog(@"ARRAY COUNT %lu",(unsigned long)[userArray count]);
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                PlanDetalisVO *plandetVO=[[PlanDetalisVO alloc] init];
                plandetVO.AttributeId=[[NSString alloc] init];
                plandetVO.AttributeName=[[NSString alloc] init];
                plandetVO.AttributeOrderId=[[NSString alloc] init];
                plandetVO.AttributeSectionId=[[NSString alloc] init];
                plandetVO.AttributeSectionName=[[NSString alloc] init];
                plandetVO.AttributeSectionOrderId=[[NSString alloc] init];
                plandetVO.AttributeValue=[[NSString alloc] init];
                plandetVO.AttributeValueId=[[NSString alloc] init];
                plandetVO.BenefitColumnId=[[NSString alloc] init];
                plandetVO.BenefitDescription=[[NSString alloc] init];
                plandetVO.BenefitSummaryDescription=[[NSString alloc] init];
                plandetVO.BenefitSummaryId=[[NSString alloc] init];
                plandetVO.ParentAttributeSectionId=[[NSString alloc] init];

                    if ([activityData objectForKey:@"AttributeId"] != [NSNull null])
                    plandetVO.AttributeId=[activityData objectForKey:@"AttributeId"];
                    
                    if ([activityData objectForKey:@"AttributeName"] != [NSNull null])
                    plandetVO.AttributeName=[activityData objectForKey:@"AttributeName"];
                        
                    if ([activityData objectForKey:@"AttributeOrderId"] != [NSNull null])
                    plandetVO.AttributeOrderId=[activityData objectForKey:@"AttributeOrderId"];
                            
                    if ([activityData objectForKey:@"AttributeSectionId"] != [NSNull null])
                    plandetVO.AttributeSectionId=[activityData objectForKey:@"AttributeSectionId"];
                                
                    if ([activityData objectForKey:@"AttributeSectionName"] != [NSNull null])
                    plandetVO.AttributeSectionName=[activityData objectForKey:@"AttributeSectionName"];
                                    
                    if ([activityData objectForKey:@"AttributeSectionOrderId"] != [NSNull null])
                    plandetVO.AttributeSectionOrderId=[activityData objectForKey:@"AttributeSectionOrderId"];
                        
                    if ([activityData objectForKey:@"AttributeValue"] != [NSNull null])
                    plandetVO.AttributeValue=[activityData objectForKey:@"AttributeValue"];
                            
                    if ([activityData objectForKey:@"AttributeValueId"] != [NSNull null])
                    plandetVO.AttributeValueId=[activityData objectForKey:@"AttributeValueId"];
                
                    if ([activityData objectForKey:@"BenefitColumnId"] != [NSNull null])
                    plandetVO.BenefitColumnId=[activityData objectForKey:@"BenefitColumnId"];
                                    
                    if ([activityData objectForKey:@"BenefitDescription"] != [NSNull null])
                    plandetVO.BenefitDescription=[activityData objectForKey:@"BenefitDescription"];
                                        
                    if ([activityData objectForKey:@"BenefitSummaryDescription"] != [NSNull null])
                    plandetVO.BenefitSummaryDescription =[activityData objectForKey:@"BenefitSummaryDescription"];
                        
                    if ([activityData objectForKey:@"BenefitSummaryId"] != [NSNull null])
                    plandetVO.BenefitSummaryId=[activityData objectForKey:@"BenefitSummaryId"];
                            
                    if ([activityData objectForKey:@"ParentAttributeSectionId"] != [NSNull null])
                    plandetVO.ParentAttributeSectionId=[activityData objectForKey:@"ParentAttributeSectionId"];
                
                
                    if ([plandetVO.BenefitDescription isEqualToString:@"In-Network Benefits"]) {
                        [inbenefitArray addObject:plandetVO];
                    }else if([plandetVO.BenefitDescription isEqualToString:@"Out-of-Network Benefits"]){
                        [outbenefitArray addObject:plandetVO];
                    }else{
                        [otherArray addObject:plandetVO];
                    }
            }
            [self MySegmentControlAction:0];
            [self displayView];

        }
    }
}
#pragma marl - UITableView Data Source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [attributenameArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *  personname;
    personname= [attributenameArray objectAtIndex:section];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"AttributeSectionName = %@", personname];
    NSArray *filterArray = [commonArray filteredArrayUsingPredicate:predicate];

    return [filterArray count];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(10, 0, tableView.frame.size.width, 50.0)];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(15,10,sectionHeaderView.frame.size.width-90,30)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:12];
    NSString *  personname;
    personname= [attributenameArray objectAtIndex:section];
                headerLabel.text=personname;
            headerLabel.textAlignment = NSTextAlignmentLeft;
    [sectionHeaderView addSubview:headerLabel];
    return sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *  personname;
    personname= [attributenameArray objectAtIndex:indexPath.section];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"AttributeSectionName = %@", personname];
    NSArray *filterArray = [commonArray filteredArrayUsingPredicate:predicate];
    
    PlanDetalisVO *divideVo1=[[PlanDetalisVO alloc]init];
    divideVo1= [filterArray objectAtIndex:indexPath.row];
    
    NSUInteger namestrLength = [divideVo1.AttributeName length];
    NSUInteger valuestrLength = [divideVo1.AttributeValue length];

    if (namestrLength>valuestrLength) {
        NSLog(@"AttributeSectionName length %lu",(unsigned long)namestrLength);
        NSInteger dividename=(namestrLength/15)*21;
        if (dividename<=21) {
            dividename=34;
        }
        return dividename;
    }else{
        NSLog(@"Attributevalue length %lu",(unsigned long)valuestrLength);
        NSInteger dividevalue=(valuestrLength/15)*21;
        if (dividevalue<=21) {
            dividevalue=34;
        }

        return dividevalue;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    PlanDetalisVO *divideVo=[[PlanDetalisVO alloc]init];
    NSString *  personname;
        personname= [attributenameArray objectAtIndex:indexPath.section];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"AttributeSectionName = %@", personname];
    NSArray *filterArray = [commonArray filteredArrayUsingPredicate:predicate];
    
    PlanDetalisVO *divideVo1=[[PlanDetalisVO alloc]init];
    divideVo1= [filterArray objectAtIndex:indexPath.row];

    NSUInteger namestrLength = [divideVo1.AttributeName length];
    NSUInteger valuestrLength = [divideVo1.AttributeValue length];
    NSInteger dividename;
    if (namestrLength>valuestrLength) {
        NSLog(@"AttributeSectionName length %lu",(unsigned long)namestrLength);
        dividename=(namestrLength/15)*20;
        if (dividename<=20) {
            dividename=30;
        }
        NSLog(@"dividename length %lu",(unsigned long)dividename);

    }else{
        NSLog(@"Attributevalue length %lu",(unsigned long)valuestrLength);
        dividename=(valuestrLength/15)*20;
        NSLog(@"dividename length %lu",(unsigned long)dividename);
        if (dividename<=20) {
            dividename=30;
        }

    }

    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(2,2, screenRect.size.width*0.44, dividename)];
    [cell.contentView addSubview:customView];

   UILabel *attributeName=[[UILabel alloc] initWithFrame:CGRectMake(4,2, screenRect.size.width*0.44, dividename)];
    attributeName.font = [UIFont fontWithName:@"Open Sans" size:12];
    attributeName.textColor=[UIColor darkGrayColor];
    attributeName.lineBreakMode = NSLineBreakByWordWrapping;
    attributeName.numberOfLines = 0;
    
    NSLog(@"divideVo1.AttributeName before%@",divideVo1.AttributeName);

    attributeName.text=[NSString stringWithFormat:@"%@",divideVo1.AttributeName];
    NSLog(@"divideVo1.AttributeName after%@",divideVo1.AttributeName);

    attributeName.textAlignment = NSTextAlignmentLeft;
   //[attributeName sizeToFit];
    [cell.contentView addSubview:attributeName];
    
    int cont=[divideVo1.AttributeValue intValue];
    
    UIView* customView1 = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width*0.46,2, screenRect.size.width*0.44,dividename)];
    [cell.contentView addSubview:customView1];

    UILabel *attributeValue=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.465,2, screenRect.size.width*0.43,dividename)];
    attributeValue.font = [UIFont fontWithName:@"Open Sans" size:12];
    attributeValue.textColor=[UIColor darkGrayColor];
    attributeValue.textAlignment = NSTextAlignmentLeft;
    attributeValue.lineBreakMode = NSLineBreakByWordWrapping;
    attributeValue.numberOfLines = 0;
    attributeValue.text=[NSString stringWithFormat:@"%@",divideVo1.AttributeValue];
    NSLog(@"divideVo1.AttributeValue %@",divideVo1.AttributeValue);
    //[attributeValue sizeToFit];
    [cell.contentView addSubview:attributeValue];
    
    int i=indexPath.row;
    if(i%2){
        [customView setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
        [customView1 setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];

        [attributeName setBackgroundColor:[UIColor clearColor]];
        [attributeValue setBackgroundColor:[UIColor clearColor]];

    }else{
        [customView setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];
        [customView1 setBackgroundColor:[UIColor colorWithHexString:@"D5D5D5"]];

        [attributeName setBackgroundColor:[UIColor clearColor]];
        [attributeValue setBackgroundColor:[UIColor clearColor]];


    }

    tableView.backgroundColor=[UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(IBAction)CancelAction:(id)sender{
//    MyBenefitViewController *main=[[MyBenefitViewController alloc] initWithNibName:@"MyBenefitViewController" bundle:nil];
//    [self.navigationController pushViewController:main animated:YES];
    [self.navigationController popViewControllerAnimated:YES];

}

-(IBAction)ViewCardAction:(id)sender{
    ViewCardViewController *viewcard=[[ViewCardViewController alloc] initWithNibName:@"ViewCardViewController" bundle:nil];
    viewcard.myBenesVO=myBeneVO;
    [self.navigationController pushViewController:viewcard animated:YES];
    
}

-(IBAction)UpdatecardAction:(id)sender{
    UpdateCardViewController *updatecard=[[UpdateCardViewController alloc] initWithNibName:@"UpdateCardViewController" bundle:nil];
    updatecard.myBenesVO=myBeneVO;
    [self.navigationController pushViewController:updatecard animated:YES];
    
    
    
//        TestUpdateCardViewController *updatecard=[[TestUpdateCardViewController alloc] initWithNibName:@"TestUpdateCardViewController" bundle:nil];
//        [self.navigationController pushViewController:updatecard animated:YES];

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
