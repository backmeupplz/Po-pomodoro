//
//  NKMainViewController.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKMainViewController.h"
#import "NSString+Time.h"
#import <AVFoundation/AVFoundation.h>

@implementation NKMainViewController {
    NSTimer *timer;
    
    NSArray *pomodoro;
    
    int currentPomodoro;
    
    BOOL isSoundOn;
    
    AVAudioPlayer *sound;
}

#pragma mark - View Controller life cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add gr for side view
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Setup cycle
    pomodoro = @[@"25", @"5", @"25", @"5", @"25", @"5", @"25", @"30"];
    
    // Set initial value
    self.timerLabel.initialValue = [NSString stringWithFormat:@"%@:00",pomodoro[currentPomodoro]];
    
    // GA tracking
    self.screenName = @"Main Screen";
    
    // Setup sound
    isSoundOn = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isSoundOn"] boolValue];
    self.soundButton.selected = !isSoundOn;
    
    // Setup audio
    NSError *error = nil;
    NSURL *url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sound" ofType:@"wav"]];
    sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [sound prepareToPlay];
}

#pragma mark - NKTimerLabelDelegate -

- (void)timerLabelDidReachZero
{
    if (currentPomodoro % 2 == 0)
        [self addPomodoroToHistory];
    if (isSoundOn)
        [sound play];
    [self downTouched:nil];
}

#pragma mark - Buttons methods -

- (IBAction)screenTapped:(id)sender
{
    [self hideToolbar:(self.toolbar.alpha)];
}

- (IBAction)upTouched:(UIButton *)sender
{
    [self prevTask];
    [self.timeIndicator pushUp:[pomodoro[currentPomodoro] intValue]];
}

- (IBAction)downTouched:(UIButton *)sender
{
    [self nextTask];
    [self.timeIndicator pushDown:[pomodoro[currentPomodoro] intValue]];
}

- (IBAction)toggleLeftTouched:(UIButton *)sender
{
    [self.revealViewController revealToggle:nil];
}

- (IBAction)soundTouched:(UIButton *)sender
{
    sender.selected = !sender.selected;
    isSoundOn = !sender.selected;
    [[NSUserDefaults standardUserDefaults] setObject:@(isSoundOn) forKey:@"isSoundOn"];
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

- (IBAction)stopTouched:(UIButton *)sender
{
    self.timerLabel.text = self.timerLabel.initialValue;
    [self checkTimerValue];
}

- (IBAction)pauseTouched:(UIButton *)sender
{
    [self stopCountDown];
    self.playButton.hidden = NO;
    sender.hidden = YES;
}

- (IBAction)playTouched:(UIButton *)sender
{
    [self startCountDown];
    self.pauseButton.hidden = NO;
    sender.hidden = YES;
}

- (IBAction)nextTouched:(UIButton *)sender
{
    [self downTouched:nil];
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

- (void)hideToolbar:(BOOL)hide
{
    if (!hide)
        self.toolbar.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.toolbar.alpha = (hide) ? 0.0 : 1.0;
    } completion:^(BOOL finished) {
        if (hide)
            self.toolbar.hidden = YES;
    }];
}

- (void)nextTask
{
    currentPomodoro++;
    if (currentPomodoro >= pomodoro.count) currentPomodoro = 0;
    self.timerLabel.initialValue = [NSString stringWithFormat:@"%@:00",pomodoro[currentPomodoro]];
    self.timerCircle.reverse = (currentPomodoro % 2 == 1);
    [self checkTimerValue];
}

- (void)prevTask
{
    currentPomodoro--;
    if (currentPomodoro < 0) currentPomodoro = pomodoro.count - 1;
    self.timerLabel.initialValue = [NSString stringWithFormat:@"%@:00",pomodoro[currentPomodoro]];
    self.timerCircle.reverse = (currentPomodoro % 2 == 1);
    [self checkTimerValue];
}

- (void)addPomodoroToHistory
{
    NSMutableArray *array = [[userDefaults objectForKey:pomodoroHistory] mutableCopy];
    [array addObject:@([[NSDate date] timeIntervalSince1970])];
    [userDefaults setObject:array forKey:pomodoroHistory];
}

- (void)scheduleLocalNotifications
{
    if (!self.playButton.hidden)
        return;
    
    int secondsBeforeFire = [self.timerLabel.text seconds];
    
    for (int j = 0; j < 8; j++) {
        for (int i = currentPomodoro; i < pomodoro.count; i++) {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:secondsBeforeFire];
            
            notification.alertBody = (i % 2 == 0) ? @"Great work! Time to have a rest" : @"It's time to work!";
            if (isSoundOn)
                notification.soundName = @"sound.wav";
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            
            secondsBeforeFire += [[pomodoro[i] stringByAppendingString:@":00"] seconds];
        }
        
        for (int i = 0; i < currentPomodoro; i++) {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:secondsBeforeFire];
            notification.alertBody = (i % 2 == 0) ? @"Great work! Time to have a rest" : @"It's time to work!";
            if (isSoundOn)
                notification.soundName = @"sound.wav";
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            
            secondsBeforeFire += [[pomodoro[i] stringByAppendingString:@":00"] seconds];
        }
    }
    
    [self saveTimers];
}

- (void)saveTimers
{
    [userDefaults setObject:@([[NSDate date] timeIntervalSince1970]) forKey:@"timestamp"];
}

- (void)restoreTimers
{
    if (![userDefaults objectForKey:@"timestamp"]) return;
    
    int interval = [[NSDate date] timeIntervalSince1970] - [[userDefaults objectForKey:@"timestamp"] intValue];
}

#pragma mark - Rotation -

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (!IPAD)
    {
        if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            [self hideToolbar:YES];
            self.tapGR.enabled = NO;
        } else {
            [self hideToolbar:NO];
            self.tapGR.enabled = YES;
        }
    }
}

@end
