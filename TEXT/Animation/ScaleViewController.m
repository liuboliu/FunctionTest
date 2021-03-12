//
//  ScaleViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/12.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "ScaleViewController.h"

@interface ScaleViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [self buttonWithTitle:@"关键帧动画放大" sele:@selector(keyframeScale)];
    self.button.frame = CGRectMake(100, 200, 100, 100);
    // Do any additional setup after loading the view.
}

- (void)keyframeScale
{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//    animation.beginTime = CACurrentMediaTime() +1;
    animation.values = @[@1, @2];
    animation.duration = 4;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.button.layer addAnimation:animation forKey:@"animation"];
}

- (UIButton *)buttonWithTitle:(NSString *)title sele:(SEL)sele
{
    UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buton setTitle:title forState:UIControlStateNormal];
    buton.backgroundColor = [UIColor redColor];
    [buton addTarget:self action:sele forControlEvents:UIControlEventTouchUpInside];
    buton.titleLabel.font = [UIFont systemFontOfSize:9];
    [self.view addSubview:buton];
    return buton;
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
