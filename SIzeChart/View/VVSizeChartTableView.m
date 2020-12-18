//
//  SizeChartTableView.m
//  FloryDay
//
//  Created by Dwayne on 2018/3/12.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import "VVSizeChartTableView.h"
#import "VVSizeChartTableViewCell.h"
#import "VVSizeChartTableViewHeadView.h"
#import "VVSizeChartModel.h"
#import "VVSizeListModel.h"

@interface VVSizeChartTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL isNewGoodsDetail;

@end

static NSString * const SizeChartTableViewCellIdentifier = @"SizeChartTableViewCellIdentifier";
static NSString * const SizeChartTableViewSectionIdentifier = @"SizeChartTableViewSectionIdentifier";

@implementation VVSizeChartTableView

- (instancetype)initWithFrame:(CGRect)frame isNewGoodsDetail:(BOOL)isNewGoodsDetail
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isNewGoodsDetail = isNewGoodsDetail;
        [self addSubview:self.table];
        [_table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.table];
        [_table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    }
    return self;
}
#pragma mark - public

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [_table layoutIfNeeded];
    [_table reloadData];
}

- (void)showScrollIndicators
{
    [_table flashScrollIndicators];
}

#pragma mark - lazy load

- (UITableView *)table
{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.contentInset = UIEdgeInsetsMake(54, 0, 0, 0);
        _table.scrollEnabled = !self.isNewGoodsDetail;
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[VVSizeChartTableViewCell class] forCellReuseIdentifier:SizeChartTableViewCellIdentifier];
        [_table registerClass:[VVSizeChartTableViewHeadView class] forHeaderFooterViewReuseIdentifier:SizeChartTableViewSectionIdentifier];
        _table.rowHeight = 35;
        _table.tag = 836913;
        _table.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}

#pragma mark - tableView  delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    VVSizeListModel *model = [self.dataArray objectAtIndex:section];
    return model.attr_value.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VVSizeChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SizeChartTableViewCellIdentifier  forIndexPath:indexPath];
    if (!cell) {
        cell = [[VVSizeChartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SizeChartTableViewCellIdentifier];
    }
    VVSizeListModel *model = [self.dataArray objectAtIndex:indexPath.section];
    VVSizeChartModel *m = [model.attr_value objectAtIndex:indexPath.row];
    cell.sizeLb.text = m.name;
    cell.inchLb.text = m.inch;
    cell.cmLb.text = m.cm;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    VVSizeChartTableViewHeadView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SizeChartTableViewSectionIdentifier];
    if (!head) {
        head = [[VVSizeChartTableViewHeadView alloc] initWithReuseIdentifier:SizeChartTableViewSectionIdentifier];
    }
    head.isNewGoodsDetail = self.isNewGoodsDetail;
    if (section==0 && !self.isNewGoodsDetail) {
        head.topView.hidden=YES;
    } else {
        head.topView.hidden=NO;
    }
    VVSizeListModel *model = [self.dataArray objectAtIndex:section];
    head.sizeLb.text = model.attr_name;
    head.inchLb.text = @"INCH";
    head.cmLb.text = @"CM";
    return head;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0.01)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isNewGoodsDetail) {
        return 44;
    }
    return 44 + 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
