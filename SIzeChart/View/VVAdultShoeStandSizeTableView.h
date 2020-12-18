//
//  VVAdultShoeStandSizeTableView.h
//  VOVA
//
//  Created by MacBook on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVViewProtocol.h"
#import "VVStandardSizeListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VVStandardShoesSizeType) {
    VVStandardShoesSizeTypeFemale = 0, // 女性尺码
    VVStandardShoesSizeTypeMale = 1, // 男性尺码
};

@interface VVAdultShoeStandSizeTableView : UIView <VVViewProtocol>

- (instancetype)initWithFrame:(CGRect)frame isNewGoodsDetail:(BOOL)isNewGoodsDetail;

@property (nonatomic, assign) VVStandardShoesSizeType showType;

- (void)loadWithStandardSizeKeyArray:(NSArray<NSString *> *)array
                            SizeList:(NSArray<VVStandardSizeGenderModel *> *)standardSizeList
                                 tip:(NSString *)tips;

@end

NS_ASSUME_NONNULL_END
