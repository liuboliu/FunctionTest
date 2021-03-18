//
//  PageView.h
//  TEXT
//
//  Created by Apple on 2021/3/13.
//  Copyright © 2021 刘博. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PageView;

@protocol PageViewDelegate <NSObject>

@optional

/// 滚动到某个位置
/// @param page 分页视图
/// @param index 视图索引
- (void)pageView:(PageView *)page didScrollToIndex:(NSInteger)index;

@end

@protocol PageViewDatasource <NSObject>

/// 分页视图的子视图数量
/// @param pageView 分页视图
- (NSInteger)numberOfViewForPageview:(PageView *)pageView;

/// 视图对象
/// @param pageView 分页视图
/// @param index 索引
- (UIView *)viewForPageView:(PageView *)pageView atIndex:(NSInteger)index;

@end

@interface PageViewConfiguration:NSObject

///标题数组
@property (nonatomic, strong) NSArray <NSString *> *titleArray;
/// 默认展示页面索引, 默认为0
@property (nonatomic, assign) NSInteger detaultIndex;
/// segment高度 默认为40
@property (nonatomic, assign) CGFloat segmentHeight;
/*
 标题按钮的宽度,默认为0， 此时自适应文案宽度
 */
@property (nonatomic, assign) CGFloat titleWidth;

///字体大小 ,默认16
@property (nonatomic, assign) CGFloat font;
/// 未选中文案颜色  ///默认999999
@property (nonatomic, strong) UIColor *normalColor;
///选中文案颜色 /// 默认333333
@property (nonatomic, strong) UIColor *selectColor;

@end

@interface PageView : UIView

- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame config:(PageViewConfiguration *)config NS_DESIGNATED_INITIALIZER;

///事件代理
@property (nonatomic, weak) id <PageViewDelegate> delegate;
///数据源
@property (nonatomic, weak) id <PageViewDatasource> dataSource;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
