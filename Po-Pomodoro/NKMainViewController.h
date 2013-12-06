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
#import "NKTimerCircle.h"

@interface NKMainViewController : UIViewController <SWRevealViewControllerDelegate>

// UI properties
@property (weak, nonatomic) IBOutlet NKTimerLabel *timerLabel;
@property (weak, nonatomic) IBOutlet NKTimerCircle *timerCircle;
@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)toggleLeftTouched:(UIButton *)sender;

- (IBAction)sliderChanged:(UISlider *)sender;

@end
