
/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 
*/
#import "RearViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "MyProfileViewController.h"
#import "UpdatePasswordViewController.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "tuche_unlock_ViewController.h"
#import "LoginViewController.h"
#import "MainNavigationController.h"
@interface RearViewController()

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;
@synthesize appDelegate,usernameLabel,displayUserName,userImageView,imageBtn;

#pragma mark - View lifecycle


- (void)viewDidLoad
{
	[super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor=[UIColor colorWithHexString:@"03687F"];
	self.rearTableView.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBarHidden=YES;
    [imageBtn.layer setFrame:CGRectMake(10,13,60,60)];
    [imageBtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:imageBtn];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIImageView *  whiteback=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,screenRect.size.width, 64)];
    [whiteback setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:whiteback];

    UIImageView *  logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(10,15, 200,45)];
    [logoImg setImage:[UIImage imageNamed:@"benefitbridge_logo_with_border.png"]];
    [self.view addSubview:logoImg];

    usernameLabel =[[UILabel alloc]initWithFrame:CGRectMake(20,70,200, 55)];
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    //[usernameLabel setText:[NSString stringWithFormat:@"%@",[homepage objectForKey:@"username"]]];
    //usernameLabel.text=@"Steven Smith";
    usernameLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:18];
    usernameLabel.textColor=[UIColor whiteColor];
    usernameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    usernameLabel.numberOfLines = 0;
    usernameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:usernameLabel];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *name=[prefs objectForKey:@"DisplayName"];
    NSString *lower = [name lowercaseString]; // this will be "hello, world!"
    NSString *fooUpper = [lower capitalizedString];

    usernameLabel.text=fooUpper;

    userImageView=[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 15, 60, 60)];
    [userImageView setBackgroundColor:[UIColor clearColor]];
   // [self.view addSubview:userImageView];

    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSLog(@"appVersionString:-%@",appVersionString);
    
    UILabel *versionLbl = [[UILabel alloc] init];
    [versionLbl setFrame:CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.95,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    versionLbl.textAlignment = NSTextAlignmentLeft;
    [versionLbl setText:[NSString stringWithFormat:@"V %@",appVersionString]];
    [versionLbl setTextColor: [self colorFromHexString:@"#03687f"]];
    UIFont * font11 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
    versionLbl.font=font11;
    [self.view addSubview:versionLbl];


}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if (appDelegate.isLandscapeOK) {
        // for iPhone, you could also return UIInterfaceOrientationMaskAllButUpsideDown
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}



#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
	
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor=[UIColor whiteColor];
	}
    
    UIImageView *menuItemImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10,10,35,35)];
    UILabel *pictureLbl=[[UILabel alloc]initWithFrame:CGRectMake(10,10,35,35)];
    pictureLbl.text = @"";
    pictureLbl.textColor=[UIColor grayColor];

    
    UILabel *menuItemTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 5, 250, 45)];
    menuItemTextLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:16];
    menuItemTextLabel.textColor=[UIColor colorWithHexString:@"03687F"];
    cell.backgroundColor=[UIColor clearColor];
	if (row == 0)
	{
        menuItemImageView.image=[UIImage imageNamed:@"home.png"];
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf015";

		menuItemTextLabel.text = @"Home";
    }
//	else if (row == 1)
//	{
//		menuItemImageView.image=[UIImage imageNamed:@"password.png"];
//        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
//        pictureLbl.text = @"\uf0eb";
//
//		menuItemTextLabel.text = @"Update Password";
//	}
	else if (row == 1)
	{
        menuItemImageView.image=[UIImage imageNamed:@"user.png"];
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf015";
        
        menuItemTextLabel.text = @"My Profile";
    }else if (row == 2)
    {
        menuItemImageView.image=[UIImage imageNamed:@"log_out.png"];
        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
        pictureLbl.text = @"\uf083";
        
        menuItemTextLabel.text = @"Sign out";
    }
    [cell.contentView addSubview:menuItemImageView];
    [cell.contentView addSubview:menuItemTextLabel];
   // [cell.contentView addSubview:pictureLbl];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    NSInteger row = indexPath.row;
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=(int)row;
    MainNavigationController *navController = [[MainNavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    }



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
    [_rearTableView reloadData];
}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}

@end