//
//  NKTimerLabel.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKTimerLabel.h"
#import "NSString+Time.h"

@implementation NKTimerLabel

@synthesize initialValue;

#pragma mark - Accessors -

- (void)setInitialValue:(NSString *)newInitialValue {
    initialValue = newInitialValue;
    self.text = newInitialValue;
}

#pragma mark - View life cycle -

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - General methods -

- (void)decrementByOneSecond
{
    int time = [self.text seconds];
    if (time > 0) {
        time--;
        self.text = [NSString stringFromSeconds:time];
    }
}

@end
