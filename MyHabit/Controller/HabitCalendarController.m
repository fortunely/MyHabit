//
//  HabitCalendarController.m
//  MyHabit
//
//  Created by MingMingZhang on 15/12/27.
//  Copyright © 2015年 zmm. All rights reserved.
//

#import "HabitCalendarController.h"

@interface HabitCalendarController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *currentView;
@property (strong, nonatomic) UIView *rightView;

@end

@implementation HabitCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(UIView *)leftView
{
    if (!_leftView) {
        CGRect frame = CGRectMake(-self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        _leftView = [[UIView alloc] initWithFrame:frame];
        [self.scrollView addSubview:_leftView];
    }
    return _leftView;
}

-(UIView *)currentView
{
    if (!_currentView) {
        CGRect frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        _currentView = [[UIView alloc] initWithFrame:frame];
        [self.scrollView addSubview:_currentView];
    }
    return _currentView;
}

-(UIView *)rightView
{
    if (!_rightView) {
        CGRect frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        _rightView = [[UIView alloc] initWithFrame:frame];
        [self.scrollView addSubview:_currentView];
    }
    return _rightView;
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
