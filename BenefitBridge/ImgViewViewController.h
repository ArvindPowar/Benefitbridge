//
//  ImgViewViewController.h
//  demo
//
//  Created by Infinitum on 22/06/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ImgViewViewController : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, retain) IBOutlet UIScrollView *scrollFront;
@property (nonatomic, retain) IBOutlet UIImageView *BackImgVw1;
@property (nonatomic, retain) UIImage *image;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageButton;

@end
