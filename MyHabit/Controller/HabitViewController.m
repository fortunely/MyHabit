//
//  HabitViewController.m
//  MyHabit
//
//  Created by MingMingZhang on 15/12/16.
//  Copyright © 2015年 zmm. All rights reserved.
//

#import "HabitViewController.h"

#define COLOR_TOMATO    [UIColor colorWithRed:255/255.0f green:99/255.0f blue:71/255.0f alpha:1.0f]     /*!< 番茄色*/

#define ScreenSize [UIScreen mainScreen].bounds.size

#define NumberOfDaysInAWeek    7

#define WeeksTitleBoxHeight  20.0f

#define CURRENT_WEEKDAY_COLOR    [UIColor yellowColor]
#define DEFAULT_WEEKDAY_COLOR    [UIColor whiteColor]

@interface HabitViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *thisWeekContentView;

@property (strong, nonatomic) UIView *weekNamesContentView;
@property (strong, nonatomic) UIView *weekDaysContentView;

@property (strong, nonatomic) NSMutableArray *weekNamesLabel; // of UILabel
@property (strong, nonatomic) NSMutableArray *weekDaysLabel;  // of UILabel

@property (assign, nonatomic) NSUInteger todaysDayInWeek;

@property (strong, nonatomic) NSArray *weekdayNamesArray;//of String

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation HabitViewController

static NSString *tableCellIdentifier = @"Habit Table Cell";

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateUI];
    
    UINib *nib = [UINib nibWithNibName:@"HabitTableCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:tableCellIdentifier];
}


#pragma mark - UI settings
-(void)updateUI
{
    NSLog(@"updateUI");
    self.navigationController.navigationBar.barTintColor = COLOR_TOMATO;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.thisWeekContentView.backgroundColor = COLOR_TOMATO;
    
    [self.thisWeekContentView addSubview:self.weekNamesContentView];
    [self.thisWeekContentView addSubview:self.weekDayContentView];
    
}

-(CGSize)sizeOfSubTitleBox
{
    CGFloat width = ScreenSize.width / NumberOfDaysInAWeek;
    return CGSizeMake(width, WeeksTitleBoxHeight);
}

/**
 *  按一周中的第几天读取周几名称
 *  @param weekday 一周中的第几天，范围：1~7
 *  @return 返回周几名称
 */
-(NSString *)weekNames:(int)weekday
{
    if (weekday >0 && weekday <= self.weekdayNamesArray.count) {
        return self.weekdayNamesArray[weekday-1];
    }
    return nil;
}

typedef struct{
    int weekday;
    int day;
}WeekdayType;

/**
 * 计算与基准日期date相隔dayInterval天数的日期号
 * @param dayInterval 相隔天数
 * @param [in] date 基准日期
 */
-(NSUInteger)day:(NSUInteger)dayInterval sinceDate:(NSDate *)date
{
    NSDate *dstDay = [NSDate dateWithTimeInterval:dayInterval*24*60*60 sinceDate:date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitWeekday | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:dstDay];
    return dateComponent.day;
}

/**
 * 计算与基准日期date相隔dayInterval天数的日期
 * @param dayInterval 相隔天数
 * @param [in] date 基准日期
 */
-(WeekdayType)weekDay:(NSUInteger)dayInterval sinceDate:(NSDate *)date
{
    WeekdayType weekDay = {0};
    NSDate *dstDay = [NSDate dateWithTimeInterval:dayInterval*24*60*60 sinceDate:date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitWeekday | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:dstDay];
    
    weekDay.day = (int)dateComponent.day;
    weekDay.weekday = (int)dateComponent.weekday;
    
    return weekDay;
}

-(void)addSubViews:(UIView *)fatherView childrenViews:(NSArray *)childrenViews
{
    for (id obj in childrenViews) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)obj;
            [fatherView addSubview:view];
        }
    }
}

#pragma mark - Properties
-(NSArray *)weekdayNamesArray
{
    if (!_weekdayNamesArray) {
        _weekdayNamesArray = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    }
    return _weekdayNamesArray;
}


-(UIView *)weekNamesContentView
{
    if (!_weekNamesContentView) {
        CGRect frame = CGRectZero;
        frame.size.width = ScreenSize.width;
        frame.size.height = WeeksTitleBoxHeight;
        _weekNamesContentView = [[UIView alloc] initWithFrame:frame];
        
        [self addSubViews:_weekNamesContentView childrenViews:self.weekNamesLabel];
    }
    return _weekNamesContentView;
}

-(UIView *)weekDayContentView
{
    if (!_weekDaysContentView) {
        CGRect frame = CGRectZero;
        frame.origin.y = WeeksTitleBoxHeight;
        frame.size.width = ScreenSize.width;
        frame.size.height = WeeksTitleBoxHeight;
        _weekDaysContentView = [[UIView alloc] initWithFrame:frame];

        [self addSubViews:_weekDaysContentView childrenViews:self.weekDaysLabel];
    }
    return _weekDaysContentView;
}

-(NSMutableArray *)weekNamesLabel
{
    if (!_weekNamesLabel) {
        
        _weekNamesLabel = [[NSMutableArray alloc] init];
        
        /*获取今天是周几及一月中的日号*/
        NSDate *nowDate = [NSDate date];
        WeekdayType weekdayBuf = {0};
        weekdayBuf = [self weekDay:0 sinceDate:nowDate];
        int todayWeekday = weekdayBuf.weekday;//今天周几
       
        CGFloat width = [self sizeOfSubTitleBox].width;
        CGFloat heigth = [self sizeOfSubTitleBox].height;
        
        for (int i = 0; i < NumberOfDaysInAWeek; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 0, width, heigth)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            label.text = [self weekNames:i+1];
            
            if ((i+1) == todayWeekday) {
                label.textColor = CURRENT_WEEKDAY_COLOR;
            }else{
                label.textColor = [UIColor whiteColor];
            }
            
            
            [_weekNamesLabel addObject:label];
        }
        
    }
    return _weekNamesLabel;
}




-(NSMutableArray *)weekDaysLabel
{
    if (!_weekDaysLabel) {
        _weekDaysLabel = [[NSMutableArray alloc] init];
        
        /*获取今天是周几及一月中的日号*/
        NSDate *nowDate = [NSDate date];
        WeekdayType weekdayBuf = {0};
        weekdayBuf = [self weekDay:0 sinceDate:nowDate];
        int todayWeekday = weekdayBuf.weekday;//今天周几
        NSLog(@"%d , %d", weekdayBuf.day, weekdayBuf.weekday);
        
        CGFloat width = [self sizeOfSubTitleBox].width;
        CGFloat heigth = [self sizeOfSubTitleBox].height;
        for (int i = 0; i < NumberOfDaysInAWeek; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 0, width, heigth)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            
            weekdayBuf = [self weekDay:todayWeekday-(i+1) sinceDate:nowDate];
            label.text = [NSString stringWithFormat:@"%d", weekdayBuf.day];
            
            if (weekdayBuf.weekday == todayWeekday) {
                label.textColor = CURRENT_WEEKDAY_COLOR;
            }else{
                label.textColor = [UIColor whiteColor];
            }
            
            [_weekDaysLabel addObject:label];
        }

    }
    
    return _weekDaysLabel;
}

#pragma mark - Table View Data Source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table View Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"u select %ld", indexPath.row);
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
