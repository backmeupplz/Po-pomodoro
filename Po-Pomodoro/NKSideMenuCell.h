//
//  NKSideMenuCell.h
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKSideMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *pomodoros;

- (void)setNumberOfPomodoro:(int)number;

@end
