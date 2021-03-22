//
//  AnimationGroupController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/19.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "AnimationGroupController.h"

@interface AnimationGroupController () <CAAnimationDelegate>

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) NSInteger currentindex;

@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, assign) NSInteger nextIndex;

@property (nonatomic, assign) NSInteger showIndex;

@end

@implementation AnimationGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"哈哈哈哈1",@"啦啦啦2", @"嘎嘎嘎3",@"你好你好你好4",@"咕咕咕咕5"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(10, 200, 100, 40);
    [self.button setTitle:@"标题哈哈哈" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(animation2) forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame = CGRectMake(10, 204, 100, 40);
    [self.button2 setTitle:@"标题哈哈哈" forState:UIControlStateNormal];
    self.button2.backgroundColor = [UIColor whiteColor];
    self.button2.alpha = 0;
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.button2];
    [self.button2 addTarget:self action:@selector(animation2) forControlEvents:UIControlEventTouchUpInside];
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:3.4 repeats:YES block:^(NSTimer * _Nonnull timer) {
       // [self animation2];
        [self animation3];
    }];
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[NSRunLoop currentRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view.
}

- (void)animation2
{
    [UIView animateWithDuration:0.3 animations:^{
        self.button.frame = CGRectMake(10, 197, 100, 40);
    } completion:^(BOOL finished) {
            
    }] ;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.button.alpha = 0;
    } completion:^(BOOL finished) {
        [self show];
        self.button.frame = CGRectMake(10, 200, 100, 40);
    }];
}

- (void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        self.button2.frame = CGRectMake(10, 200, 100, 40);
    } completion:^(BOOL finished) {
            
    }] ;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.button2.alpha = 1;
    } completion:^(BOOL finished) {
        self.button2.frame = CGRectMake(10, 203, 100, 40);
        self.button2.alpha = 0;
        self.button.alpha = 1;
    }];
}

- (void)animation3
{
    [self.button setTitle:self.titles[self.currentindex] forState:UIControlStateNormal];
    [self.button2 setTitle:self.titles[self.nextIndex] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.4 animations:^{
        self.button.alpha = 0;

    } completion:^(BOOL finished) {
            
    }] ;
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.button.frame = CGRectMake(10, 196, 100, 40);

    } completion:^(BOOL finished) {
        [self show3];
        self.button.frame = CGRectMake(10, 200, 100, 40);
    }];

}

- (void)show3
{
        [UIView animateWithDuration:0.4 animations:^{
            self.button2.alpha = 1;

        } completion:^(BOOL finished) {
                
        }] ;
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            self.button2.frame = CGRectMake(10, 200, 100, 40);

        } completion:^(BOOL finished) {
            self.button2.frame = CGRectMake(10, 204, 100, 40);
            self.button2.alpha = 0;
            self.button.alpha = 1;
            self.currentindex ++;
            if (self.currentindex >= self.titles.count) {
                self.currentindex = 0;
            }
            [self.button setTitle:self.titles[self.currentindex] forState:UIControlStateNormal];
        }];
}

- (void)animatin
{
    self.currentindex ++;
    if (self.currentindex == self.titles.count) {
        self.currentindex = 0;
    }
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];

    translation.fromValue = @(0);
    translation.toValue = @(-20);
    translation.duration = .5;
    
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.duration = .2;
    alpha.toValue = @(0);
    alpha.removedOnCompletion = NO;
    alpha.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[translation,alpha];
    group.duration = .5;
    group.removedOnCompletion = NO;
    group.delegate = self;
    [self.button.layer addAnimation:group forKey:@"kk"];
    
    
    CABasicAnimation *translation2 = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];

    translation2.fromValue = @(0);
    translation2.toValue = @(-20);
    translation2.duration = .5;
    
    CABasicAnimation *alpha2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha2.duration = .5;
    alpha2.toValue = @(1);
    
    alpha2.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    
    CAAnimationGroup *group2 = [[CAAnimationGroup alloc] init];
    group.animations = @[translation2,alpha2];
    group.duration = .5;
    group.removedOnCompletion = YES;
    [self.button2.layer addAnimation:group2 forKey:@"kk"];

}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [self.button setTitle:self.titles[self.currentindex] forState:UIControlStateNormal];
//        self.button2.alpha = 0;
    }
}



+ (UIColor*)randomColor

{

CGFloat hue = (arc4random() %256/256.0);

CGFloat saturation = (arc4random() %128/256.0) +0.5;

CGFloat brightness = (arc4random() %128/256.0) +0.5;

UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

return color;

}

- (NSInteger)nextIndex
{
    if (self.currentindex + 1 >= self.titles.count) {
        return 0;
    }
    return self.currentindex + 1;
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
