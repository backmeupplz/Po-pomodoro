//
//  NKTimeIndicatorView.h
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKTimeIndicatorView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;

- (void)pushUp:(int)minutes;
- (void)pushDown:(int)minutes;

@end
