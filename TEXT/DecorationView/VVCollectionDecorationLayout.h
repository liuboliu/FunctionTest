//
//  VVCollectionDecorationLayout.h
//  VOVA
//
//  Created by 刘博 on 2020/11/11.
//  Copyright © 2020 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIEdgeInsets(^DecorationExtendEdges)(NSInteger section);

NS_ASSUME_NONNULL_BEGIN

@protocol VVCollectionDecorationLayoutDelegte <NSObject>

- (Class)decorationViewClassOfSection:(NSInteger)section;

@end

@interface VVCollectionDecorationLayout : UICollectionViewFlowLayout

/// 装饰视图的边距默认 UIEdgeInsetZero
@property (nonatomic, copy) DecorationExtendEdges decorationExtendEdges;

///适配头部和尾部布局，头部和尾部的布局 用到 分区的edgeInset和 装饰视图的 edgeInset ，默认为NO
@property (nonatomic, assign) BOOL adjustHeaderAndFooterLayout;

////装饰视图范围包含头部，默认NO
@property (nonatomic, assign) BOOL decorationContainsHeader;

@property (nonatomic, weak) id <VVCollectionDecorationLayoutDelegte> vvDelegate;

@end

NS_ASSUME_NONNULL_END
