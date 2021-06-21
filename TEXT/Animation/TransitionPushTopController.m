//
//  TransitionPushTopController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/4/7.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "TransitionPushTopController.h"
#import "Header.h"

@interface TransitionPushTopController ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) NSArray *titlearray;

@property (nonatomic, assign) NSInteger index;

@end

@implementation TransitionPushTopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    self.titlearray = @[@"biatbiaot", @"表头", @"hahaha哈哈"];
    [self.button setTitle:self.titlearray.firstObject forState:UIControlStateNormal];
    @weakify(self);
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        @strongify(self);
        [self click];
    }];
    // Do any additional setup after loading the view.
}

- (void)click
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.duration = 1;
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.timingFunction = function;
    self.index ++;
    if (self.index >= self.titlearray.count - 1) {
        self.index = 0;
    }
    NSString *title = self.titlearray[self.index];
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button.layer addAnimation:transition forKey:@"move"];
  }

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(100, 100, 100, 100);
        _button.backgroundColor = [UIColor grayColor];
        [_button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
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
