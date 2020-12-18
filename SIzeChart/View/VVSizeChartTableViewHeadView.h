//
//  SizeChartTableViewHeadView.h
//  FloryDay
//
//  Created by Dwayne on 2018/3/12.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVSizeChartTableViewHeadView : UITableViewHeaderFooterView

@property (nonatomic, assign) BOOL isNewGoodsDetail;

@property (nonatomic, strong)UILabel  *sizeLb;
@property (nonatomic, strong)UILabel  *inchLb;
@property (nonatomic, strong)UILabel  *cmLb;
@property (nonatomic, strong)UIView   *topView;;
@end
