//
//  BigTestView.m
//  TEXT
//
//  Created by Apple on 2021/1/24.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "BigTestView.h"

@implementation BigTestView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    //NSLog(@"打的inside大的inside");
   return  [super pointInside:point withEvent:event];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    //NSLog(@"a视图点击");
//    return [super hitTest:point withEvent:event];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
