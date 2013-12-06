//
//  NKTimeSlider.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKTimeSlider.h"

@implementation NKTimeSlider

@synthesize reverse;

#pragma mark - Accessors -

- (BOOL)reverse
{
    return reverse;
}

- (void)setReverse:(BOOL)newReverse
{
    reverse = newReverse;
    self.maximumTrackTintColor = (reverse) ? [UIColor redColor] : [UIColor blackColor];
    self.minimumTrackTintColor = (reverse) ? [UIColor blackColor] : [UIColor redColor];
}

@end
