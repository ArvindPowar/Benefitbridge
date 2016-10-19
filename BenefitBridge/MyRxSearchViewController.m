//
//  MyRxSearchViewController.m
//  BenefitBridge
//
//  Created by Infinitum on 29/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import "MyRxSearchViewController.h"
#import "UIColor+Expanded.h"
#import "DrugsFirstListViewController.h"
#import "MyRxViewController.h"
#define MAX_LENGTH 2

@interface MyRxSearchViewController ()

@end

@implementation MyRxSearchViewController
@synthesize SearchBtn,DrugsTxt,appDelegate,dosageVO,pardayBtnOne,pardayBtntwo,pardayBtnthree,pardayBtnfour,parweekBtn,parmonthBtn,asneededBtn,submitBtn,numberToolbar,nooftabletTxt,tabletnameLbl,perdayLbl,perweekLbl,permonthLbl,asneededLbl,captionnameStr,activityImageView,perdaytwoLbl,perdaythreeLbl,perdayfourLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Update Medicine";
    [titleLabel setTextColor: [self colorFromHexString:@"#851c2b"]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    
    appDelegate.contactsubmitdeleteupdate=false;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,45,45)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setFrame:CGRectMake(0, 0,30,30)];
    //[rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(DeleteDosageContact:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"font-awesome_4-6-3_trash_60_10_851c2b_none.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btns = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIFont * fonts12 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:50.0f];
    rightBtn.titleLabel.font = fonts12;
    [rightBtn setTintColor:[self colorFromHexString:@"#851c2b"]];
    [self.navigationItem setRightBarButtonItems:@[btns] animated:NO];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];

    UILabel * DrugNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.11, screenRect.size.width*0.90, screenRect.size.height*0.05)];
    DrugNameLbl.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    DrugNameLbl.textColor=[UIColor colorWithHexString:@"03687f"];
    DrugNameLbl.text=[NSString stringWithFormat:@"%@",dosageVO.dosageNmae];
    DrugNameLbl.textAlignment = NSTextAlignmentLeft;
    DrugNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
    DrugNameLbl.numberOfLines = 0;
    [self.view addSubview:DrugNameLbl];

    int heights=screenRect.size.height*0.17;
    if ([dosageVO.dosageNmae rangeOfString:@"CRE"].location != NSNotFound || [dosageVO.dosageNmae rangeOfString:@"GEL"].location != NSNotFound || [dosageVO.dosageNmae rangeOfString:@"LOT"].location != NSNotFound || [dosageVO.dosageNmae rangeOfString:@"OIN"].location != NSNotFound || [dosageVO.dosageNmae rangeOfString:@"NEB"].location != NSNotFound){
        
        asneededBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
        [asneededBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
        [asneededBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
        asneededBtn.layer.cornerRadius = 6.0f;
        [asneededBtn setTag:4];
        [asneededBtn addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:asneededBtn];
        
        asneededLbl= [[UILabel alloc] init];
        [asneededLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
        asneededLbl.textAlignment = NSTextAlignmentLeft;
        asneededLbl.text=[NSString stringWithFormat:@"As needed"];
        asneededLbl.font=fonts;
        [self.view addSubview:asneededLbl];

    }else
    {
    nooftabletTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.10,heights,screenRect.size.width*0.30,screenRect.size.height*0.05)];
    nooftabletTxt.font=font1;
    nooftabletTxt.textAlignment=NSTextAlignmentLeft;
    nooftabletTxt.delegate = self;
    nooftabletTxt.textColor=[UIColor colorWithHexString:@"434444"];
    nooftabletTxt.textColor=[UIColor colorWithHexString:@"#32333"];
    nooftabletTxt.layer.borderWidth=1.0;
    nooftabletTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
    nooftabletTxt.tag=6;
    UIView *paddingViewsb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    nooftabletTxt.leftView = paddingViewsb;
    [nooftabletTxt setTintColor:[UIColor lightGrayColor]];
    nooftabletTxt.leftViewMode = UITextFieldViewModeAlways;
    [nooftabletTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackOpaque;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    numberToolbar.tintColor=[UIColor whiteColor];
    nooftabletTxt.inputAccessoryView = numberToolbar;
        nooftabletTxt.text=[NSString stringWithFormat:@"%d", [dosageVO.nooftablet intValue]];
    nooftabletTxt.returnKeyType=UIReturnKeyNext;
    [self.view addSubview:nooftabletTxt];
    
    tabletnameLbl= [[UILabel alloc] init];
    [tabletnameLbl setFrame:CGRectMake(screenRect.size.width*0.50, heights, screenRect.size.width*0.50, screenRect.size.height*0.04)];
    tabletnameLbl.textAlignment = NSTextAlignmentLeft;
    tabletnameLbl.font=font1;
    tabletnameLbl.text=dosageVO.timeName;
    [self.view addSubview:tabletnameLbl];
    
    
    heights=heights+screenRect.size.height*0.07;

    pardayBtnOne=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [pardayBtnOne setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [pardayBtnOne setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    pardayBtnOne.layer.cornerRadius = 6.0f;
    [pardayBtnOne setTag:1];
    [pardayBtnOne addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pardayBtnOne];
    
    perdayLbl= [[UILabel alloc] init];
    [perdayLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    perdayLbl.textAlignment = NSTextAlignmentLeft;
    perdayLbl.text=[NSString stringWithFormat:@"Per day once"];
    perdayLbl.font=fonts;
    [self.view addSubview:perdayLbl];
    
    heights=heights+screenRect.size.height*0.07;

        pardayBtntwo=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
        [pardayBtntwo setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
        [pardayBtntwo setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
        pardayBtntwo.layer.cornerRadius = 6.0f;
        [pardayBtntwo setTag:2];
        [pardayBtntwo addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pardayBtntwo];
        
        perdayLbl= [[UILabel alloc] init];
        [perdayLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
        perdayLbl.textAlignment = NSTextAlignmentLeft;
        perdayLbl.text=[NSString stringWithFormat:@"Per day twice"];
        perdayLbl.font=fonts;
        [self.view addSubview:perdayLbl];
        
        heights=heights+screenRect.size.height*0.07;

        pardayBtnthree=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
        [pardayBtnthree setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
        [pardayBtnthree setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
        pardayBtnthree.layer.cornerRadius = 6.0f;
        [pardayBtnthree setTag:3];
        [pardayBtnthree addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pardayBtnthree];
        
        perdayLbl= [[UILabel alloc] init];
        [perdayLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
        perdayLbl.textAlignment = NSTextAlignmentLeft;
        perdayLbl.text=[NSString stringWithFormat:@"Per day thrice"];
        perdayLbl.font=fonts;
        [self.view addSubview:perdayLbl];
        
        heights=heights+screenRect.size.height*0.07;

        pardayBtnfour=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
        [pardayBtnfour setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
        [pardayBtnfour setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
        pardayBtnfour.layer.cornerRadius = 6.0f;
        [pardayBtnfour setTag:4];
        [pardayBtnfour addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pardayBtnfour];
        
        perdayLbl= [[UILabel alloc] init];
        [perdayLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
        perdayLbl.textAlignment = NSTextAlignmentLeft;
        perdayLbl.text=[NSString stringWithFormat:@"Per day four times"];
        perdayLbl.font=fonts;
        [self.view addSubview:perdayLbl];
        
        heights=heights+screenRect.size.height*0.07;

    parweekBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [parweekBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [parweekBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    parweekBtn.layer.cornerRadius = 6.0f;
    [parweekBtn setTag:5];
    [parweekBtn addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:parweekBtn];
    
    perweekLbl= [[UILabel alloc] init];
    [perweekLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    perweekLbl.textAlignment = NSTextAlignmentLeft;
    perweekLbl.text=[NSString stringWithFormat:@"Per week"];
    perweekLbl.font=fonts;
    [self.view addSubview:perweekLbl];
    
    heights=heights+screenRect.size.height*0.07;
    
    parmonthBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [parmonthBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [parmonthBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    parmonthBtn.layer.cornerRadius = 6.0f;
    [parmonthBtn setTag:6];
    [parmonthBtn addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:parmonthBtn];
    
    permonthLbl= [[UILabel alloc] init];
    [permonthLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    permonthLbl.textAlignment = NSTextAlignmentLeft;
    permonthLbl.text=[NSString stringWithFormat:@"Per month"];
    permonthLbl.font=fonts;
    [self.view addSubview:permonthLbl];
    
    heights=heights+screenRect.size.height*0.07;
    
    asneededBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heights,30,30)];
    [asneededBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
    [asneededBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
    asneededBtn.layer.cornerRadius = 6.0f;
    [asneededBtn setTag:7];
    [asneededBtn addTarget:self action:@selector(redioBtnActionPer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:asneededBtn];
    
    asneededLbl= [[UILabel alloc] init];
    [asneededLbl setFrame:CGRectMake(screenRect.size.width*0.15, heights, screenRect.size.width*0.60, screenRect.size.height*0.04)];
    asneededLbl.textAlignment = NSTextAlignmentLeft;
    asneededLbl.text=[NSString stringWithFormat:@"As needed"];
    asneededLbl.font=fonts;
    [self.view addSubview:asneededLbl];

}
    if ([dosageVO.captionName isEqualToString:@"Per day once"]) {
        pardayBtnOne.selected=YES;
    }if ([dosageVO.captionName isEqualToString:@"Per day twice"]) {
        pardayBtntwo.selected=YES;
    }if ([dosageVO.captionName isEqualToString:@"Per day thrice"]) {
        pardayBtnthree.selected=YES;
    }if ([dosageVO.captionName isEqualToString:@"Per day four times"]) {
        pardayBtnfour.selected=YES;
    }else if ([dosageVO.captionName isEqualToString:@"Per week"]){
        parweekBtn.selected=YES;
    }else if ([dosageVO.captionName isEqualToString:@"Per month"]){
        parmonthBtn.selected=YES;
    }else if ([dosageVO.captionName isEqualToString:@"As needed"]){
        asneededBtn.selected=YES;
        nooftabletTxt.hidden=YES;
        nooftabletTxt.text=@"";
        tabletnameLbl.hidden=YES;
    }
    captionnameStr=dosageVO.captionName;

    heights=heights+screenRect.size.height*0.07;

    SearchBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width*0.30, heights, screenRect.size.width*0.40, screenRect.size.height*0.05)];
    [SearchBtn setBackgroundColor:[UIColor clearColor]];
    SearchBtn.layer.cornerRadius = 6.0f;
    [SearchBtn addTarget:self action:@selector(updateDosageContact:) forControlEvents:UIControlEventTouchUpInside];
    [SearchBtn setTitle:@"Update" forState:UIControlStateNormal];
    [SearchBtn setBackgroundColor:[UIColor colorWithHexString:@"03687F"]];
    [self.view addSubview:SearchBtn];
}
-(void)DeleteDosageContact:(UIButton *)Btn{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Are you sure you want to delete?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil];
    [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"]){
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine deleted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [appDelegate.mainArray removeObjectAtIndex:appDelegate.drugArrayindex];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        [self performSelector:@selector(deleteData) withObject:nil afterDelay:1.0 ];

    }
    if([title isEqualToString:@"OK"]){
        MyRxViewController  *myRXview=[[MyRxViewController alloc] initWithNibName:@"MyRxViewController" bundle:nil];
        [self.navigationController pushViewController:myRXview animated:YES];
    }
}
-(void)deleteData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://192.168.0.33:9830/api/Medicine/DeleteMedicines?UserID=%@&LoginID=%@&SubscriberCode=%@&MedicineId=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"],dosageVO.dosageID];
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    if ([content isEqualToString:@"true"]) {
        [activityImageView removeFromSuperview];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine deleted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [activityImageView removeFromSuperview];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)updateDosageContact:(UIButton *)Btn{
    if ([captionnameStr isEqualToString:@"As needed"]) {
//        DosageVO* dosVO=[[DosageVO alloc]init];
//        dosVO = [appDelegate.mainArray objectAtIndex:appDelegate.drugArrayindex];
//        dosVO.captionName=captionnameStr;
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine Updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
        
        nooftabletTxt=[[UITextField alloc]init];
        tabletnameLbl=[[UILabel alloc]init];
        nooftabletTxt.text=@"1";
        tabletnameLbl.text=@"";

        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        [self performSelector:@selector(updateData) withObject:nil afterDelay:1.0 ];

    }else{
        int nooftab=[nooftabletTxt.text intValue];
        if ([nooftabletTxt.text isEqualToString:@""]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please enter a number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [nooftabletTxt becomeFirstResponder];
        }else if (nooftab<=0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Invalid number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [nooftabletTxt becomeFirstResponder];

        }
        else{
//            DosageVO* dosVO=[[DosageVO alloc]init];
//            dosVO = [appDelegate.mainArray objectAtIndex:appDelegate.drugArrayindex];
//            dosVO.nooftablet=nooftabletTxt.text;
//            dosVO.captionName=captionnameStr;
//            dosVO.timeName=tabletnameLbl.text;
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine Updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
            [self performSelector:@selector(updateData) withObject:nil afterDelay:1.0 ];

        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==nooftabletTxt){
        
        if (nooftabletTxt.text.length >= MAX_LENGTH && range.length == 0)
        {
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }
        
    }
    return YES;
}

-(void)updateData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://192.168.0.33:9830/api/Medicine/UpdateMedicines?UserID=%@&LoginID=%@&SubscriberCode=%@&MedicineId=%@&MedicineName=%@&Quantity=%@&Form=%@&Frequency=%@",[prefs objectForKey:@"UserId"],[prefs objectForKey:@"LoginId"],[prefs objectForKey:@"SubscriberCode"],dosageVO.dosageID,dosageVO.dosageNmae,nooftabletTxt.text,tabletnameLbl.text,captionnameStr];
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    if ([content isEqualToString:@"true"]) {
        [activityImageView removeFromSuperview];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Medicine Updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        //appDelegate.contactsubmitdeleteupdate=true;
        
    }else{
        [activityImageView removeFromSuperview];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Internet Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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
    activityImageView.frame = CGRectMake(
                                         self.view.frame.size.width/2
                                         -35,
                                         self.view.frame.size.height/2
                                         -35,70,
                                         70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
    
}

-(IBAction)redioBtnActionPer:(UIButton *)sender{
    NSLog(@"Button tag %ld",(long)sender.tag);
    switch ([sender tag]) {
        case 1:
            if([pardayBtnOne isSelected]==YES)
            {
                //                [pardayBtn setSelected:NO];
                //                [parweekBtn setSelected:NO];
                //                [parmonthBtn setSelected:NO];
                //                [asneededBtn setSelected:NO];
            }
            else{
                [pardayBtnOne setSelected:YES];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [parweekBtn setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                captionnameStr=@"Per day once";
            }
            break;
        case 2:
            if([pardayBtntwo isSelected]==YES)
            {
                //                [pardayBtn setSelected:NO];
                //                [parweekBtn setSelected:NO];
                //                [parmonthBtn setSelected:NO];
                //                [asneededBtn setSelected:NO];
            }
            else{
                [pardayBtntwo setSelected:YES];
                [pardayBtnOne setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [parweekBtn setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                captionnameStr=@"Per day twice";
            }
            break;
        case 3:
            if([pardayBtnthree isSelected]==YES)
            {
                //                [pardayBtn setSelected:NO];
                //                [parweekBtn setSelected:NO];
                //                [parmonthBtn setSelected:NO];
                //                [asneededBtn setSelected:NO];
            }
            else{
                [pardayBtnthree setSelected:YES];
                [pardayBtntwo setSelected:NO];
                [pardayBtnOne setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [parweekBtn setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                captionnameStr=@"Per day thrice";
            }
            break;
        case 4:
            if([pardayBtnfour isSelected]==YES)
            {
                //                [pardayBtn setSelected:NO];
                //                [parweekBtn setSelected:NO];
                //                [parmonthBtn setSelected:NO];
                //                [asneededBtn setSelected:NO];
            }
            else{
                [pardayBtnfour setSelected:YES];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnOne setSelected:NO];
                [parweekBtn setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                captionnameStr=@"Per day four times";
            }
            break;
            
        case 5:
            if([parweekBtn isSelected]==YES)
            {
                //                [parweekBtn setSelected:NO];
                //                [pardayBtn setSelected:NO];
                //                [parmonthBtn setSelected:NO];
                //                [asneededBtn setSelected:NO];
            }
            else{
                [parweekBtn setSelected:YES];
                [pardayBtnOne setSelected:NO];
                [parmonthBtn setSelected:NO];
                [asneededBtn setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnOne setSelected:NO];
                
                captionnameStr=@"Per week";
            }
            break;
        case 6:
            if([parmonthBtn isSelected]==YES)
            {
                //                [parmonthBtn setSelected:NO];
                //                [pardayBtn setSelected:NO];
                //                [asneededBtn setSelected:NO];
                //                [parweekBtn setSelected:NO];
            }
            else{
                [parmonthBtn setSelected:YES];
                [pardayBtnOne setSelected:NO];
                [asneededBtn setSelected:NO];
                [parweekBtn setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnOne setSelected:NO];
                
                captionnameStr=@"Per month";
            }
            break;
        case 7:
            if([asneededBtn isSelected]==YES)
            {
                //                [asneededBtn setSelected:NO];
                //                [pardayBtn setSelected:NO];
                //                [parmonthBtn setSelected:NO];
                //                [parweekBtn setSelected:NO];
                
            }
            else{
                [asneededBtn setSelected:YES];
                [pardayBtnOne setSelected:NO];
                [parmonthBtn setSelected:NO];
                [parweekBtn setSelected:NO];
                [pardayBtnfour setSelected:NO];
                [pardayBtntwo setSelected:NO];
                [pardayBtnthree setSelected:NO];
                [pardayBtnOne setSelected:NO];
                
                captionnameStr=@"As needed";
                
            }
            break;
    }
    
    if ([captionnameStr isEqualToString:@"As needed"]) {
        nooftabletTxt.hidden=YES;
        nooftabletTxt.text=@"";
        tabletnameLbl.hidden=YES;
    }else{
        nooftabletTxt.hidden=NO;
        tabletnameLbl.hidden=NO;
        if ([dosageVO.dosageNmae rangeOfString:@"SOL"].location != NSNotFound) {
            tabletnameLbl.text=[NSString stringWithFormat:@"%@",@"Drops"];
        }else if ([dosageVO.dosageNmae rangeOfString:@"SYP"].location != NSNotFound){
            tabletnameLbl.text=[NSString stringWithFormat:@"%@",@"Ml"];
        }else if ([dosageVO.dosageNmae rangeOfString:@"TAB"].location != NSNotFound){
            tabletnameLbl.text=[NSString stringWithFormat:@"%@",@"Tablets"];
        }else if ([dosageVO.dosageNmae rangeOfString:@"CAP"].location != NSNotFound){
            tabletnameLbl.text=[NSString stringWithFormat:@"%@",@"Capsules"];
        }else if ([dosageVO.dosageNmae rangeOfString:@"INJ"].location != NSNotFound){
            tabletnameLbl.text=[NSString stringWithFormat:@"%@",@"Injections"];
        }else if ([dosageVO.dosageNmae rangeOfString:@"CON"].location != NSNotFound){
            tabletnameLbl.text=[NSString stringWithFormat:@"%@",@"Ml"];
        }

    }
    if ([nooftabletTxt.text isEqualToString:@""]) {
        nooftabletTxt.text=@"1";
        dosageVO.nooftablet=@"1";
    }
//    else{
//        nooftabletTxt.text=[NSString stringWithFormat:@"%d", [dosageVO.nooftablet intValue]];
//    }

}
-(void)doneWithNumberPad{
    [nooftabletTxt resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
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
-(IBAction)SearcgDrugsClick:(id)sender{

if ([DrugsTxt.text isEqualToString:@""]) {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"Please fill data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}else{
    
    [DrugsTxt resignFirstResponder];
    DrugsFirstListViewController *search=[[DrugsFirstListViewController alloc] initWithNibName:@"DrugsFirstListViewController" bundle:nil];
    search.searchStr=[[NSString alloc]init];
    search.searchStr=DrugsTxt.text;
    [self.navigationController pushViewController:search animated:YES];
}
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
