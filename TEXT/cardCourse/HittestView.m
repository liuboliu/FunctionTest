//
//  HittestView.m
//  TEXT
//
//  Created by Apple on 2021/1/23.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "HittestView.h"

@implementation HittestView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
      int count = (int)self.subviews.count;
        for (int i = count - 1; i >= 0; i--) {
            // 获取子控件
            UIView *childView = self.subviews[i];
            
            // 把当前坐标系上的点转换成子控件上的点
            CGPoint childP =  [self convertPoint:point toView:childView];
            
    //        UIView *fitView = [childView hitTest:childP withEvent:event];
            if ([childView pointInside:childP withEvent:event]) {
                return true;
            }
            
        }
    return [super pointInside:point withEvent:event];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    int count = (int)self.subviews.count;
//    for (int i = count - 1; i >= 0; i--) {
//        // 获取子控件
//        UIView *childView = self.subviews[i];
//
//        // 把当前坐标系上的点转换成子控件上的点
//        CGPoint childP =  [self convertPoint:point toView:childView];
//
////        UIView *fitView = [childView hitTest:childP withEvent:event];
//        if ([childView pointInside:childP withEvent:event]) {
//            return childView;
//        }
//
//    }
//    // 4.如果没有比自己合适的子控件,最合适的view就是自己
//    return [super hitTest:point withEvent:event];
//}
@end
