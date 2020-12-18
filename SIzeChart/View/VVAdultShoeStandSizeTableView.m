//
//  VVAdultShoeStandSizeTableView.m
//  VOVA
//
//  Created by MacBook on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVAdultShoeStandSizeTableView.h"
#import "VVAdultShoeSizeTipCell.h"
#import "VVAdultShoeStandSizeSegmentCell.h"
#import "VVAdultShoeStandardSizeChartCell.h"

@interface VVAdultShoeStandSizeTableView () <UITableViewDelegate, UITableViewDataSource, VVAdultShoeStandSizeSegmentCellDelegate>

@property (nonatomic, assign) BOOL isNewGoodsDetail;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString *> *keyArray;
@property (nonatomic, strong) NSArray<VVStandardSizeGenderModel *> *standardSizeList;
@property (nonatomic, strong) NSArray<VVStandardSizeListModel *> *dataArray;

@property (nonatomic, strong) NSString *tips;

@end

@implementation VVAdultShoeStandSizeTableView

- (instancetype)initWithFrame:(CGRect)frame isNewGoodsDetail:(BOOL)isNewGoodsDetail {
    if (self = [super initWithFrame:frame]) {
        self.isNewGoodsDetail = isNewGoodsDetail;
        self.showType = VVStandardShoesSizeTypeFemale;
        [self setUpUI];
        [self setUpConstraints];
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.tableView];
}

- (void)setUpConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(54, 0, 0, 0));
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
        _tableView.scrollEnabled = !self.isNewGoodsDetail;
        [_tableView registerClass:[VVAdultShoeSizeTipCell class] forCellReuseIdentifier:NSStringFromClass([VVAdultShoeSizeTipCell class])];
        [_tableView registerClass:[VVAdultShoeStandSizeSegmentCell class] forCellReuseIdentifier:NSStringFromClass([VVAdultShoeStandSizeSegmentCell class])];
        [_tableView registerClass:[VVAdultShoeStandardSizeChartCell class] forCellReuseIdentifier:NSStringFromClass([VVAdultShoeStandardSizeChartCell class])];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)loadWithStandardSizeKeyArray:(NSArray<NSString *> *)array
                            SizeList:(NSArray<VVStandardSizeGenderModel *> *)standardSizeList
                                 tip:(NSString *)tips {
    self.keyArray = array;
    self.standardSizeList = standardSizeList;
    [self updateDataArray];
    self.tips = tips;
    [self.tableView reloadData];
}

- (void)updateDataArray {
    for (VVStandardSizeGenderModel *gender in self.standardSizeList) {
        if (self.showType == VVStandardShoesSizeTypeFemale && [gender.attr_name isEqualToString:@"female"]) {
            self.dataArray = gender.attr_value;
        }
        if (self.showType == VVStandardShoesSizeTypeMale && [gender.attr_name isEqualToString:@"male"]) {
            self.dataArray = gender.attr_value;
        }
    }
}

#pragma mark - UITableViewDelegate , UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: // Tip分区
        {
            VVAdultShoeSizeTipCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VVAdultShoeSizeTipCell class])];
            [cell loadContent:self.tips];
            return cell;
        }
        case 1:  // Female和Male分区
        {
            VVAdultShoeStandSizeSegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VVAdultShoeStandSizeSegmentCell class])];
            cell.delegate = self;
            return cell;
        }
        case 2:  // 尺码分区
        {
            VVAdultShoeStandardSizeChartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VVAdultShoeStandardSizeChartCell class])];
            if (indexPath.row == 0) {
                [cell loadStandKey:self.keyArray];
                return cell;
            }
            [cell setSeparatorTrailoffset:15];
            VVStandardSizeListModel *model = [self.dataArray vv_objectWithIndex:indexPath.row - 1];
            [cell loadStandardListModel:model array:self.keyArray];
            return cell;
        }
        default:
            break;
    }
    return [UITableViewCell new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: // Tip分区
        {
            return 1;
        }
        case 1: // Female和Male分区
        {
            return 1;
        }
        case 2: // 尺码分区
        {
            return self.dataArray.count + 1;
        }
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Tip分区、Female和Male分区、尺码分区
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: // Tip分区
        {
            if (self.tips.length > 0) {
                return 30;
            }
            return 0;
        }
        case 1: // Female和Male分区
        {
            return 44;
        }
        case 2: // 尺码分区
        {
            return 30;
        }
        default:
            break;
    }
    return 30;
}

#pragma mark - VVAdultShoeStandSizeSegmentCellDelegate

- (void)femaleBtnClick
{
    self.showType = VVStandardShoesSizeTypeFemale;
    [self updateDataArray];
    [self.tableView reloadData];
}

- (void)maleBtnClick
{
    self.showType = VVStandardShoesSizeTypeMale;
    [self updateDataArray];
    [self.tableView reloadData];
}

@end
