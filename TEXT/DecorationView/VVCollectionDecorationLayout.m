//
//  VVCollectionDecorationLayout.m
//  VOVA
//
//  Created by 刘博 on 2020/11/11.
//  Copyright © 2020 iOS. All rights reserved.
//

#import "VVCollectionDecorationLayout.h"
#import "VVCategoryBannerDecorationView.h"
#import "VVBaseCollectionDecorationView.h"
// 判断反向布局
#define IS_RightToLeft \
({BOOL isRightToLeft = NO;\
if ([UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {\
    isRightToLeft = YES;\
}\
(isRightToLeft);})\

@interface VVCollectionDecorationLayout ()

///装饰视图布局属性数组
@property (nonatomic, copy) NSArray<UICollectionViewLayoutAttributes *> * decorationViewAttrs;

@end

@implementation VVCollectionDecorationLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self caculateDecorationLayoutAttributes];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray<UICollectionViewLayoutAttributes *> *originAttrs = [super layoutAttributesForElementsInRect:rect];
    if (self.adjustHeaderAndFooterLayout) {
        ///适配头部，需要修改头部视图布局
        // if use NSEnumerationConcurrent, get main thread warning: Main Thread Checker: UI API called on a background thread: -[UIScrollView delegate]
        [originAttrs enumerateObjectsWithOptions:0 usingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.representedElementKind isEqualToString:UICollectionElementKindSectionHeader] || [obj.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
                
                // get section insets
                UIEdgeInsets sectionInsets = UIEdgeInsetsZero;
                if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                    sectionInsets = [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:obj.indexPath.section];
                }
                else {
                    sectionInsets = self.sectionInset;
                }
                
                // get extend insets
                UIEdgeInsets decorationInsets = self.decorationExtendEdges ? self.decorationExtendEdges(obj.indexPath.section): UIEdgeInsetsZero;
                
                CGRect frame = obj.frame;
                if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
                    if (IS_RightToLeft) {
                        ///适配反向布局
                        frame.origin.x += (sectionInsets.right - decorationInsets.right);
                    } else {
                        frame.origin.x += (sectionInsets.left - decorationInsets.left);
                    }
                    frame.size.width -= (sectionInsets.left + sectionInsets.right - decorationInsets.left - decorationInsets.right);
                } else {
                    frame.origin.y += (sectionInsets.top - decorationInsets.top);
                    frame.size.height -= (sectionInsets.top + sectionInsets.bottom - decorationInsets.top - sectionInsets.bottom);
                }
                obj.frame = frame;
            }
        }];
    }
    
    NSMutableArray *mut_originAttrs = originAttrs.mutableCopy;
    [mut_originAttrs addObjectsFromArray:self.decorationViewAttrs];
    
    return mut_originAttrs.copy;
}

///计算装饰视图布局属性
- (void)caculateDecorationLayoutAttributes {
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections > 0) {
        NSMutableArray *decorationViewsAttrs = [NSMutableArray arrayWithCapacity:numberOfSections];
        if (self.vvDelegate && [self.vvDelegate respondsToSelector:@selector(decorationViewClassOfSection:)]) {
            for (NSInteger section = 0; section < numberOfSections; section++) {
                Class decorationViewClass = [self.vvDelegate decorationViewClassOfSection:section];
                NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
                UICollectionViewLayoutAttributes *decorationViewAttr ;
                if ([decorationViewClass isSubclassOfClass:[VVBaseCollectionDecorationView class]]
                    && [decorationViewClass respondsToSelector:@selector(kind)]) {
                    decorationViewAttr =  [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[decorationViewClass kind] withIndexPath:firstItemIndexPath];
                    decorationViewAttr.frame = [self decrationViewFrameForSection:section];
                    decorationViewAttr.zIndex = -1;
                    [decorationViewsAttrs addObject:decorationViewAttr];
                }
            }
        }
        self.decorationViewAttrs = decorationViewsAttrs;
    }
}

///创建某个分区的装饰视图布局
- (CGRect)decrationViewFrameForSection:(NSInteger)section {
    CGRect decrationFrame = CGRectZero;
    
    NSInteger sectionItemCount = [self.collectionView numberOfItemsInSection:section];
    if (sectionItemCount == 0) {
        return decrationFrame;
    }
    
    UICollectionViewLayoutAttributes *firstItemAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    UICollectionViewLayoutAttributes *lastItemAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:(sectionItemCount - 1) inSection:section]];

    if (self.decorationContainsHeader) {
        ///装饰视图范围包含头部的时候，需要从头部开始
        firstItemAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    }
    
    CGRect firstItemFrame = firstItemAttr.frame;
    CGRect lastItemFrame = lastItemAttr.frame;
    
    UIEdgeInsets sectionInsets = UIEdgeInsetsZero;
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        sectionInsets = [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    else {
        sectionInsets = self.sectionInset;
    }
    
    decrationFrame.origin.x = firstItemFrame.origin.x;
    if (self.decorationContainsHeader) {
        ///包含头部的话需要以头部为准
        UIEdgeInsets decorationInsets = self.decorationExtendEdges?self.decorationExtendEdges(section):UIEdgeInsetsZero;
        decrationFrame.origin.x += (sectionInsets.left - decorationInsets.left);

    }
    if (IS_RightToLeft) {
        //适配反向布局
        decrationFrame.origin.x = sectionInsets.right;
    }
    decrationFrame.origin.y = firstItemFrame.origin.y;
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        decrationFrame.size.height = CGRectGetMaxY(lastItemFrame) - firstItemFrame.origin.y;
        decrationFrame.size.width = CGRectGetWidth(self.collectionView.bounds) - sectionInsets.left - sectionInsets.right;
    } else {
        decrationFrame.size.height = CGRectGetHeight(self.collectionView.bounds) - sectionInsets.top - sectionInsets.bottom;
        decrationFrame.size.width = CGRectGetMaxX(lastItemFrame) - firstItemFrame.origin.x;
    }
    
    UIEdgeInsets insets = self.decorationExtendEdges ? self.decorationExtendEdges(section): UIEdgeInsetsZero;
    if (!UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        decrationFrame.origin.x -= insets.left;
        if (IS_RightToLeft) {
            decrationFrame.origin.x -= insets.right;
        }
        decrationFrame.origin.y -= insets.top;
        decrationFrame.size.width += (insets.left + insets.right);
        decrationFrame.size.height += (insets.top + insets.bottom);
    }
    
    return decrationFrame;
}

@end
