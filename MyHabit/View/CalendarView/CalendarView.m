//
//  CalendarView.m
//  MyHabit
//
//  Created by MingMingZhang on 16/1/5.
//  Copyright © 2016年 zmm. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarItem.h"

@interface CalendarView ()
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSMutableArray *buttons;  //of UIButton

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CalendarItem *leftCalendarItem;
@property (nonatomic, strong) CalendarItem *centerCalendarItem;
@property (nonatomic, strong) CalendarItem *rightCalendarItem;

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
        
        NSDate *firstday = [self firstDayOfMonth:date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss.SSS"];
        NSLog(@"%@", [formatter stringFromDate:firstday]);
        
        NSLog(@"本月第1天是%d号", 1);
        
    }
    
    return self;
}


#pragma mark - Properties

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height) ;
        _scrollView.contentOffset = CGPointZero;
        _scrollView.bounces = NO;
        _scrollView.clipsToBounds = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _scrollView;
}

-(CalendarItem *)centerCalendarItem
{
    if (!_centerCalendarItem) {
        _centerCalendarItem = [[CalendarItem alloc] init];
        
    }
    
    return _centerCalendarItem;
}

-(NSDate *)currentDate
{
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}

#define kColumns 7
#define kRows 6
#define kCellHeight 20
#define kCellWidth 50

-(CGSize)cellSize
{
    return CGSizeMake(kCellWidth, kCellHeight);
}

-(NSMutableArray *)buttons
{
    if (!_buttons) {
        NSDate *date = [NSDate date];
        int dayOfToday = [self monthday:date];
        int weekdayOfToday = [self weekday:date];
        int weekdayOfFirstDayInAMonth = [self weekday:[self firstDayOfMonth:date]];
        
        _buttons = [[NSMutableArray alloc] initWithCapacity:kColumns * kRows];
        CGSize size = [self cellSize];
        for (int i = 0; i < kRows; i ++) {
            for (int j = 0; j < kColumns; j++) {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(j * size.width, i * size.height, size.width, size.height)];
                
                button.titleLabel.text = @"";
                [_buttons addObject:button];
            }
        }
        
    }
    
    return _buttons;
}

/**
 * 计算所给日期上月第后1天的日期
 */
-(NSDate *)lastestDayOfLastMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitMonth;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    dateComponents.month --;
    return [calendar dateFromComponents:dateComponents];
}

/**
 * 计算所给日期当月第1天的日期
 */
-(NSDate *)firstDayOfMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitDay;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    dateComponents.day = 1;
    return [calendar dateFromComponents:dateComponents];
}

/**
 * 计算所给日期所在月份的第1天是星期几
 *
 */
-(int)weekday:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitDay;
    NSDateComponents  *dateComponent = [calendar components:unitFlags fromDate:date];
    return (int)dateComponent.weekday;
}

/**
 * 计算所给日期所在月份的第几天
 *
 */
-(int)monthday:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitDay;
    NSDateComponents  *dateComponent = [calendar components:unitFlags fromDate:date];
    return (int)dateComponent.day;
}


@end
