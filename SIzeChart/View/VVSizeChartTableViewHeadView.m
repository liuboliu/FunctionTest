//
//  SizeChartTableViewHeadView.m
//  FloryDay
//
//  Created by Dwayne on 2018/3/12.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import "VVSizeChartTableViewHeadView.h"

@implementation VVSizeChartTableViewHeadView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
        [self addSubview:self.topView];
        [self addSubview:self.sizeLb];
        [self addSubview:self.inchLb];
        [self addSubview:self.cmLb];
        
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(SCREEN_W, 8));
        }];
        
        [_sizeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
            make.leading.equalTo(self.mas_leading).offset(20);
            make.size.mas_equalTo(CGSizeMake((SCREEN_W-40)/3, 44));
        }];
        
        [_inchLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.sizeLb.mas_trailing);
            make.centerY.equalTo(self.sizeLb.mas_centerY);
            make.size.mas_equalTo(CGSizeMake((SCREEN_W-40)/3, 44));
        }];
        
        [_cmLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.inchLb.mas_trailing);
            make.centerY.equalTo(self.sizeLb.mas_centerY);
            make.size.mas_equalTo(CGSizeMake((SCREEN_W-40)/3, 44));
        }];
    }
    return self;
}

- (void)setIsNewGoodsDetail:(BOOL)isNewGoodsDetail {
    _isNewGoodsDetail = isNewGoodsDetail;
    if (_isNewGoodsDetail) {
        self.topView.backgroundColor = VVColorWithTheme(theme_seperatorLineColor);
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.inset(12);
            make.top.offset(0);
            make.height.equalTo(@(1 / UIScreen.mainScreen.scale));
        }];
    } else {
        self.topView.backgroundColor = VVColorWithTheme(theme_normalListViewBcgColor);
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(SCREEN_W, 8));
        }];
    }
}

- (UIView *)topView
{
    if(!_topView){
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = VVColorWithTheme(theme_normalListViewBcgColor);
    }
    return _topView;
}

- (UILabel *)sizeLb
{
    if (!_sizeLb) {
        _sizeLb = [[UILabel alloc] init];
        _sizeLb.font = [UIFont VVWeightBoldFontOfSize:15];
        _sizeLb.textColor = VVColorWithTheme(theme_boldTitleTextColor);
        _sizeLb.textAlignment = NSTextAlignmentCenter;
    }
    return _sizeLb;
}

- (UILabel *)inchLb
{
    if (!_inchLb) {
        _inchLb = [[UILabel alloc] init];
        _inchLb.font = [UIFont VVWeightBoldFontOfSize:15];
        _inchLb.textColor = VVColorWithTheme(theme_boldTitleTextColor);
        _inchLb.textAlignment = NSTextAlignmentCenter;
    }
    return _inchLb;
}

- (UILabel *)cmLb
{
    if (!_cmLb) {
        _cmLb = [[UILabel alloc] init];
        _cmLb.font = [UIFont VVWeightBoldFontOfSize:15];
        _cmLb.textColor = VVColorWithTheme(theme_boldTitleTextColor);
        _cmLb.textAlignment = NSTextAlignmentCenter;
    }
    return _cmLb;
}

@end
