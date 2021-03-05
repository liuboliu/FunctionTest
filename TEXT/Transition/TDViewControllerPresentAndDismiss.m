//
//  TDViewControllerPresentAndDismiss.m
//  FloryDay
//
//  Created by 燕永斌 on 2017/7/23.
//  Copyright © 2017年 FloryDay. All rights reserved.
//

#import "TDViewControllerPresentAndDismiss.h"

@interface TDViewControllerPresentAndDismissModel : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithType:(NSString *)type duration:(CGFloat)duration;

// type
// - present
// - dismiss
@property (copy, nonatomic) NSString * type;
// duration
@property (assign, nonatomic) CGFloat duration;
// blockPresentAndDismiss
@property (copy, nonatomic) TDViewControllerPresentAndDismissBlock presentAndDismiss;

@end

@implementation TDViewControllerPresentAndDismissModel

- (instancetype)initWithType:(NSString *)type duration:(CGFloat)duration
{
    if (self = [super init]) {
        self.type = type;
        self.duration = duration;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView * from = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * to = [transitionContext viewForKey:UITransitionContextToViewKey];
    if ([self.type isEqualToString:@"present"]) {
        [transitionContext.containerView addSubview:to];
    }
    self.presentAndDismiss(^void (void){
        if ([self.type isEqualToString:@"dismiss"]) {
            [from removeFromSuperview];
        }
        [transitionContext completeTransition:true];
    });
}

@end

@interface TDViewControllerPresentAndDismiss ()

@property (weak, nonatomic) UIViewController * viewController;

@property (assign, nonatomic) CGFloat duration;

@property (copy, nonatomic) TDViewControllerPresentAndDismissBlock present;
@property (copy, nonatomic) TDViewControllerPresentAndDismissBlock dismiss;

@end

@implementation TDViewControllerPresentAndDismiss

- (instancetype)initWithViewController:(UIViewController *)viewController duration:(CGFloat)duration present:(TDViewControllerPresentAndDismissBlock)present dismiss:(TDViewControllerPresentAndDismissBlock)dismiss
{
    if (self = [super init]) {
        self.viewController = viewController;
        [self setTDViewControllerPresentAndDismiss];
        self.duration = duration;
        self.present = present;
        self.dismiss = dismiss;
    }
    return self;
}

- (void)setTDViewControllerPresentAndDismiss 
{
    self.viewController.transitioningDelegate = self;
    self.viewController.modalPresentationStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    TDViewControllerPresentAndDismissModel * present = [[TDViewControllerPresentAndDismissModel alloc] initWithType:@"present" duration:self.duration];
    present.presentAndDismiss = self.present;
    return present;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    TDViewControllerPresentAndDismissModel * dismiss = [[TDViewControllerPresentAndDismissModel alloc] initWithType:@"dismiss" duration:self.duration];
    dismiss.presentAndDismiss = self.dismiss;
    return dismiss;
}

@end
