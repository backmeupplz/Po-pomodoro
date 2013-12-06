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
#import "NKTimeIndicatorView.h"
#import "NKTimeSlider.h"

@interface NKMainViewController : UIViewController <SWRevealViewControllerDelegate, NKTimerLabelDelegate>

// UI properties
@property (weak, nonatomic) IBOutlet UIView *toolbar;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGR;

@property (weak, nonatomic) IBOutlet NKTimerLabel *timerLabel;
@property (weak, nonatomic) IBOutlet NKTimerCircle *timerCircle;
@property (weak, nonatomic) IBOutlet NKTimeSlider *slider;

@property (weak, nonatomic) IBOutlet NKTimeIndicatorView *timeIndicator;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)screenTapped:(id)sender;

- (IBAction)upTouched:(UIButton *)sender;
- (IBAction)downTouched:(UIButton *)sender;

- (IBAction)toggleLeftTouched:(UIButton *)sender;
- (IBAction)sliderChanged:(UISlider *)sender;

- (IBAction)stopTouched:(UIButton *)sender;
- (IBAction)pauseTouched:(UIButton *)sender;
- (IBAction)playTouched:(UIButton *)sender;
- (IBAction)nextTouched:(UIButton *)sender;

@end
