//
//  AppDelegate.h
//  iOS 6 JSON Example
//
//  Created by Christopher Kuhn on 1/19/13.
//  Copyright (c) 2013 Christopher Kuhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
