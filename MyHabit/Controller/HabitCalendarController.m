//
//  HabitCalendarController.m
//  MyHabit
//
//  Created by MingMingZhang on 15/12/27.
//  Copyright © 2015年 zmm. All rights reserved.
//

#import "HabitCalendarController.h"
#import "CalendarView.h"

@interface HabitCalendarController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *currentView;
@property (strong, nonatomic) UIView *rightView;

@property (strong, nonatomic) CalendarView *calendarView;

@end

@implementation HabitCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"begin");
    
    [self.scrollView addSubview:self.currentView];
    [self.currentView addSubview:self.calendarView];
    
}

-(UIView *)leftView
{
    if (!_leftView) {
        CGRect frame = CGRectMake(-self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        _leftView = [[UIView alloc] initWithFrame:frame];
    }
    
    return _leftView;
}

-(UIView *)currentView
{
    if (!_currentView) {
        CGRect frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        _currentView = [[UIView alloc] initWithFrame:frame];
    }
    
    return _currentView;
}

-(UIView *)rightView
{
    if (!_rightView) {
        CGRect frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        _rightView = [[UIView alloc] initWithFrame:frame];
    }
    
    return _rightView;
}

-(CalendarView *)calendarView
{
    if (!_calendarView) {
        NSDate *date = [NSDate date];
        _calendarView = [[CalendarView alloc] initWithFrame:self.currentView.frame currentDate:date];
    }
    
    return _calendarView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
