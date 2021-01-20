//
//  VVCollectionViewCustomVerticalLayout.m
//  vv_bodylib_ios
//
//  Created by JackLee on 2020/4/24.
//

#import "VVCollectionViewCustomVerticalLayout.h"
#import <vv_rootlib_ios/NSArray+DataProtect.h>
#import "VVBaseCollectionDecorationView.h"

@interface VVCollectionLayoutSectionModel : NSObject
@property (nonatomic, strong, nullable) UICollectionViewLayoutAttributes *headerLayoutAttributes;
@property (nonatomic, strong, nullable) NSMutableArray<UICollectionViewLayoutAttributes *> *itemLayoutAttributes_list;
@property (nonatomic, strong, nullable) UICollectionViewLayoutAttributes *footerLayoutAttributes;

@end

@implementation VVCollectionLayoutSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemLayoutAttributes_list = [NSMutableArray new];
    }
    return self;
}
@end

@interface VVCollectionViewCustomVerticalLayout ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes *> *> *itemLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *originHeaderLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *headerLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *originFooterLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *footerLayoutAttributes;
/// Per section heights.
@property (nonatomic, strong) NSMutableArray<NSNumber *> *heightOfSections;
/// UICollectionView content height.
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, strong) NSMutableArray <VVCollectionLayoutSectionModel *>* sectionLayoutModels;

@end

@implementation VVCollectionViewCustomVerticalLayout

@synthesize vv_layoutDelegate;

- (void)prepareLayout
{
    [super prepareLayout];
    [self vv_registerDecorationViews];
    self.contentHeight = 0.0;
    
    @autoreleasepool {
        self.itemLayoutAttributes = nil;
        self.headerLayoutAttributes = nil;
        self.footerLayoutAttributes = nil;
        self.heightOfSections = nil;
        self.sectionLayoutModels = nil;
    }
    
    self.itemLayoutAttributes = [NSMutableArray array];
    self.headerLayoutAttributes = [NSMutableArray array];
    self.footerLayoutAttributes = [NSMutableArray array];
    self.originHeaderLayoutAttributes = [NSMutableArray array];
    self.originFooterLayoutAttributes = [NSMutableArray array];
    self.heightOfSections = [NSMutableArray array];
    self.sectionLayoutModels = [NSMutableArray new];
    
    [self invalidateLayout];
    
    
    UICollectionView *collectionView = self.collectionView;
    NSInteger const numberOfSections = collectionView.numberOfSections;
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        VVCollectionLayoutSectionModel *sectionLayoutModel = [VVCollectionLayoutSectionModel new];
        CGFloat headerHeight = [self layoutHeaderSection:section sectionLayoutModel:sectionLayoutModel];
        
        NSInteger columnOfSection = 1;
        if ([self.vv_layoutDelegate respondsToSelector:@selector(collectionView:customLayout:columnNumberAtSection:)]) {
            columnOfSection = [self.vv_layoutDelegate collectionView:collectionView customLayout:self columnNumberAtSection:section];
        } else {
#if DEBUG
            NSAssert(NO, @"未设置列数");
#endif
        }
        
        CGFloat offsetOfColumns[columnOfSection];
        [self layoutItemSection:section headerHeight:headerHeight offsetOfColumns:offsetOfColumns columnOfSection:columnOfSection sectionLayoutModel:sectionLayoutModel];
        
        UIEdgeInsets const contentInsetOfSection = [self contentInsetForSection:section];
        CGFloat maxOffsetValue = offsetOfColumns[0];
        for (int i = 1; i < columnOfSection; i++) {
            if (offsetOfColumns[i] > maxOffsetValue) {
                maxOffsetValue = offsetOfColumns[i];
            }
        }
        maxOffsetValue += contentInsetOfSection.bottom;
        
        CGFloat footerHeight = [self layoutFooterSection:section maxOffsetValue:maxOffsetValue sectionLayoutModel:sectionLayoutModel];
        
        CGFloat currentSectionHeight = maxOffsetValue + footerHeight;
        [self.heightOfSections addObject:@(currentSectionHeight)];
        
        self.contentHeight += currentSectionHeight;
        [self.sectionLayoutModels addObject:sectionLayoutModel];
    }
}

- (CGFloat)layoutHeaderSection:(NSInteger)section sectionLayoutModel:(VVCollectionLayoutSectionModel *)sectionLayoutModel
{
    UICollectionView *collectionView = self.collectionView;
    UIEdgeInsets const contentInset = collectionView.contentInset;
    CGFloat const contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right;
    
    CGFloat headerHeight = 0.0;
    if ([self.vv_layoutDelegate respondsToSelector:@selector(collectionView:customLayout:referenceSizeForHeaderInSection:)]) {
        CGSize headerSize = [self.vv_layoutDelegate collectionView:collectionView customLayout:self referenceSizeForHeaderInSection:section];
        headerHeight = headerSize.height;
    }
    
    UICollectionViewLayoutAttributes *headerLayoutAttribute = [[UICollectionViewLayoutAttributes alloc] init];
    headerLayoutAttribute.indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    if (headerHeight > 0) {
        headerLayoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    }
    
    headerLayoutAttribute.frame = CGRectMake(0.0, self.contentHeight, contentWidth, headerHeight);
    [self.headerLayoutAttributes addObject:headerLayoutAttribute];
    
    [self.originHeaderLayoutAttributes addObject:[headerLayoutAttribute copy]];
    sectionLayoutModel.headerLayoutAttributes = [headerLayoutAttribute copy];
    return headerHeight;
}

- (void)layoutItemSection:(NSInteger)section
             headerHeight:(CGFloat)headerHeight
          offsetOfColumns:(CGFloat [])offsetOfColumns
          columnOfSection:(NSInteger)columnOfSection
       sectionLayoutModel:(VVCollectionLayoutSectionModel *)sectionLayoutModel
{
    UICollectionView *collectionView = self.collectionView;
    
    UIEdgeInsets const contentInset = collectionView.contentInset;
    CGFloat const contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right;
    
    UIEdgeInsets const contentInsetOfSection = [self contentInsetForSection:section];
    CGFloat const minimumLineSpacing = [self minimumLineSpacingForSection:section];
    CGFloat const minimumInteritemSpacing = [self minimumInteritemSpacingForSection:section];
    CGFloat const contentWidthOfSection = contentWidth - contentInsetOfSection.left - contentInsetOfSection.right;
    CGFloat const itemWidth = (contentWidthOfSection - (columnOfSection - 1) * minimumInteritemSpacing) / columnOfSection;
    NSInteger numberOfItems = 0;
    if ([collectionView.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        numberOfItems = [collectionView.dataSource collectionView:collectionView numberOfItemsInSection:section];
    }
    
    for (NSInteger i = 0; i < columnOfSection; i++) {
        offsetOfColumns[i] = headerHeight + contentInsetOfSection.top;
    }
    
    NSMutableArray *layoutAttributeOfSection = [NSMutableArray arrayWithCapacity:numberOfItems];
    for (NSInteger item = 0; item < numberOfItems; item++) {
        NSInteger currentColumn = 0;
        for (NSInteger i = 1; i < columnOfSection; i++) {
            if (offsetOfColumns[currentColumn] > offsetOfColumns[i]) {
                currentColumn = i;
            }
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
        CGFloat itemHeight = 0;
        if ([self.vv_layoutDelegate respondsToSelector:@selector(collectionView:customLayout:sizeForItemAtIndexPath:)]) {
            CGSize itemSize = [self.vv_layoutDelegate collectionView:collectionView customLayout:self sizeForItemAtIndexPath:indexPath];
            itemHeight = itemSize.height;
        }
        CGFloat x = contentInsetOfSection.left + itemWidth*currentColumn + minimumInteritemSpacing * currentColumn;
        CGFloat y = offsetOfColumns[currentColumn] + (item >= columnOfSection ? minimumLineSpacing : 0.0);
        
        UICollectionViewLayoutAttributes *layoutAttbiture = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        if ([self.vv_layoutDelegate respondsToSelector:@selector(overlapHeightAtIndexPath:)]) {
            CGFloat overlapHeight = [self.vv_layoutDelegate overlapHeightAtIndexPath:indexPath];
            _contentHeight -= overlapHeight;
        }

        layoutAttbiture.frame = CGRectMake(x, y + self.contentHeight, itemWidth, itemHeight);
        [layoutAttributeOfSection addObject:layoutAttbiture];
        
        offsetOfColumns[currentColumn] = (y + itemHeight);
    }
    [self.itemLayoutAttributes addObject:layoutAttributeOfSection];
    sectionLayoutModel.itemLayoutAttributes_list = [layoutAttributeOfSection copy];
}

- (CGFloat)layoutFooterSection:(NSInteger)section
                maxOffsetValue:(CGFloat)maxOffsetValue
            sectionLayoutModel:(VVCollectionLayoutSectionModel *)sectionLayoutModel

{
    UICollectionView *collectionView = self.collectionView;
    
    UIEdgeInsets const contentInset = collectionView.contentInset;
    CGFloat const contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right;
    
    CGFloat footerHeight = 0.0;
    if ([self.vv_layoutDelegate respondsToSelector:@selector(collectionView:customLayout:referenceSizeForFooterInSection:)]) {
        CGSize footerSize = [self.vv_layoutDelegate collectionView:collectionView customLayout:self referenceSizeForFooterInSection:section];
        footerHeight = footerSize.height;
    }
    UICollectionViewLayoutAttributes *footerLayoutAttribute = [[UICollectionViewLayoutAttributes alloc] init];
    footerLayoutAttribute.indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    if (footerHeight > 0) {
        footerLayoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    }
    footerLayoutAttribute.frame = CGRectMake(0.0, self.contentHeight + maxOffsetValue, contentWidth, footerHeight);
    [self.footerLayoutAttributes addObject:footerLayoutAttribute];
    
    [self.originFooterLayoutAttributes addObject:[footerLayoutAttribute copy]];
    sectionLayoutModel.footerLayoutAttributes = [footerLayoutAttribute copy];
    return footerHeight;
}

- (CGSize)collectionViewContentSize
{
    if ([self.vv_layoutDelegate respondsToSelector:@selector(useCustomContentSize)] &&
        [self.vv_layoutDelegate respondsToSelector:@selector(customContentSize)] &&
        [self.vv_layoutDelegate useCustomContentSize]) {
        ///使用自定义contentSize,、
        return [self.vv_layoutDelegate customContentSize];;
    }
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    CGFloat width = CGRectGetWidth(self.collectionView.bounds) - contentInset.left - contentInset.right;
    CGFloat height = MAX(CGRectGetHeight(self.collectionView.bounds), self.contentHeight);
    return CGSizeMake(width, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray<UICollectionViewLayoutAttributes *> *result = [NSMutableArray array];
    
    // 悬停
    if (self.sectionHeadersPinToVisibleBounds) {
        for (UICollectionViewLayoutAttributes *attriture in self.headerLayoutAttributes) {
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
                                 MAX(self.collectionView.contentOffset.y + self.contentOffsetY, CGRectGetMinY(itemAttribute.frame)-headerHeight-contentInsetOfSection.top),
                                 CGRectGetMinY(attriture.frame)+[self.heightOfSections[section] floatValue]-headerHeight
                                 );
            attriture.frame = frame;
            attriture.zIndex = (NSIntegerMax/2)+section;
        }
    }
    
    [self.sectionLayoutModels enumerateObjectsUsingBlock:^(VVCollectionLayoutSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger section = idx;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        [self mutableArray:result addDecorationViewAttributWithIndexPath:indexPath];
        if(obj.headerLayoutAttributes
           && !(obj.headerLayoutAttributes.frame.size.height == 0)
           && CGRectIntersectsRect(rect, obj.headerLayoutAttributes.frame)) {
            [result addObject:obj.headerLayoutAttributes];
        }
        
        if (obj.itemLayoutAttributes_list.count > 0) {
            [obj.itemLayoutAttributes_list enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(CGRectIntersectsRect(rect, obj.frame)) {
                    [result addObject:obj];
                }
                            
            }];
        }
        
        if(obj.footerLayoutAttributes
           && !(obj.footerLayoutAttributes.frame.size.height == 0)
           && CGRectIntersectsRect(rect, obj.footerLayoutAttributes.frame)) {
            [result addObject:obj.footerLayoutAttributes];
        }
        
    }];
    
    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<UICollectionViewLayoutAttributes *> *tempArray = (NSArray<UICollectionViewLayoutAttributes *> *)[self.itemLayoutAttributes vv_arrayWithIndex:indexPath.section];
    return [tempArray vv_objectWithIndex:indexPath.item];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [self.headerLayoutAttributes vv_objectWithIndex:indexPath.section];
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [self.footerLayoutAttributes vv_objectWithIndex:indexPath.section];
    }
    return nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (self.sectionHeadersPinToVisibleBounds) {
        return YES;
    } else {
        return [super shouldInvalidateLayoutForBoundsChange:newBounds];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes* att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    CGFloat sectionHeight = [self.heightOfSections[indexPath.section] floatValue];
    CGFloat origin_y = [self originYofSection:indexPath.section];
    UIEdgeInsets sectionInsets = [self contentInsetForSection:indexPath.section];
    //origin_y = origin_y + sectionInsets.top ;
    if (self.vv_layoutDelegate &&
        [self.vv_layoutDelegate respondsToSelector:@selector(overLapHeightForDocarationViewAtSection:)]) {
        CGFloat overlapHeight = [self.vv_layoutDelegate overLapHeightForDocarationViewAtSection:indexPath.section];
//        origin_y -= overlapHeight;
    }
    NSLog(@"坐标坐标坐标%f 分区分区分区%d",origin_y,indexPath.section);
    att.frame = CGRectMake(0, origin_y, self.collectionView.contentSize.width, sectionHeight - sectionInsets.bottom);
    att.zIndex= -1;
    return att;
}

- (UICollectionViewLayoutAttributes *)originLayoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [self.originHeaderLayoutAttributes vv_objectWithIndex:indexPath.section];
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [self.originFooterLayoutAttributes vv_objectWithIndex:indexPath.section];
    }
    return nil;
}

- (CGFloat)itemWidthOfIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    CGFloat contentWidth = self.collectionView.bounds.size.width - contentInset.left - contentInset.right;
    UIEdgeInsets contentInsetOfSection = [self contentInsetForSection:indexPath.section];
    CGFloat minimumInteritemSpacing = [self minimumInteritemSpacingForSection:indexPath.section];
    NSInteger columnOfSection = [self columnNumAtSection:indexPath.section];
    CGFloat contentWidthOfSection = contentWidth - contentInsetOfSection.left - contentInsetOfSection.right;
    CGFloat itemWidth = (contentWidthOfSection - (columnOfSection - 1) * minimumInteritemSpacing) / columnOfSection;
    return itemWidth;
}

#pragma mark - Private
- (UIEdgeInsets)contentInsetForSection:(NSInteger)section
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if ([self.vv_layoutDelegate respondsToSelector:@selector(collectionView:customLayout:insetForSectionAtIndex:)]) {
        edgeInsets = [self.vv_layoutDelegate collectionView:self.collectionView customLayout:self insetForSectionAtIndex:section];
    }
    return edgeInsets;
}

- (CGFloat)minimumLineSpacingForSection:(NSInteger)section
{
    CGFloat minimumLineSpacing = self.minimumLineSpacing;
    if ([self.vv_layoutDelegate respondsToSelector:@selector(collectionView:customLayout:minimumLineSpacingForSectionAtIndex:)]) {
        minimumLineSpacing = [self.vv_layoutDelegate collectionView:self.collectionView customLayout:self minimumLineSpacingForSectionAtIndex:section];
    }
    return minimumLineSpacing;
}

- (CGFloat)minimumInteritemSpacingForSection:(NSInteger)section
{
    CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
    if ([self.vv_layoutDelegate respondsToSelector:@selector(collectionView:customLayout:minimumInteritemSpacingForSectionAtIndex:)]) {
        minimumInteritemSpacing = [self.vv_layoutDelegate collectionView:self.collectionView customLayout:self minimumInteritemSpacingForSectionAtIndex:section];
    }
    return minimumInteritemSpacing;
}

- (NSInteger)columnNumAtSection:(NSInteger)section
{
    NSInteger columnOfSection = 1;
    if ([self.vv_layoutDelegate respondsToSelector:@selector(collectionView:customLayout:columnNumberAtSection:)]) {
        columnOfSection = [self.vv_layoutDelegate collectionView:self.collectionView customLayout:self columnNumberAtSection:section];
        return columnOfSection;
    } else {
#if DEBUG
        NSAssert(NO, @"未设置列数");
#endif
    }
    return 1;
}

- (void)vv_registerDecorationViews
{
    if (self.vv_layoutDelegate
        && [self.vv_layoutDelegate respondsToSelector:@selector(decorationViewClasses)]) {
        NSArray <Class>*classes = [self.vv_layoutDelegate decorationViewClasses];
        for (Class decorationViewClass in classes) {
            if ([decorationViewClass isSubclassOfClass:[VVBaseCollectionDecorationView class]]
                && [decorationViewClass respondsToSelector:@selector(kind)]) {
                [self registerClass:decorationViewClass forDecorationViewOfKind:[decorationViewClass kind]];
            }
        }
    }
}

- (void)mutableArray:(NSMutableArray *)results addDecorationViewAttributWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.vv_layoutDelegate
        && [self.vv_layoutDelegate respondsToSelector:@selector(decorationViewClassOfIndexPath:)]) {
        Class decorationViewClass = [self.vv_layoutDelegate decorationViewClassOfIndexPath:indexPath];
        if ([decorationViewClass isSubclassOfClass:[VVBaseCollectionDecorationView class]]
            && [decorationViewClass respondsToSelector:@selector(kind)]) {
            [results addObject:[self layoutAttributesForDecorationViewOfKind:[decorationViewClass kind] atIndexPath:indexPath]];
        }
    }
}

- (CGFloat)originYofSection:(NSUInteger)section
{
    NSLog(@"高度高度高度高度%@",self.heightOfSections);
    CGFloat origin_y = 0;
    
    VVCollectionLayoutSectionModel *layoutSectionModel = [self.sectionLayoutModels vv_objectWithIndex:section];
    if (CGRectGetHeight(layoutSectionModel.headerLayoutAttributes.frame) > 0) {
        ///有头部的从头部开始
        origin_y = layoutSectionModel.headerLayoutAttributes.frame.origin.y;
    } else {
        UICollectionViewLayoutAttributes *layoutAttributes = [layoutSectionModel.itemLayoutAttributes_list vv_objectWithIndex:0];
        origin_y = layoutAttributes.frame.origin.y;
    }
//    for (NSUInteger index = 0; index < section; index++) {
//      CGFloat sectionHeight = [self.heightOfSections[index] floatValue];
//
//        origin_y += sectionHeight;
//    }
    NSLog(@"圆点原地圆点圆点圆点%f, 分区分区分区%d",origin_y,section);
    return origin_y;
}


@end
