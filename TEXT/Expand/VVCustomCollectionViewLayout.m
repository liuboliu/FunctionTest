//
//  VVCustomCollectionViewLayout.m
//  Vova
//
//  Created by fwzhou on 2019/5/8.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVCustomCollectionViewLayout.h"
#import "NSArray+DataProtect.h"

@interface VVCustomCollectionViewLayout ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes *> *> *itemLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *originHeaderLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *headerLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *originFooterLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *footerLayoutAttributes;
/// Per section heights.
@property (nonatomic, strong) NSMutableArray<NSNumber *> *heightOfSections;
/// UICollectionView content height.
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation VVCustomCollectionViewLayout

- (void)prepareLayout
{
    [super prepareLayout];
    _contentHeight = 0.0;
    @autoreleasepool {
        _itemLayoutAttributes = nil;
        _headerLayoutAttributes = nil;
        _footerLayoutAttributes = nil;
        _heightOfSections = nil;
    }
    
    _itemLayoutAttributes = [NSMutableArray array];
    _headerLayoutAttributes = [NSMutableArray array];
    _footerLayoutAttributes = [NSMutableArray array];
    _originHeaderLayoutAttributes = [NSMutableArray array];
    _originFooterLayoutAttributes = [NSMutableArray array];
    _heightOfSections = [NSMutableArray array];
    [self invalidateLayout];
    UICollectionView *collectionView = self.collectionView;
    NSInteger const numberOfSections = collectionView.numberOfSections;
    UIEdgeInsets const contentInset = collectionView.contentInset;
    CGFloat const contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right;
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger const columnOfSection = [_delegate collectionView:collectionView layout:self columnNumberAtSection:section];
        UIEdgeInsets const contentInsetOfSection = [self contentInsetForSection:section];
        CGFloat const minimumLineSpacing = [self minimumLineSpacingForSection:section];
        CGFloat const minimumInteritemSpacing = [self minimumInteritemSpacingForSection:section];
        CGFloat const contentWidthOfSection = contentWidth - contentInsetOfSection.left - contentInsetOfSection.right;
        CGFloat const itemWidth = (contentWidthOfSection-(columnOfSection-1)*minimumInteritemSpacing) / columnOfSection;
        NSInteger numberOfItems = 0;
        if ([collectionView.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            numberOfItems = [collectionView.dataSource collectionView:collectionView numberOfItemsInSection:section];
        }
        
        // Per section header
        CGFloat headerHeight = 0.0;
        if ([_delegate respondsToSelector:@selector(collectionView:layout:referenceHeightForHeaderInSection:)]) {
            headerHeight = [_delegate collectionView:collectionView layout:self referenceHeightForHeaderInSection:section];
        }
        UICollectionViewLayoutAttributes *headerLayoutAttribute = [[UICollectionViewLayoutAttributes alloc] init];
        headerLayoutAttribute.indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        if (headerHeight > 0) {
            headerLayoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        }

        headerLayoutAttribute.frame = CGRectMake(0.0, _contentHeight, contentWidth, headerHeight);
        [_headerLayoutAttributes addObject:headerLayoutAttribute];
        
        [_originHeaderLayoutAttributes addObject:[headerLayoutAttribute copy]];
        
        // The current section's offset for per column.
        CGFloat offsetOfColumns[columnOfSection];
        for (NSInteger i = 0; i < columnOfSection; i++)
        {
            offsetOfColumns[i] = headerHeight + contentInsetOfSection.top;
        }
        
        NSMutableArray *layoutAttributeOfSection = [NSMutableArray arrayWithCapacity:numberOfItems];
        for (NSInteger item = 0; item < numberOfItems; item++)
        {
            // Find minimum offset and fill to it.
            NSInteger currentColumn = 0;
            for (NSInteger i = 1; i < columnOfSection; i++)
            {
                if (offsetOfColumns[currentColumn] > offsetOfColumns[i]) {
                    currentColumn = i;
                }
            }
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGFloat itemHeight = 0;
            if ([_delegate respondsToSelector:@selector(collectionView:layout:heightForRowAtIndexPath:itemWidth:)]) {
                itemHeight = [_delegate collectionView:collectionView layout:self heightForRowAtIndexPath:indexPath itemWidth:itemWidth];
            }
            CGFloat x = contentInsetOfSection.left + itemWidth*currentColumn + minimumInteritemSpacing*currentColumn;
            CGFloat y = offsetOfColumns[currentColumn] + (item >= columnOfSection ? minimumLineSpacing : 0.0);
            
            UICollectionViewLayoutAttributes *layoutAttbiture = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            if ([_delegate respondsToSelector:@selector(overlapHeightAtIndexPath:)]) {
                CGFloat overlapHeight = [_delegate overlapHeightAtIndexPath:indexPath];
                _contentHeight -= overlapHeight;
                layoutAttbiture.zIndex = item;
            }
            
            layoutAttbiture.frame = CGRectMake(x, y+_contentHeight, itemWidth, itemHeight);
            [layoutAttributeOfSection addObject:layoutAttbiture];
            
            // Update y offset in current column
            offsetOfColumns[currentColumn] = (y + itemHeight);
        }
        [_itemLayoutAttributes addObject:layoutAttributeOfSection];
        
        // Get current section height from offset record.
        CGFloat maxOffsetValue = offsetOfColumns[0];
        for (int i = 1; i < columnOfSection; i++)
        {
            if (offsetOfColumns[i] > maxOffsetValue) {
                maxOffsetValue = offsetOfColumns[i];
            }
        }
        maxOffsetValue += contentInsetOfSection.bottom;
        
        // Per section footer
        CGFloat footerHeight = 0.0;
        if ([_delegate respondsToSelector:@selector(collectionView:layout:referenceHeightForFooterInSection:)]) {
            footerHeight = [_delegate collectionView:collectionView layout:self referenceHeightForFooterInSection:section];
        }
        UICollectionViewLayoutAttributes *footerLayoutAttribute = [[UICollectionViewLayoutAttributes alloc] init];
        footerLayoutAttribute.indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        if (footerHeight > 0) {
            footerLayoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        }
        footerLayoutAttribute.frame = CGRectMake(0.0, _contentHeight+maxOffsetValue, contentWidth, footerHeight);
        [_footerLayoutAttributes addObject:footerLayoutAttribute];
        
        [_originFooterLayoutAttributes addObject:[footerLayoutAttribute copy]];
        
        /**
         Update UICollectionView content height.
         Section height contain from the top of the headerView to the bottom of the footerView.
         */
        CGFloat currentSectionHeight = maxOffsetValue + footerHeight;
        [_heightOfSections addObject:@(currentSectionHeight)];
        
        _contentHeight += currentSectionHeight;
    }
}

- (CGSize)collectionViewContentSize
{
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    CGFloat width = CGRectGetWidth(self.collectionView.bounds) - contentInset.left - contentInset.right;
    CGFloat height = MAX(CGRectGetHeight(self.collectionView.bounds), _contentHeight);
    return CGSizeMake(width, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray<UICollectionViewLayoutAttributes *> *result = [NSMutableArray array];
    [_itemLayoutAttributes enumerateObjectsUsingBlock:^(NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributeOfSection, NSUInteger idx, BOOL *stop)
     {
         [layoutAttributeOfSection enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop)
          {
             if (CGRectIntersectsRect(rect, attribute.frame)) {
                 [result addObject:attribute];
             }
          }];
     }];
    
    // Header view hover.
    if (_sectionHeadersPinToVisibleBounds) {
        for (UICollectionViewLayoutAttributes *attriture in _headerLayoutAttributes) {
            NSInteger section = attriture.indexPath.section;
            UIEdgeInsets contentInsetOfSection = [self contentInsetForSection:section];
            NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            UICollectionViewLayoutAttributes *itemAttribute = [self layoutAttributesForItemAtIndexPath:firstIndexPath];
            if (!itemAttribute) {
                continue;
            }
            CGFloat headerHeight = CGRectGetHeight(attriture.frame);
            CGRect frame = attriture.frame;
            frame.origin.y = MIN(
                                 MAX(self.collectionView.contentOffset.y + _contentOffsetY, CGRectGetMinY(itemAttribute.frame)-headerHeight-contentInsetOfSection.top),
                                 CGRectGetMinY(attriture.frame)+[_heightOfSections[section] floatValue]-headerHeight
                                 );
            attriture.frame = frame;
            attriture.zIndex = (NSIntegerMax/2)+section;
        }
    }
    // 先将header悬停，再判断header是否在屏幕
    [_headerLayoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop)
     {
         if (CGRectGetHeight(attribute.frame) > 0 &&
             CGRectIntersectsRect(rect, attribute.frame)) {
            [result addObject:attribute];
        }
     }];
    
    [_footerLayoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop)
     {
         if (CGRectGetHeight(attribute.frame) > 0 &&
             CGRectIntersectsRect(rect, attribute.frame)) {
             [result addObject:attribute];
         }
     }];
    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<UICollectionViewLayoutAttributes *> *tempArray = [_itemLayoutAttributes vv_arrayWithIndex:indexPath.section];
    return [tempArray vv_objectWithIndex:indexPath.item];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [_headerLayoutAttributes vv_objectWithIndex:indexPath.section];
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [_footerLayoutAttributes vv_objectWithIndex:indexPath.section];
    }
    return nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (_sectionHeadersPinToVisibleBounds) {
        return YES;
    } else {
        return [super shouldInvalidateLayoutForBoundsChange:newBounds];
    }
}

- (UICollectionViewLayoutAttributes *)originLayoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [_originHeaderLayoutAttributes vv_objectWithIndex:indexPath.section];
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [_originFooterLayoutAttributes vv_objectWithIndex:indexPath.section];
    }
    return nil;
}

- (UICollectionViewLayoutAttributes *)originLayoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (!indexPath) {
		return nil;
	}
	
	NSArray *array = [self.itemLayoutAttributes vv_objectWithIndex:indexPath.section];
	UICollectionViewLayoutAttributes *atti = [array vv_objectWithIndex:indexPath.item];
	return atti;
}

#pragma mark - Private
- (UIEdgeInsets)contentInsetForSection:(NSInteger)section
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if ([_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        edgeInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    return edgeInsets;
}

- (CGFloat)minimumLineSpacingForSection:(NSInteger)section
{
    CGFloat minimumLineSpacing = self.minimumLineSpacing;
    if ([_delegate respondsToSelector:@selector(collectionView:layout:lineSpacingForSectionAtIndex:)]) {
        minimumLineSpacing = [_delegate collectionView:self.collectionView layout:self lineSpacingForSectionAtIndex:section];
    }
    return minimumLineSpacing;
}

- (CGFloat)minimumInteritemSpacingForSection:(NSInteger)section
{
    CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
    if ([_delegate respondsToSelector:@selector(collectionView:layout:interitemSpacingForSectionAtIndex:)]) {
        minimumInteritemSpacing = [_delegate collectionView:self.collectionView layout:self interitemSpacingForSectionAtIndex:section];
    }
    return minimumInteritemSpacing;
}

@end
