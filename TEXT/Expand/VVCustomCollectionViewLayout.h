//
//  VVCustomCollectionViewLayout.h
//  Vova
//
//  Created by fwzhou on 2019/5/8.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class VVCustomCollectionViewLayout;

@protocol VVCustomCollectionViewLayoutDelegate <NSObject>

@required
// 每个区多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout *)collectionViewLayout columnNumberAtSection:(NSInteger )section;

// cell height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout *)collectionViewLayout heightForRowAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
// header height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout *)collectionViewLayout referenceHeightForHeaderInSection:(NSInteger)section;

// footer height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout *)collectionViewLayout referenceHeightForFooterInSection:(NSInteger)section;

// 每个区的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

// 每个区多少中行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout *)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section;

// 每个 item 之间的左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout*)collectionViewLayout interitemSpacingForSectionAtIndex:(NSInteger)section;

/// 图层重叠高度
- (CGFloat)overlapHeightAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface VVCustomCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<VVCustomCollectionViewLayoutDelegate> delegate;

@property (nonatomic, assign) CGFloat minimumLineSpacing; // default 0.0
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; // default 0.0
@property (nonatomic, assign) BOOL sectionHeadersPinToVisibleBounds; // default NO
@property (nonatomic, assign) CGFloat contentOffsetY;

/// 未悬停的header的布局属性
- (UICollectionViewLayoutAttributes *)originLayoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;

/// 获取cell的布局属性
/// @param indexPath cell的indexpath
- (UICollectionViewLayoutAttributes *)originLayoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
