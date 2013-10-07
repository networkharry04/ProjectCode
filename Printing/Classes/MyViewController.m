//
//  MyViewController.m
//  Printing
//
//  Created by Tyler Neylon on 1/26/11.
//  Copyleft 2011 Bynomial.
//

#import "MyViewController.h"

#import "UIView+Position.h"

#define kPDFPageBounds CGRectMake(0, 0, 8.5 * 72, 11 * 72)

// Declare private methods
@interface MyViewController ()

- (void)setupPrintButton;
- (void)setupCantPrintLabel;
- (void)printTapped;
- (NSData *)generatePDFDataForPrinting;
- (void)drawStuffInContext:(CGContextRef)ctx;

@end


@implementation MyViewController

- (void)loadView {
  self.view = [[UIView new] autorelease];
  self.view.frame = [[UIScreen mainScreen] applicationFrame];
 
  Class printControllerClass = NSClassFromString(@"UIPrintInteractionController");
  if (printControllerClass) {
    printController = [printControllerClass sharedPrintController];
    [self setupPrintButton];
  } else {
    [self setupCantPrintLabel];
  }
}

#pragma mark private methods

- (void)setupPrintButton {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frameSize = CGSizeMake(200, 100);
  [button setTitle:@"print!!" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(printTapped)
   forControlEvents:UIControlEventTouchUpInside];
  [self.view addCenteredSubview:button];
}

- (void)setupCantPrintLabel {
  UILabel *label = [[UILabel new] autorelease];
  label.frameSize = CGSizeMake(200, 100);
  label.text = @"printing not supported :(";
  label.textAlignment = UITextAlignmentCenter;
  [self.view addCenteredSubview:label];
}

- (void)printTapped {  
  void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
  ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
    if (!completed && error) NSLog(@"Print error: %@", error);
  };
  
  NSData *pdfData = [self generatePDFDataForPrinting];
  printController.printingItem = pdfData;
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    [printController presentFromRect:printButton.frame inView:printButton.superview
                            animated:YES completionHandler:completionHandler];
  } else {
    [printController presentAnimated:YES completionHandler:completionHandler];
  }
}

- (NSData *)generatePDFDataForPrinting {
  NSMutableData *pdfData = [NSMutableData data];
  UIGraphicsBeginPDFContextToData(pdfData, kPDFPageBounds, nil);
  UIGraphicsBeginPDFPage();
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  [self drawStuffInContext:ctx];  // Method also usable from drawRect:.
  UIGraphicsEndPDFContext();
  return pdfData;
}

- (void)drawStuffInContext:(CGContextRef)ctx {
  UIFont *font = [UIFont fontWithName:@"Zapfino" size:48];
  CGRect textRect = CGRectInset(kPDFPageBounds, 36, 36);
  [@"hello world!" drawInRect:textRect withFont:font];
}

@end
