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

@property (nonatomic, strong) UILabel *contentLabe;

@end

@implementation ContentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabe];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    
    [self.contentLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).with.offset(40);
            make.right.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
    }];
}

- (void)setText:(NSString *)text{
    _text = text;
    self.contentLabe.text = text;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"标题标题";
    }
    return _titleLabel;
}

- (UILabel *)contentLabe
{
    if (!_contentLabe) {
        _contentLabe = [[UILabel alloc] init];
        _contentLabe.numberOfLines = 0;
    }
    return _contentLabe;
}

@end
