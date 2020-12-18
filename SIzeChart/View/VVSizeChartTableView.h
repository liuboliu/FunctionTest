//
//  SizeChartTableView.h
//  FloryDay
//
//  Created by Dwayne on 2018/3/12.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVSizeChartTableView : UIView

- (instancetype)initWithFrame:(CGRect)frame isNewGoodsDetail:(BOOL)isNewGoodsDetail;

@property (nonatomic, strong)NSArray  *dataArray;
@property (nonatomic, strong)UITableView      *table;

- (void)showScrollIndicators;
@end
