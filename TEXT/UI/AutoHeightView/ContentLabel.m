//
//  ContentLabel.m
//  TEXT
//
//  Created by liubo on 2023/4/30.
//  Copyright © 2023 刘博. All rights reserved.
//

#import "ContentLabel.h"
#import <Masonry/Masonry.h>

@interface ContentLabel ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ContentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setUpUI
{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setText:(NSString *)text{
    _text = text;
    self.titleLabel.text = text;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

@end
