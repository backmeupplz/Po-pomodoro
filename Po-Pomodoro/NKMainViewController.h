//
//  NKMainViewController.h
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "NKTimerLabel.h"

@interface NKMainViewController : UIViewController <SWRevealViewControllerDelegate>

// UI properties
@property (weak, nonatomic) IBOutlet NKTimerLabel *timerLabel;

- (IBAction)toggleLeftTouched:(UIButton *)sender;
- (IBAction)toggleRightTouched:(UIButton *)sender;

@end
