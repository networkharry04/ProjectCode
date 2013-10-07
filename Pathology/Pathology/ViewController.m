//
//  ViewController.m
//  Pathology
//
//  Created by Harpreet Singh on 04/10/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import "ViewController.h"
#import "PatientViewController.h"

int flag=0;

#define MAXUsr_LENGTH 10
#define MAXPwd_Length 6

#if TARGET_IPHONE_SIMULATOR
NSString * const DeviceIs = @"Simulator";
#else
NSString * const DeviceIs = @"Device";
#endif

int rememberMeChecked=1;

@interface ViewController ()

@end

@implementation ViewController

@synthesize txt_password, txt_username;
@synthesize resultImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden=YES;
    
    NSUserDefaults *saveLoginCredentials=[NSUserDefaults standardUserDefaults];
    if([saveLoginCredentials valueForKey:@"username"])
    {
        txt_username.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        txt_password.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        [saveLoginCredentials synchronize];
        [btn_rememberme setImage:[UIImage imageNamed:@"remember-me-check.png"] forState:UIControlStateNormal];
        rememberMeChecked=1;
        userCheckedForRememebrMe = YES;
    }
    
    if (([txt_username.text length]!=0) && ([txt_password.text length]!=0))
    {
        
    }    
}

-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=YES;
    
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] != nil)
    {
        txt_username.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    }
    else
    {
        txt_username.text = @"";
        txt_username.placeholder = @"Enter username";
    }
        
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"password"] != nil)
    {
        txt_password.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
    else
    {
        txt_password.text = @"";
        txt_password.placeholder = @"Enter password";
    }
}

-(IBAction)remembermeClicked:(id)sender
{
    //If user entered the login details then save the values in user defaults
	if(txt_username.text.length!=0  || txt_password.text.length!=0 )
	{
        
		if (rememberMeChecked==1)
		{
			[btn_rememberme setImage:[UIImage imageNamed:@"remember-me-check.png"] forState:UIControlStateNormal];
            
            //User has checked for remember me option
            userCheckedForRememebrMe = YES;
            rememberMeChecked=0;
            
		}
        
        else if(rememberMeChecked==0)
        {
            [btn_rememberme setImage:[UIImage imageNamed:@"checkbox-without-check.png"] forState:UIControlStateNormal];
            
            txt_username.placeholder = @"Enter username";
            txt_password.placeholder = @"Enter password";
            
            //User has bot checked for remember me option
            userCheckedForRememebrMe = NO;
            rememberMeChecked=1;
        }
	}
    //User has not entered any value, show him/her an alert message
	else
	{
		[btn_rememberme setImage:[UIImage imageNamed:@"checkbox-without-check.png"] forState:UIControlStateNormal];
        
        //User has bot checked for remember me option
        userCheckedForRememebrMe = NO;
		
		UIAlertView *loginalert= [[UIAlertView alloc]
								  initWithTitle:nil message:@"Please enter your Username and Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[loginalert show];
		
	}

}

-(IBAction)LoginClicked:(id)sender
{
    if(txt_username.text.length==0  || txt_password.text.length==0 )
	{
		UIAlertView *alert =[[UIAlertView alloc]
                             initWithTitle:@"Please Enter Username and Password" message:nil
                             delegate:self
                             cancelButtonTitle:@"Ok"
                             otherButtonTitles:nil];
		[alert show];
	}
	else
	{
        //If user checked for rememebr me, then save the values in user default
        if (userCheckedForRememebrMe == YES)
        {
            [[NSUserDefaults standardUserDefaults] setObject:txt_username.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:txt_password.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            PatientViewController *PVC = [[PatientViewController alloc] initWithNibName:@"PatientViewController" bundle:nil];
            [self.navigationController pushViewController:PVC animated:YES];
            
        }
        else
        {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"] != nil)
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
            }
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"password"] != nil)
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                
            }
        }
        
//        [self.view addSubview:loadingView];
//        self.view.userInteractionEnabled=NO;
//        [self getLoginAccess];
        
    }
}

-(IBAction)ScanBarcodeClicked:(id)sender
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    //    [self presentViewController:[reader animated:YES completion:nil];
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    NSLog(@"result text %@", symbol.data);
    
    // EXAMPLE: do something useful with the barcode image
    //resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
 
 [txt_username resignFirstResponder];
 [txt_password resignFirstResponder];
  
 return YES;
    
 }
 
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == txt_username)
	{
		
	}
	if (textField == txt_password)
	{
        
	}
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
// return YES;
// }

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
