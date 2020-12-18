//
//  VVSizeChartViewModel.h
//  VOVA
//
//  Created by MacBook on 2019/6/11.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VVSizeListModel;
@class VVStandardSizeGenderModel;

NS_ASSUME_NONNULL_BEGIN

@interface VVSizeChartViewModel : NSObject
//普通sizechart数组
@property (nonatomic, strong, nullable) NSArray <VVSizeListModel *> *sizeChartArray;
@property (nonatomic, strong) NSArray <VVStandardSizeGenderModel *> *standardSizeList;
@property (nonatomic, strong) NSArray <NSString *> *standardSizeKeyArray;
@property (nonatomic, strong) NSArray *cmSizeArray;
@property (nonatomic, strong) NSArray *inchSizeArray;
@property (nonatomic, copy) NSString *sizeTips;
@property (nonatomic, assign, readonly) BOOL isLoadSizeChart;

- (void)getSizeChartDataWithVirtualGoodsId:(NSString *)virtual_goods_id result:(void (^)(BOOL sucess))result;

- (void)resetState;

@end

NS_ASSUME_NONNULL_END
