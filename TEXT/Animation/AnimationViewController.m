//
//  AnimationViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/11.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) UIButton *button3;

@property (nonatomic, strong) UIButton *button4;

@property (nonatomic, strong) UIButton *butoon5;

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *button6;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 100, 100, 100);
//    button.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:button];
//    [button setTitle:@"transform动画" forState:UIControlStateNormal];
//    self.button = button;
//    [self.button addTarget:self action:@selector(trancfrom) forControlEvents:UIControlEventTouchUpInside];
//    self.button.titleLabel.font = [UIFont systemFontOfSize:8];

    
    self.button1 = [self buttonWithTitle:@"layer 3d位移" sele:@selector(layerThreeDtranslation)];
    self.button1.frame = CGRectMake(0, 200, 100, 100);
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2 = button2;
    button2.frame = CGRectMake(100, 200, 100, 100);
    [button2 addTarget:self action:@selector(translation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button2];
    [self.button2 setTitle:@"view transform位移" forState:UIControlStateNormal];
    self.button2.titleLabel.font = [UIFont systemFontOfSize:8];
    self.button2.backgroundColor = [UIColor magentaColor];
    
    self.button3 = [self buttonWithTitle:@"基本动画位移" sele:@selector(baseAnimationTransation)];
    self.button3.frame = CGRectMake(0, 100, 100, 100);
    
    self.button4 = [self buttonWithTitle:@"uiview动画位移" sele:@selector(uiviewanimcation)];
    self.button4.frame = CGRectMake(200, 100, 100, 100);
    
    self.butoon5 = [self buttonWithTitle:@"viewtran3d位移" sele:@selector(threedTranslation)];
    self.butoon5.frame = CGRectMake(200, 200, 100, 100);
    
    self.button6 = [self buttonWithTitle:@"关键帧动画" sele:@selector(keyFrameAnimation)];
    self.button6.frame = CGRectMake(100, 100, 100, 100);
    
    
    // Do any additional se tup after loading the view.
}

- (void)trancfrom
{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:0.5f];//动画时间
    self.button.transform = CGAffineTransformMakeScale(1, -1);
//    self.button.transform = CGAffineTransformMakeTranslation(100, 100);
    [UIView commitAnimations]; //启动动画
}

- (void)translation
{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:0.5f];//动画时间
    self.button2.transform = CGAffineTransformMakeTranslation(0, 200);
    [UIView commitAnimations]; //启动动画

}

- (void)baseAnimationTransation
{
    CABasicAnimation*animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    animation.beginTime = CACurrentMediaTime() +1;
    animation.toValue= @(200);
    animation.duration = 4;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.button3.layer addAnimation:animation forKey:@"animation"];
}

- (void)uiviewanimcation
{
    [UIView animateWithDuration:4 animations:^{
        self.button4.frame  = CGRectMake(0, 200, 100, 100);
    }];
}

- (void)threedTranslation
{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:0.5f];//动画时间
    if (@available(iOS 13.0, *)) {
        self.butoon5.transform3D = CATransform3DMakeTranslation(0, 100, 0);
    } else {
        // Fallback on earlier versions
    }
    [UIView commitAnimations]; //启动动画
}

- (void)layerThreeDtranslation
{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:0.5f];//动画时间
    self.button1.layer.transform = CATransform3DMakeTranslation(0, 200, 0);
    [UIView commitAnimations]; //启动动画

}

- (void)keyFrameAnimation
{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//    animation.beginTime = CACurrentMediaTime() +1;
    animation.values = @[@0, @200];
    animation.duration = 4;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.button6.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark - util
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
