//
//  SIZECollectionViewCell.m
//  TEXT
//
//  Created by 刘博 on 2020/12/25.
//  Copyright © 2020 刘博. All rights reserved.
//
#import <Masonry/Masonry.h>

#import "SIZECollectionViewCell.h"

@interface SIZECollectionViewCell ()


@end

@implementation SIZECollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.title];
        self.contentView.backgroundColor = [UIColor cyanColor];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo((500 - 76));
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = [UIColor blackColor];
    }
    return _title;
}

@end
