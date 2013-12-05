//
//  NKMainViewController.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKMainViewController.h"

@implementation NKMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (IBAction)toggleLeftTouched:(UIButton *)sender
{
    [self.revealViewController revealToggle:nil];
}

- (IBAction)toggleRightTouched:(UIButton *)sender
{
    [self.revealViewController rightRevealToggle:nil];
}

@end
