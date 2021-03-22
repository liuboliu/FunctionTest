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

@property (nonatomic, strong) UIImageView *imagView;

@end

@implementation RollingCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setUpUI
{
    self.title = [[UILabel alloc] init];
    self.title.frame = CGRectMake(60, 0, 100, 40);
    self.title.textColor = [UIColor blueColor];
    self.title.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.title];
    self.imagView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self addSubview:self.imagView];
}

- (void)setTitleText:(NSString *)titleText
{
    self.title.text = titleText;
    self.title.backgroundColor = [UIColor whiteColor];
}

- (void)setImageName:(NSString *)imageName
{
    self.imagView.image = [UIImage imageNamed:imageName];
}

@end
