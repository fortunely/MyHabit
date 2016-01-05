//
//  CalendarView.m
//  MyHabit
//
//  Created by MingMingZhang on 16/1/5.
//  Copyright © 2016年 zmm. All rights reserved.
//

#import "CalendarView.h"

@interface CalendarView ()
@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation CalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame currentDate:(NSDate *)date
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.currentDate = date;
    }
    
    return self;
}


#pragma mark - Properties

-(NSDate *)currentDate
{
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}

@end
