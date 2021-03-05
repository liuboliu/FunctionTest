//
//  UIViewController+SafePresent.m
//  FloryDay
//
//  Created by Yongjian Ling on 25/12/17.
//  Copyright © 2017年 FloryDay. All rights reserved.
//

#import "UIViewController+TDSafePresent.h"

@implementation UIViewController (TDSafePresent)

- (void)safePresentViewController:(UIViewController *)viewController animated:(BOOL)flag completion:(void (^)(void))completion
{
    if (!viewController) {
        return;
    }
    
    if (self.presentedViewController) {
        if (self.presentedViewController == viewController) {
            return;
        } else {
            return;
        }
    }
    
    if (@available(iOS 13.0, *)) {
        if (viewController.modalPresentationStyle == UIModalPresentationPageSheet) {
            viewController.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    } else {
        
    }
    [self presentViewController:viewController animated:flag completion:completion];
}

- (void)safePresentViewController:(UIViewController *)viewController
           modalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle
                         animated:(BOOL)flag
                       completion:(void (^)(void))completion
{
    if (!viewController) {
        return;
    }
    
    if (self.presentedViewController) {
        if (self.presentedViewController == viewController) {
            return;
        } else {
            return;
        }
    }
    
    viewController.modalPresentationStyle = modalPresentationStyle;
    [self presentViewController:viewController animated:flag completion:completion];
}

@end
