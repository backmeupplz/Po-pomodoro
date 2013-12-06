//
//  NKTimeIndicatorView.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKTimeIndicatorView.h"

@implementation NKTimeIndicatorView

- (void)pushUp:(int)minutes
{
    UILabel *lab = [self getCopyLabel];
    lab.text = [NSString stringWithFormat:@"%d",minutes];
    [self animateAndDeleteLabel:self.label up:NO];
    [self animateAppearanceOfLabel:lab fromBottom:NO];
    self.label = lab;
}

- (void)pushDown:(int)minutes
{
    UILabel *lab = [self getCopyLabel];
    lab.text = [NSString stringWithFormat:@"%d",minutes];
    [self animateAndDeleteLabel:self.label up:YES];
    [self animateAppearanceOfLabel:lab fromBottom:YES];
    self.label = lab;
}

- (UILabel *)getCopyLabel
{
    UILabel *lab = [[UILabel alloc] initWithFrame:self.label.frame];
    lab.text = self.label.text;
    lab.font = self.label.font;
    lab.textColor = self.label.textColor;
    lab.textAlignment = self.label.textAlignment;
    return lab;
}

- (void)animateAndDeleteLabel:(UILabel *)lab up:(BOOL)up
{
    [UIView animateWithDuration:0.5 animations:^{
        float offset = (up) ? -lab.frame.origin.y : lab.frame.origin.y;
        lab.frame = CGRectOffset(lab.frame, 0, offset);
        
        lab.alpha = 0.0;
    } completion:^(BOOL finished) {
        [lab removeFromSuperview];
    }];
}

- (void)animateAppearanceOfLabel:(UILabel *)lab fromBottom:(BOOL)bottom {
    lab.alpha = 0.0;
    float offset = (bottom) ? lab.frame.origin.y : -lab.frame.origin.y;
    lab.frame = CGRectOffset(lab.frame, 0, offset);
    [self addSubview:lab];
    [UIView animateWithDuration:0.5 animations:^{
        lab.alpha = 1.0;
        lab.frame = CGRectOffset(lab.frame, 0, -offset);
    }];
}

@end
