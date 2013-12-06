//
//  NSString+Time.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

+ (NSString *)stringFromHours:(int)hours minutes:(int)minutes seconds:(int)seconds
{
    if (hours) {
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
    } else {
        return [NSString stringWithFormat:@"%02d:%02d",minutes,seconds];
    }
}

+ (NSString *)stringFromSeconds:(int)seconds
{
    int hours = seconds/3600;
    seconds %= 3600;
    int minutes = seconds / 60;
    int inSeconds = seconds % 60;
    return [NSString stringFromHours:hours minutes:minutes seconds:inSeconds];
}

- (int)seconds
{
    // Initialize variables
    NSRange range;
    int hours = 0;
    NSString *temp = self;
    
    // Check if hours included
    if (self.length > 5) {
        // Get hours
        range = [self rangeOfString:@":"];
        hours = [self substringToIndex:range.location].intValue;
        // Cut off hours
        temp = [self substringFromIndex:range.location+range.length];
    }
    
    // Get minutes
    range = [temp rangeOfString:@":"];
    int minutes = [temp substringToIndex:range.location].intValue;
    
    // Get seconds
    int seconds = [temp substringFromIndex:range.location+range.length].intValue;
    
    // Return seconds
    return (hours * 3600) + (minutes * 60) + seconds;
}

@end
