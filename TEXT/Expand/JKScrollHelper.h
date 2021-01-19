//
//  JKScrollHelper.h
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JKScrollHelperView:UIView

@end;


@interface JKScrollExtraViewConfig : NSObject
/// frontView,backgroundView尺寸大小保持一致
@property (nonatomic, weak) __kindof JKScrollHelperView *frontView;
@property (nonatomic, weak) __kindof JKScrollHelperView *backgroundView;

@end

@interface JKScrollHelper : NSObject

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;


+ (instancetype)initWithScrollView:(UIScrollView *)scrollView
                  headerViewCofnig:(JKScrollExtraViewConfig *)headerConfig
                   commonSuperView:(__kindof UIView *)commonSuperView;
/**
 滚动时透视图执行相关的放大操作

 @param scrollView 滚动视图
 @param insetHeight scrollView距离父视图顶部的缩进
 */
- (void)scrollViewDidSroll:(UIScrollView *)scrollView superViewInsetHeight:(CGFloat)insetHeight;


@end
