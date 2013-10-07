//
//  AppDelegate.h
//  Pathology
//
//  Created by Harpreet Singh on 04/10/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController *navController;

@end
