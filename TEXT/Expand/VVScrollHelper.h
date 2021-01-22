//
//  JKScrollHelper.h
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 头部背景视图风格
typedef NS_ENUM(NSUInteger, VVHeaderBackStyle) {
    VVHeaderBackStyleExpand = 0, ///< 默认样式，头部放大
    VVHeaderBackStyleFixed = 1, /// < 头部固定大小（不放大）
};

@interface VVScrollExtraViewConfig : NSObject

/// frontView,backgroundView尺寸大小保持一致

@property (nonatomic, weak) __kindof UIView *frontView;
@property (nonatomic, weak) __kindof UIView *backgroundView;

@property (nonatomic, assign) VVHeaderBackStyle headerStyle;

@end

@interface VVScrollHelper : NSObject

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

/// 初始化
/// @param scrollView 滚动视图
/// @param headerConfig 配置对象
/// @param headerOverHeight 滚动视图内容对背景视图的覆盖高度
+ (VVScrollHelper *)initWithScrollView:(UIScrollView *)scrollView
                      headerViewConfig:(VVScrollExtraViewConfig *)headerConfig
                      headerOverHeight:(CGFloat)headerOverHeight;

@end
