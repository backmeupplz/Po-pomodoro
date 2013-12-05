//
//  NKTimerLabel.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKTimerLabel.h"
#import "NSString+Time.h"

@implementation NKTimerLabel {
    NSTimer *timer;
}

#pragma mark - View life cycle -

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self startCountDown];
}

#pragma mark - General methods -

- (void)startCountDown
{
    if (!timer.isValid)
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(decrementByOneSecond) userInfo:nil repeats:YES];
}

- (void)stopCountDown
{
    [timer invalidate];
}

- (void)decrementByOneSecond
{
    int time = [self.text seconds];
    time--;
    int hours = time/3600;
    time %= 3600;
    int minutes = time / 60;
    int seconds = time % 60;
    self.text = [NSString stringFromHours:hours minutes:minutes seconds:seconds];
}

@end
