//
//  VVAdultShoeStandardSizeChartCell.m
//  VOVA
//
//  Created by MacBook on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//
typedef NS_ENUM (NSInteger,VVSizeChartCellShowType) {
    VVSizeChartCellShowTypeStandardTitle = 0, //展示standard标题
    VVSizeChartCellShowTypeStandardContent = 1,//展示standard内容
    VVSizeChartCellShowTypeCmIncnTitle = 2, //展示CMinch标题
    VVSizeChartCellShowTypeCmInchContent = 3, //展示CMinch内容
};

#import "VVAdultShoeStandardSizeChartCell.h"
#import "VVStandardSizeListModel.h"

@interface  VVAdultShoeSizeChartItemCell ()

@property (nonatomic, strong) UILabel *contentLbl;
@property (nonatomic, assign) BOOL showTitle;
@property (nonatomic, strong) UIView *leadLine;

@end

@implementation VVAdultShoeSizeChartItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.contentLbl];
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.contentLbl.backgroundColor = [UIColor whiteColor];
    
    //分割线
    UIView *leading = [[UIView alloc] init];
    [self.contentView addSubview:leading];
    [leading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1.0f / [UIScreen mainScreen].scale);
    }];
    leading.backgroundColor = VVColorWithTheme(theme_seperatorLineColor);
    self.leadLine = leading;
}

#pragma mark - loaddata
- (void)loadDataWithSandardSizeModel:(VVStandardSizeValueModel *)model key:(NSString *)key
{
    NSDictionary *dic = [model toDictionary];
    NSString *content = [dic objectForKey:key];
    self.showTitle = NO;
    self.contentLbl.font = [UIFont VVWeightRegularFontOfSize:autoScaleSize(12)];
    self.contentLbl.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
    self.contentLbl.text = content;
}

- (void)loadTitle:(NSString *)title
{
    self.showTitle = YES;
    self.contentLbl.backgroundColor = VVColorWithTheme(theme_normalListViewBcgColor);
    self.contentLbl.font = [UIFont VVWeightSemiboldFontOfSize:autoScaleSize(12)];
    self.contentLbl.text = [title uppercaseString];
}

- (void)loadCmInchTitle:(NSString *)title
{
    self.showTitle = YES;
    self.contentLbl.backgroundColor = VVColorWithTheme(theme_normalListViewBcgColor);
    self.contentLbl.font = [UIFont VVWeightSemiboldFontOfSize:autoScaleSize(12)];
    self.contentLbl.text = title;
}

- (void)loadContent:(NSString *)content
{
    self.showTitle = NO;
    self.contentLbl.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
    self.contentLbl.font = [UIFont VVWeightRegularFontOfSize:autoScaleSize(12)];

    self.contentLbl.text = content;
}

- (void)hiddenLine:(BOOL)hidden
{
    self.leadLine.hidden = hidden;
}

- (UILabel *)contentLbl
{
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.font = [UIFont VVWeightRegularFontOfSize:12];
        _contentLbl.textColor = VVColorWithTheme(theme_normalTextColor);
        _contentLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLbl;
}

@end

@interface VVAdultShoeStandardSizeChartCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) VVStandardSizeListModel *standardModel;
@property (nonatomic, strong) NSArray *standardKeyArray;
@property (nonatomic, strong) UIView *leadLine;
@property (nonatomic, strong) UIView *trailingLine;
@property (nonatomic, strong) UIView *seperatorLine;
@property (nonatomic, assign) VVSizeChartCellShowType showType;
@property (nonatomic, strong) NSArray *cminchArray;

@end

@implementation VVAdultShoeStandardSizeChartCell

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
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.leadLine];
    [self.contentView addSubview:self.trailingLine];
    [self.contentView addSubview:self.seperatorLine];
    [self setContraints];
}

- (void)setContraints
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_W - 30);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.leadLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.equalTo(self.collectionView);
        make.width.mas_equalTo(1.0f / [UIScreen mainScreen].scale);
    }];
    
    [self.trailingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self.collectionView);
        make.trailing.equalTo(self.collectionView.mas_trailing).with.offset(-0.5);
        make.width.mas_equalTo(1.0f / [UIScreen mainScreen].scale);
    }];
    
    [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1.0f / [UIScreen mainScreen].scale);
    }];
}

#pragma mark - loaddata

- (void)loadStandardListModel:(VVStandardSizeListModel *)model array:(NSArray <NSString *> *)keyArray
{
    self.standardKeyArray = keyArray;
    self.standardModel = model;
    [self.collectionView reloadData];
    self.showType = VVSizeChartCellShowTypeStandardContent;

}

- (void)loadStandKey:(NSArray <NSString *> *)keyArray
{
    self.standardKeyArray = keyArray;
    [self.collectionView reloadData];
    self.showType = VVSizeChartCellShowTypeStandardTitle;
}

- (void)loadcmInchTitle:(NSArray *)titleArray
{
    self.cminchArray = titleArray;
    NSInteger offcount = 4 - titleArray.count;
    if (offcount < 0) {
        offcount = 0;
    }

    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_W - 30 - GRIDWIDTH * offcount);
    }];
    self.showType = VVSizeChartCellShowTypeCmIncnTitle;
    [self.collectionView reloadData];
}

- (void)loadCmInchArray:(NSArray *)cminchArray
{
    self.cminchArray = cminchArray;
    NSInteger offcount = 4 - cminchArray.count;
    if (offcount < 0) {
        offcount = 0;
    }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_W - 30 - GRIDWIDTH * offcount);
    }];
    self.showType = VVSizeChartCellShowTypeCmInchContent;
    [self.collectionView reloadData];
}

#pragma mark - setter
- (void)setShowType:(VVSizeChartCellShowType)showType
{
    _showType = showType;
    if (showType == VVSizeChartCellShowTypeCmIncnTitle ||
        showType == VVSizeChartCellShowTypeStandardTitle) {
        self.leadLine.hidden = YES;
        self.trailingLine.hidden = YES;
        self.collectionView.backgroundColor = VVColorWithTheme(theme_normalListViewBcgColor);
    } else {
        self.leadLine.hidden = NO;
        self.trailingLine.hidden = NO;
        self.collectionView.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
    }
}

#pragma mark - updateContraints
- (void)setSeparatorTrailoffset:(CGFloat)offset
{
    if (offset < 0) {
        offset = 15;
    }
    //去掉突出分割线的宽度
    if (offset > 15) {
        offset += 1;
    }
    [self.seperatorLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(- offset);
    }];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (self.showType) {
        case VVSizeChartCellShowTypeStandardTitle:
        {
            return self.standardKeyArray.count;
        }
        case VVSizeChartCellShowTypeStandardContent:
        {
            return self.standardKeyArray.count;
        }
        case VVSizeChartCellShowTypeCmIncnTitle:
        {
            return self.cminchArray.count > 4 ? 4 : self.cminchArray.count;
        }
        case VVSizeChartCellShowTypeCmInchContent:
        {
            return self.cminchArray.count > 4 ? 4 : self.cminchArray.count;
        }
        default:
            break;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VVAdultShoeSizeChartItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VVAdultShoeSizeChartItemCell class]) forIndexPath:indexPath];
    [cell hiddenLine:indexPath.item == 0];
    switch (self.showType) {
        case VVSizeChartCellShowTypeStandardTitle:
        {
            NSString *title = self.standardKeyArray[indexPath.item];
            [cell loadTitle:title];
            return cell;
        }
        case VVSizeChartCellShowTypeStandardContent:
        {
            NSString *key = self.standardKeyArray[indexPath.item];
            [cell loadDataWithSandardSizeModel:self.standardModel.attr_value key:key];
            return cell;
        }
        case VVSizeChartCellShowTypeCmIncnTitle:
        {
            NSString *content = self.cminchArray[indexPath.item];
            [cell loadCmInchTitle:content];
            return cell;
        }
        case VVSizeChartCellShowTypeCmInchContent:
        {
            NSString *content = self.cminchArray[indexPath.item];
            [cell loadContent:content];
            return cell;
        }
            
        default:
            break;
    }
    return [UICollectionViewCell new];
}

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init
                                              ];
        layout.itemSize = CGSizeMake(GRIDWIDTH, 30);
        layout.minimumLineSpacing = 0.5;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[VVAdultShoeSizeChartItemCell class] forCellWithReuseIdentifier:NSStringFromClass([VVAdultShoeSizeChartItemCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        //_collectionView.backgroundColor = [UIColor colorWithHex:0xd2d2d2];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _collectionView;
}

- (UIView *)leadLine
{
    if (!_leadLine) {
        _leadLine = [[UIView alloc] init];
        _leadLine.backgroundColor = VVColorWithTheme(theme_seperatorLineColor);
    }
    return _leadLine;
}

- (UIView *)trailingLine
{
    if (!_trailingLine) {
        _trailingLine = [[UIView alloc] init];
        _trailingLine.backgroundColor = VVColorWithTheme(theme_seperatorLineColor);
    }
    return _trailingLine;
}

- (UIView *)seperatorLine
{
    if (!_seperatorLine) {
        _seperatorLine = [[UIView alloc] init];
        _seperatorLine.backgroundColor = VVColorWithTheme(theme_seperatorLineColor);
    }
    return _seperatorLine;
}

@end
