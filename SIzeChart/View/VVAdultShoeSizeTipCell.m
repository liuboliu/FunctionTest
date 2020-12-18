//
//  VVAdultShoeSizeTipCell.m
//  VOVA
//
//  Created by MacBook on 2019/5/28.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVAdultShoeSizeTipCell.h"

@interface VVAdultShoeSizeTipCell ()

@property (nonatomic, strong) UILabel *contentLbl;

@end

@implementation VVAdultShoeSizeTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.contentLbl];
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.leading.mas_equalTo(15);
        make.height.mas_equalTo(17);
        make.trailing.mas_equalTo(-15);
    }];
}

- (void)loadContent:(NSString *)content
{
    self.contentLbl.text = content ? content : @"";
}

-(UILabel *)contentLbl
{
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.textColor = VVColorWithTheme(theme_normalTextColor);
        _contentLbl.font = [UIFont VVWeightLightFontOfSize:12];
    }
    return _contentLbl;
}

@end
