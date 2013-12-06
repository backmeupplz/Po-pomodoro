//
//  NKTimerCircle.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKTimerCircle.h"
#define lineWidth 10.0

@implementation NKTimerCircle {
    UIColor *color;
}

@synthesize percent;

#pragma mark - Accessors -

- (void)setPercent:(float)newPercent {
    percent = newPercent;
    [self setNeedsDisplay];
}

- (float)percent {
    return percent;
}

#pragma mark - View life cycle -

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    color = self.backgroundColor;
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.width/2-lineWidth/2, 0, 2*M_PI, YES);
    CGContextClosePath(context);
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetLineWidth(context, lineWidth/2);
    CGContextBeginPath(context);
    float start = (self.reverse) ? 3*M_PI_2 : 2*M_PI*(percent/100.0f)-M_PI_2;
    float end = (self.reverse) ? 2*M_PI*(percent/100.0f)-M_PI_2 : -M_PI_2;
        
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.width/2-lineWidth/2, start, end, YES);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
