//
//  TDViewControllerPresentAndDismiss.h
//  FloryDay
//
//  Created by 燕永斌 on 2017/7/23.
//  Copyright © 2017年 FloryDay. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TDViewControllerPresentAndDismissCompletionBlock)(void);
typedef void(^TDViewControllerPresentAndDismissBlock)(TDViewControllerPresentAndDismissCompletionBlock completion);

@interface TDViewControllerPresentAndDismiss : NSObject <UIViewControllerTransitioningDelegate>

/**
 自定义弹出动画代理

 @param viewController 弹出的控制器
 @param duration 动画时长
 @param present 动画过程
 @param dismiss 动画结束回调
 @return 动画代理(自身)
 */
- (instancetype)initWithViewController:(UIViewController *)viewController duration:(CGFloat)duration present:(TDViewControllerPresentAndDismissBlock)present dismiss:(TDViewControllerPresentAndDismissBlock)dismiss;

@end
