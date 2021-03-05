//
//  UIViewController+SafePresent.h
//  FloryDay
//
//  Created by Yongjian Ling on 25/12/17.
//  Copyright © 2017年 FloryDay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TDSafePresent)

/// present vc，内部加了一层保护
/// iOS 13上modalPresentationStyle默认为UIModalPresentationAutomatic，不同业务会解析成不同。
/// 默认映射成UIModalPresentationPageSheet，UISearchController和UIAlertController映射到其他类型
/// 该方法不支持UIModalPresentationPageSheet，默认会变成UIModalPresentationFullScreen
/// @param viewController 控制器
/// @param flag 动画标识
/// @param completion 结束回调
- (void)safePresentViewController:(UIViewController *)viewController animated:(BOOL)flag completion:(void (^)(void))completion;

/// present vc，内部加了一层保护
/// 自定义modalPresentationStyle
/// @param viewController 控制器
/// @param modalPresentationStyle modalPresentationStyle
/// @param flag 动画标识
/// @param completion 结束回调
- (void)safePresentViewController:(UIViewController *)viewController
           modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
                         animated:(BOOL)flag
                       completion:(void (^)(void))completion;

@end
