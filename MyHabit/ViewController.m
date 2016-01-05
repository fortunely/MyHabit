//
//  ViewController.m
//  MyHabit
//
//  Created by MingMingZhang on 15/12/16.
//  Copyright © 2015年 zmm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view did load");
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = self.view.bounds;
    
    [self printFrame:self.view.frame];
    [self printFrame:self.scrollview.frame];
    
    self.scrollview.backgroundColor = [UIColor clearColor];
    self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.view.frame.size.height);
    self.scrollview.clipsToBounds = YES;
    self.scrollview.contentOffset = CGPointMake(0, 0);
    self.scrollview.bounces = NO;
    
    CGRect leftFrame =  CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIView *leftView = [[UIView alloc] initWithFrame:leftFrame];
    leftView.backgroundColor = [UIColor blueColor];
    
    CGRect centerFrame =  CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height);
    UIView *centerView = [[UIView alloc] initWithFrame:centerFrame];
    centerView.backgroundColor = [UIColor redColor];
    
    CGRect rightFrame =  CGRectMake(2*frame.size.width, 0, frame.size.width, frame.size.height);
    UIView *rightView = [[UIView alloc] initWithFrame:rightFrame];
    rightView.backgroundColor = [UIColor grayColor];
    
    
    [self.scrollview addSubview:leftView];
    [self.scrollview addSubview:centerView];
    [self.scrollview addSubview:rightView];
    
    self.scrollview.pagingEnabled = YES;
    
    NSLog(@"count = %ld", self.scrollview.subviews.count);
    
}

-(void)printFrame:(CGRect)rect
{
    NSLog(@"(%lf, %lf, %lf, %lf)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}




@end
