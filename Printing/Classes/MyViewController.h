//
//  MyViewController.h
//  Printing
//
//  Created by Tyler Neylon on 1/26/11.
//  Copyleft 2011 Bynomial.
//

#import <UIKit/UIKit.h>

@class UIPrintInteractionController;

@interface MyViewController : UIViewController
{
@private
  UIButton *printButton;
  UIPrintInteractionController *printController;
}
@end