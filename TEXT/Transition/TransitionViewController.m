//
//  TransitionViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/5.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "TransitionViewController.h"
#import "PresentedViewController.h"
#import "PresentedViewController.h"
#import "UIViewController+TDSafePresent.h"

@interface TransitionViewController ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1);
    
    UIButton *button2  = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self action:@selector(transition) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(200, 100, 100, 100);
    button2.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button2];
}

- (void)transition
{
    [self.view addSubview:self.contentView];
    CATransition *animation = [CATransition animation];
    [animation setDuration:4.0f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromTop];
    [self.contentView.layer addAnimation:animation forKey:nil];
}

- (void)click
{
    PresentedViewController *pre = [[PresentedViewController alloc] init];
    [self safePresentViewController:pre animated:YES completion:nil];
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 300, 300)];
        _contentView.backgroundColor = [UIColor cyanColor];
    }
    return _contentView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
