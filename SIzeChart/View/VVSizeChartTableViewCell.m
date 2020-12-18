//
//  SizeChartTableViewCell.m
//  FloryDay
//
//  Created by Dwayne on 2018/3/12.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import "VVSizeChartTableViewCell.h"

@implementation VVSizeChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        [self.contentView addSubview:self.sizeLb];
        [self.contentView addSubview:self.inchLb];
        [self.contentView addSubview:self.cmLb];
        
        [_sizeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading).offset(20);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake((SCREEN_W-40)/3, 20));
        }];
        
        [_inchLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.sizeLb.mas_trailing);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake((SCREEN_W-40)/3, 20));
        }];
        
        [_cmLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.inchLb.mas_trailing);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake((SCREEN_W-40)/3, 20));
        }];
    }
    return self;
}


- (UILabel *)sizeLb
{
    if (!_sizeLb) {
        _sizeLb = [[UILabel alloc] init];
        _sizeLb.font = [UIFont VVWeightRegularFontOfSize:12];
        _sizeLb.textColor = VVColorWithTheme(theme_boldTitleTextColor);
        _sizeLb.textAlignment = NSTextAlignmentCenter;
        _sizeLb.adjustsFontSizeToFitWidth=YES;
    }
    return _sizeLb;
}


- (UILabel *)inchLb
{
    if (!_inchLb) {
        _inchLb = [[UILabel alloc] init];
        _inchLb.font = [UIFont VVWeightRegularFontOfSize:12];
        _inchLb.textColor = VVColorWithTheme(theme_boldTitleTextColor);
        _inchLb.textAlignment = NSTextAlignmentCenter;
    }
    return _inchLb;
}

- (UILabel *)cmLb
{
    if (!_cmLb) {
        _cmLb = [[UILabel alloc] init];
        _cmLb.font = [UIFont VVWeightRegularFontOfSize:12];
        _cmLb.textColor = VVColorWithTheme(theme_boldTitleTextColor);
        _cmLb.textAlignment = NSTextAlignmentCenter;
    }
    return _cmLb;
}

@end
