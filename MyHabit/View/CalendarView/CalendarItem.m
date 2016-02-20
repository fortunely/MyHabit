//
//  CalendarItem.m
//  MyHabit
//
//  Created by MingMingZhang on 16/1/22.
//  Copyright © 2016年 zmm. All rights reserved.
//

#import "CalendarItem.h"

@interface CalendarItem ()

@property (nonatomic, retain) NSDate *date;

@end

@implementation CalendarItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame withDate:(NSDate *)date
{
    if (self = [super initWithFrame:frame]) {
        self.date = date;
    }
    
    return self;
}

@end
