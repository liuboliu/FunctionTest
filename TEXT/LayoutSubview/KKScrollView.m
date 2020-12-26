//
//  KKScrollView.m
//  TEXT
//
//  Created by 刘博 on 2020/12/26.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "KKScrollView.h"

@implementation KKScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    NSLog(@"执行执行执行layoutSubviews");
}

@end
