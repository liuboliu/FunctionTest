//
//  VVAdultShoeSizeFootPrintCell.m
//  VOVA
//
//  Created by MacBook on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVAdultShoeSizeFootPrintCell.h"

@interface VVAdultShoeSizeFootPrintCell ()

@property (nonatomic, strong) UIImageView *leadFooterPrintView;
@property (nonatomic, strong) UIImageView *trailingFooterPrintView;
@property (nonatomic, strong) UILabel *leadLbl;
@property (nonatomic, strong) UILabel *trailingLbl;
@property (nonatomic, strong) UILabel *feetLengthLbl;

@end

@implementation VVAdultShoeSizeFootPrintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.leadFooterPrintView];
    [self.contentView addSubview:self.feetLengthLbl];
    [self.contentView addSubview:self.trailingFooterPrintView];
    [self.contentView addSubview:self.leadLbl];
    [self.contentView addSubview:self.trailingLbl];
    [self setContraints];
}

- (void)setContraints
{
    [self.leadFooterPrintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(autoScaleSize(89));
        make.width.mas_equalTo(autoScaleSize(71));
        make.height.mas_equalTo(autoScaleSize(150));
        make.top.mas_equalTo(33);
    }];
    
    [self.trailingFooterPrintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-autoScaleSize(89));
        make.top.equalTo(self.leadFooterPrintView.mas_top);
        make.width.mas_equalTo(autoScaleSize(71));
        make.height.mas_equalTo(autoScaleSize(150));
    }];
    
    [self.leadLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leadFooterPrintView.mas_centerX);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(10).priorityLow();
        make.top.mas_equalTo(19);
    }];
    
    [self.trailingLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.trailingFooterPrintView.mas_centerX);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(10).priorityLow();
        make.top.equalTo(self.leadLbl.mas_top);
    }];
    
    [self.feetLengthLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leadFooterPrintView.mas_centerY);
        make.leading.equalTo(self.leadFooterPrintView.mas_trailing).with.offset(autoScaleSize(11));
        make.trailing.equalTo(self.trailingFooterPrintView.mas_leading).with.offset(-autoScaleSize(11));
    }];
}

- (void)loadWithCmArray:(NSArray *)inchArray
{
    BOOL hideen = !inchArray || inchArray.count == 0;
    
    self.trailingLbl.hidden = hideen;
    self.leadLbl.hidden = hideen;
    self.feetLengthLbl.hidden = hideen;
    self.trailingFooterPrintView.hidden = hideen;
    self.leadFooterPrintView.hidden = hideen;
}

#pragma mark - lazyload

- (UILabel *)leadLbl
{
    if (!_leadLbl) {
        _leadLbl = [[UILabel alloc] init];
        _leadLbl.font = [UIFont VVWeightRegularFontOfSize:10];
        _leadLbl.textColor = VVColorWithTheme(theme_normalTextColor);
        _leadLbl.text = @"insole length";
    }
    return _leadLbl;
}

- (UILabel *)trailingLbl
{
    if (!_trailingLbl) {
        _trailingLbl = [[UILabel alloc] init];
        _trailingLbl.font = [UIFont VVWeightRegularFontOfSize:10];
        _trailingLbl.textColor = VVColorWithTheme(theme_normalTextColor);
        _trailingLbl.text = @"insole length";
    }
    return _trailingLbl;
}

- (UILabel *)feetLengthLbl
{
    if (!_feetLengthLbl) {
        _feetLengthLbl = [[UILabel alloc] init];
        _feetLengthLbl.font = [UIFont VVWeightRegularFontOfSize:10];
        _feetLengthLbl.textColor = VVColorWithTheme(theme_normalTextColor);
        _feetLengthLbl.numberOfLines = 0;
        _feetLengthLbl.textAlignment = NSTextAlignmentCenter;
        _feetLengthLbl.text = @"feet length";
    }
    return _feetLengthLbl;
}

- (UIImageView *)leadFooterPrintView
{
    if (!_leadFooterPrintView) {
        _leadFooterPrintView = [[UIImageView alloc] init];
        _leadFooterPrintView.image = [[UIImage imageNamed:@"product_detail_size_leading_foot"] vv_imageFlippedIfNeeded];
    }
    return _leadFooterPrintView;
}

- (UIImageView *)trailingFooterPrintView
{
    if (!_trailingFooterPrintView) {
        _trailingFooterPrintView = [[UIImageView alloc] init];
        _trailingFooterPrintView.image = [[UIImage imageNamed:@"product_detail_size_trailing_foot"] vv_imageFlippedIfNeeded];
    }
    return _trailingFooterPrintView;
}

@end
