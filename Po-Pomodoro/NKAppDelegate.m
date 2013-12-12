//
//  NKAppDelegate.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKAppDelegate.h"
#import "GAI.h"
#import "SWRevealViewController.h"
#import "NKMainViewController.h"

@implementation NKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize user defaults
    [self initializeUserDefaults];
    
    // Initialize Google Analytics
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-43367175-5"];
    
    // App is always active
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    return YES;
}

- (void)initializeUserDefaults
{
    if (![userDefaults objectForKey:wasLaunchedBefore]) {
        [userDefaults setObject:@YES forKey:wasLaunchedBefore];
        
        [userDefaults setObject:@[] forKey:pomodoroHistory];
    }
    
    [userDefaults setObject:nil forKey:@"timestamp"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [(NKMainViewController *)[(SWRevealViewController *)self.window.rootViewController frontViewController] scheduleLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [(NKMainViewController *)[(SWRevealViewController *)self.window.rootViewController frontViewController] restoreTimers];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
