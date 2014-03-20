//
//  NKSideViewController.m
//  Po-Pomodoro
//
//  Created by Nikita Kolmogorov on 05.12.13.
//  Copyright (c) 2013 Nikita Kolmogorov. All rights reserved.
//

#import "NKSideViewController.h"
#import "NKSideMenuCell.h"

@implementation NKSideViewController {
    NSArray *data;
}

#pragma mark - View Controller life cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenName = @"Side Screen";
    
    data = [self getDataFromRaw:[userDefaults objectForKey:pomodoroHistory]];
    [self startObserving];
}

#pragma mark - KVO -

- (void)startObserving
{
    [userDefaults addObserver:self forKeyPath:pomodoroHistory options:NSKeyValueObservingOptionNew context:nil];
}

- (void)stopObserving
{
    [userDefaults removeObserver:self forKeyPath:pomodoroHistory];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    data = [self getDataFromRaw:change[NSKeyValueChangeNewKey]];
    [self.table reloadData];
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (NKSideMenuCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *string = @"dateCell";
    NKSideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    cell.titleLabel.text = data[indexPath.row][@"time"];
    [cell setNumberOfPomodoro:[data[indexPath.row][@"count"] intValue]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UITableViewDelegate -

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deletePomodoroAtRow:indexPath.row];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - General methods -

- (NSArray *)getDataFromRaw:(NSArray *)raw
{
    // Get mutable reverse array from input
    NSMutableArray *array = [[[raw reverseObjectEnumerator] allObjects] mutableCopy];
    
    // Prepare variable to return
    NSMutableArray *result = [NSMutableArray array];
    
    // Get formatter
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    for (NSNumber *time in array) {
        NSString *string = [formatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:time.intValue]];
        if (!result.count) {
            [result addObject:@{@"time" : string, @"count" : @1}];
        } else {
            if ([result[result.count-1][@"time"] isEqualToString:string]) {
                NSMutableDictionary *dict = [result[result.count-1] mutableCopy];
                dict[@"count"] =  @([dict[@"count"] intValue] + 1);
                [result replaceObjectAtIndex:result.count-1 withObject:dict];
            } else {
                [result addObject:@{@"time" : string, @"count" : @1}];
            }
        }
    }
    
    return result;
}

- (void)deletePomodoroAtRow:(int)row
{
    // Get defaults
    NSMutableArray *defaults = [[userDefaults objectForKey:pomodoroHistory] mutableCopy];
    
    // Get required time
    NSString *time = data[row][@"time"];
    
    // Make a formatter
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Prepare a dummy array to store numbers to delete
    NSMutableArray *toDelete = [NSMutableArray array];
    
    // Get numbers to delete
    for (NSNumber *timeNumber in defaults) {
        NSString *timeString = [formatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:timeNumber.intValue]];
        if ([timeString isEqualToString:time])
            [toDelete addObject:timeNumber];
    }
    
    // Delete numbers
    [defaults removeObjectsInArray:toDelete];
    
    // Save defaults
    [userDefaults setObject:defaults forKey:pomodoroHistory];
}

@end
