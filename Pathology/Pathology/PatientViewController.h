//
//  PatientViewController.h
//  Pathology
//
//  Created by Harpreet Singh on 04/10/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientViewController : UIViewController <UITextFieldDelegate, ZBarReaderDelegate>
{
    IBOutlet UITextField *txt_patientID;
    IBOutlet UIImageView *imgView;
    
}
-(IBAction)ActionClicked:(id)sender;


@end
