//
//  NSString+Time.h
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)

+ (NSString *)stringFromHours:(int)hours minutes:(int)minutes seconds:(int)seconds;
+ (NSString *)stringFromSeconds:(int)seconds;
- (int)seconds;

@end
