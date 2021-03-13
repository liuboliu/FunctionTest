//
//  SubPageView.m
//  TEXT
//
//  Created by Apple on 2021/3/13.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "SubPageView.h"

@implementation SubPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:frame];
        [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(100, 100, 100, 100);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
