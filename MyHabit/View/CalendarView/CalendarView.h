//
//  CalendarView.h
//  MyHabit
//
//  Created by MingMingZhang on 16/1/5.
//  Copyright © 2016年 zmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarView : UIView

-(instancetype)initWithFrame:(CGRect)frame currentDate:(NSDate *)date ;

-(void)clickDate:(id)date;

-(BOOL)selected:(id)date;

@end
