//
//  VVAdultShoeStandSizeSegmentCell.m
//  VOVA
//
//  Created by MacBook on 2019/5/28.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVAdultShoeStandSizeSegmentCell.h"
#import "UIImage+TDHelp.h"

@interface VVAdultShoeStandSizeSegmentCell ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation VVAdultShoeStandSizeSegmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
        [self setUpConstraints];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
}

- (void)setUpConstraints {
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(24);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftBtn.mas_top);
        make.leading.equalTo(self.leftBtn.mas_trailing);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(24);
    }];
}

#pragma mark - action

- (void)leftBtnAction {
    self.leftBtn.selected = YES;
    self.leftBtn.backgroundColor = VVColorWithTheme(theme_normalButtonBcgColor);
    self.rightBtn.selected = NO;
    self.rightBtn.backgroundColor = [UIColor colorWithHex:0xe9e9e9];
    if (self.delegate && [self.delegate respondsToSelector:@selector(femaleBtnClick)]) {
        [self.delegate femaleBtnClick];
    }
}

- (void)rightBtnAction {
    self.leftBtn.selected = NO;
    self.leftBtn.backgroundColor = [UIColor colorWithHex:0xe9e9e9];
    self.rightBtn.selected = YES;
    self.rightBtn.backgroundColor = VVColorWithTheme(theme_normalButtonBcgColor);
    if (self.delegate && [self.delegate respondsToSelector:@selector(maleBtnClick)]) {
        [self.delegate maleBtnClick];
    }
}

#pragma mark - lazy load

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [self getBtn];
        _leftBtn.backgroundColor = VVColorWithTheme(theme_normalButtonBcgColor);
        _leftBtn.selected = YES;
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitle:NSLocalizedStringFromTable(@"page_size_chart_female", @"DetailPage", @"") forState:UIControlStateNormal];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_leftBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(2, 2)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _leftBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        _leftBtn.layer.mask = maskLayer;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [self getBtn];
        _rightBtn.backgroundColor = [UIColor colorWithHex:0xe9e9e9];
        _rightBtn.selected = NO;
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitle:NSLocalizedStringFromTable(@"page_size_chart_male", @"DetailPage", @"") forState:UIControlStateNormal];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_rightBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(2, 2)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _rightBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        _rightBtn.layer.mask = maskLayer;
    }
    return _rightBtn;
}

#pragma mark - private

- (UIButton *)getBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 60, 24);
    [btn setTitleColor:[UIColor colorWithCSS:@"#1c1c1c"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithCSS:@"#ffffff"] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont VVWeightRegularFontOfSize:10];
    return btn;
}

@end
