//
//  RollingCell.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/18.
//  Copyright © 2021 刘博. All rights reserved.
//


#import "VVNoticeViewCell.h"

@implementation VVNoticeViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _reuseIdentifier = reuseIdentifier;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithReuseIdentifier:@""];
}

- (void)setupUI
{
}

@end
