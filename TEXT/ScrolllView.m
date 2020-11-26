//
//  ScrolllView.m
//  TEXT
//
//  Created by 刘博 on 2020/1/9.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ScrolllView.h"

@interface ScrolllView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ScrolllView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.a = YES;
        UIScrollView *scrollview  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        [self addSubview:scrollview];
         NSArray *array = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
         for (int i = 0 ; i < 10; i ++) {
             UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(300 * i,0, 300, 100)];
             view.backgroundColor = array[i%3];
             view.tag = 100 + i;
             [view addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
             [scrollview addSubview:view];
         }
         scrollview.contentSize = CGSizeMake(300 * 10 - ([UIScreen mainScreen].bounds.size.width - 300), 100);
         scrollview.pagingEnabled = YES;
         scrollview.clipsToBounds = NO;
         self.scrollView = scrollview;
    }
    return self;
}

-(void)click:(UIButton *)sender
{
    NSLog(@"点击点击dain店家%ld",(long)sender.tag);
    
}
 
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    bounds= UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 0, 0, - ([UIScreen mainScreen].bounds.size.width - 300)));
    return CGRectContainsPoint(bounds, point);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isEqual:self] || [self.scrollView.subviews containsObject:view]){
          for (UIView *subview in self.scrollView.subviews){
              CGPoint offset = CGPointMake(point.x - self.scrollView.frame.origin.x + self.scrollView.contentOffset.x - subview.frame.origin.x, point.y - self.scrollView.frame.origin.y + self.scrollView.contentOffset.y - subview.frame.origin.y);

              if ((view = [subview hitTest:offset withEvent:event])){
                  return view;
              }
          }
          return self.scrollView;
      }
//    if ([self pointInside:point withEvent:event]) {
//        return self.scrollView;
//    }
    return view;
}

- (void)text
{
    NSLog(@"打印打印打印");
}
//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
