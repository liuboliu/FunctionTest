//
//  TPImageTitleView.m
//  ThePaperBase
//
//  Created by liubo on 2021/5/19.
//  Copyright © 2021 scar1900. All rights reserved.
//

#import "TPImageTitleView.h"
#import <Masonry/Masonry.h>

@interface TPImageTitleView ()

///标题
@property (nonatomic, strong) UILabel *titleLabel;
///图片
@property (nonatomic, strong) UIImageView *imgView;

///点击事件，添加了一个透明的button
@property (nonatomic, strong) UIButton *button;

@end

@implementation TPImageTitleView
float rectScale (){
    return 1.2;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        [self setUpConstraints];
    }
    return self;
}

- (void)setUpUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.imgView];
    [self addSubview:self.button];
}

- (void)setUpConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-12 * rectScale());
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(12 * rectScale());
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)showTitle:(NSString *)title
{
    
    self.titleLabel.text = @"ansdfas;ldkfjas";
}

#pragma mark - action
- (void)buttonClick
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

#pragma mark - lazy load
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.userInteractionEnabled =  YES;
        _titleLabel.backgroundColor = [UIColor cyanColor];
    }
    return _titleLabel;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [_imgView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _button.backgroundColor = [UIColor clearColor];
    }
    return _button;
}

@end
