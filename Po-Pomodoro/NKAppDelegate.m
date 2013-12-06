//
//  NKAppDelegate.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKAppDelegate.h"

@implementation NKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeUserDefaults];
    return YES;
}

- (void)initializeUserDefaults {
    if (![userDefaults objectForKey:wasLaunchedBefore]) {
        [userDefaults setObject:@YES forKey:wasLaunchedBefore];
        
        [userDefaults setObject:@[] forKey:pomodoroHistory];
    }
}

@end
