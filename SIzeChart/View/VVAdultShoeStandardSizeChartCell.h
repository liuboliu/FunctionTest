//
//  VVAdultShoeStandardSizeChartCell.h
//  VOVA
//
//  Created by MacBook on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#define GRIDWIDTH  (SCREEN_W - 30)/3.0

#import <UIKit/UIKit.h>
@class VVStandardSizeListModel;

NS_ASSUME_NONNULL_BEGIN

@interface VVAdultShoeStandardSizeChartCell : UITableViewCell

- (void)loadStandardListModel:(VVStandardSizeListModel *)model array:(NSArray <NSString *> *)keyArray;
- (void)loadStandKey:(NSArray <NSString *> *)keyArray;
- (void)loadcmInchTitle:(NSArray *)titleArray;
- (void)loadCmInchArray:(NSArray *)cminchArray;
- (void)setSeparatorTrailoffset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END

@interface VVAdultShoeSizeChartItemCell : UICollectionViewCell

@end
