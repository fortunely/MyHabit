//
//  CalendarItem.h
//  MyHabit
//
//  Created by MingMingZhang on 16/1/22.
//  Copyright © 2016年 zmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarItem : UIView

/**
*  Intialization function
*
*  @param frame view's frame
*  @param date  the date of current calendar item
*
*  @return <#return value description#>
*/
-(instancetype)initWithFrame:(CGRect)frame withDate:(NSDate *)date;


@end
