//
//  SPPageMenu.h
//  SPPageMenu
//
//  Created by 乐升平 on 17/10/26.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"

//NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
NS_ASSUME_NONNULL_BEGIN

@class SPPageMenu;

@protocol SPPageMenuDelegate <NSObject>

@optional

// 若以下2个代理方法同时实现了，那么只会走第2个代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index;
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end

@interface SPPageMenu : UIView

- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
/// 初始化
/// @param frame frame
/// @param config 配置
- (instancetype)initWithFrame:(CGRect)frame
                       config:(PageViewConfiguration *)config NS_DESIGNATED_INITIALIZER;

/**
 *  传递数组(数组元素只能是NSString或UIImage类型)
 *
 *  @param items    数组
 *  @param selectedItemIndex  选中哪个item
 */
- (void)setItems:(nullable NSArray *)items selectedItemIndex:(NSUInteger)selectedItemIndex;

/** 选中的item下标 */
@property (nonatomic) NSUInteger selectedItemIndex;

/** 外界的srollView，pageMenu会监听该scrollView的滚动状况，让跟踪器时刻跟随此scrollView滑动 */
@property (nonatomic, strong) UIScrollView *bridgeScrollView;
/** 关闭跟踪器的跟随效果,在外界传了scrollView进来或者调用了moveTrackerFollowScrollView的情况下,如果为YES，则当外界滑动scrollView时，跟踪器不会时刻跟随,只有滑动结束才会跟踪; 如果为NO，跟踪器会时刻跟随scrollView */
@property (nonatomic, assign) BOOL closeTrackerFollowingMode;

/** item之间的间距,当permutationWay为‘SPPageMenuPermutationWayNotScrollAdaptContent’时此属性无效 */
//@property (nonatomic, assign) CGFloat itemPadding;
/** item的标题字体 */
@property (nonnull, nonatomic, strong) UIFont *itemTitleFont;
/** 选中的item标题颜色 */
@property (nonatomic, strong) UIColor *selectedItemTitleColor;
/** 未选中的item标题颜色 */
@property (nonatomic, strong) UIColor *unSelectedItemTitleColor;
/** 跟踪器 */
@property (nonatomic, readonly) UIImageView *tracker;

/** 代理 */
@property (nonatomic, weak) id<SPPageMenuDelegate> delegate;

/** 内容的四周内边距(内容不包括分割线) */
@property (nonatomic, assign) UIEdgeInsets contentInset;

// 获取指定item的标题
- (nullable NSString *)titleForItemAtIndex:(NSUInteger)itemIndex;

// 获取指定item的图片
- (nullable UIImage *)imageForItemAtIndex:(NSUInteger)itemIndex;

@end

NS_ASSUME_NONNULL_END





