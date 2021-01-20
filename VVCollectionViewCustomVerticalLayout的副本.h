//
//  VVCollectionViewCustomVerticalLayout.h
//  vv_bodylib_ios
//
//  Created by JackLee on 2020/4/24.
//

#import <UIKit/UIKit.h>
#import "VVCollectionViewCustomLayoutProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVCollectionViewCustomVerticalLayout : UICollectionViewLayout<VVCollectionViewCustomLayoutProtocol>

@property (nonatomic, assign) CGFloat minimumLineSpacing; // default 0.0
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; // default 0.0
@property (nonatomic, assign) BOOL sectionHeadersPinToVisibleBounds; // default NO
@property (nonatomic, assign) CGFloat contentOffsetY;

/// 未悬停的header的布局属性
- (UICollectionViewLayoutAttributes *)originLayoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
/// 适用于每一列的cell宽度都相等
- (CGFloat)itemWidthOfIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
