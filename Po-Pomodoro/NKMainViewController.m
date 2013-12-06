//
//  NKMainViewController.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKMainViewController.h"
#import "NSString+Time.h"

@implementation NKMainViewController {
    NSTimer *timer;
}

#pragma mark - View Controller life cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.timerLabel.initialValue = @"25:00";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.timerCircle.reverse = YES;
    
    [self decrementTimer];
    [self startCountDown];
}

#pragma mark - Buttons methods -

- (IBAction)toggleLeftTouched:(UIButton *)sender
{
    [self.revealViewController revealToggle:nil];
}

- (IBAction)sliderChanged:(UISlider *)sender
{
    // Change circle
    self.timerCircle.percent = sender.value;
    
    // Change text label
    float seconds = [self.timerLabel.initialValue seconds];
    seconds = seconds - (seconds * sender.value/100.0f);
    self.timerLabel.text = [NSString stringFromSeconds:seconds];
}

#pragma mark - General methods -

- (void)startCountDown
{
    if (!timer.isValid)
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer) userInfo:nil repeats:YES];
}

- (void)stopCountDown
{
    [timer invalidate];
}

- (void)decrementTimer
{
    [self.timerLabel decrementByOneSecond];
    [self checkTimerValue];
}

- (void)checkTimerValue
{
    float currentTime = [self.timerLabel.text seconds];
    float initialTime = [self.timerLabel.initialValue seconds];
    float value = currentTime / initialTime;
    
    self.slider.value = (1.0f-value)*100.0f;
    self.timerCircle.percent = (1.0f-value)*100.0f;
}

@end
