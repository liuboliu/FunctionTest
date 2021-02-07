//
//  UIView+Hittest.m
//  TEXT
//
//  Created by Apple on 2021/1/25.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "UIView+Hittest.h"
#import <objc/runtime.h>

static void *expandKey = &expandKey;

@interface UIView ()



@end


@implementation UIView (Hittest)

- (void)setExpand:(BOOL)expand
{
    objc_setAssociatedObject(self, expandKey, @(expand), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)expand
{
    return [objc_getAssociatedObject(self, expandKey) boolValue];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.expand) {
        for (NSInteger i = self.subviews.count - 1; i >= 0; i --) {
            UIView *subView = self.subviews[i];
            CGPoint childPoint = [subView convertPoint:point fromView:self];
            if ([subView pointInside:childPoint withEvent:event]) {
                return subView;
            }
        }
    }
    
    if ([self pointInside:point withEvent:event]) {
        return self;
    }
    return self.superview;
}

@end
