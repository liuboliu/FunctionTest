//
//  RollingCell.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/18.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "RollingCell.h"

@interface RollingCell ()

@property (nonatomic, strong) UILabel *title;

@end

@implementation RollingCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.title = [[UILabel alloc] init];
    self.title.frame = CGRectMake(10, 10, 100, 40);
    self.title.textColor = [UIColor redColor];
    self.title.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.title];
}

- (void)setTitleText:(NSString *)titleText
{
    self.title.text = titleText;
}

@end
