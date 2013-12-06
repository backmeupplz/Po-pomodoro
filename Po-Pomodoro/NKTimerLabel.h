//
//  NKTimerLabel.h
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NKTimerLabelDelegate <NSObject>

- (void)timerLabelDidReachZero;

@end

@interface NKTimerLabel : UILabel

@property (strong, nonatomic) NSString *initialValue;
@property (weak, nonatomic) IBOutlet id<NKTimerLabelDelegate> delegate;

- (void)decrementByOneSecond;

@end