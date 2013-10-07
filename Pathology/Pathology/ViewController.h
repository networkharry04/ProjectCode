//
//  ViewController.h
//  Pathology
//
//  Created by Harpreet Singh on 04/10/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, ZBarReaderDelegate>
{
    IBOutlet UITextField *txt_username;
    IBOutlet UITextField *txt_password;
    
    IBOutlet UIButton *btn_rememberme;
    IBOutlet UIButton *btn_login;
    IBOutlet UIButton *btn_loginbarcode;
    BOOL userCheckedForRememebrMe;
    UIImageView *resultImage;
}
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;

@property (nonatomic, strong) IBOutlet UITextField *txt_username;
@property (nonatomic, strong) IBOutlet UITextField *txt_password;

-(IBAction)remembermeClicked:(id)sender;
-(IBAction)LoginClicked:(id)sender;
-(IBAction)ScanBarcodeClicked:(id)sender;

@end
