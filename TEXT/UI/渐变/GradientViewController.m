//
//  GradientViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/4/7.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "GradientViewController.h"
#import "UIColor+TDHelp.h"

@interface GradientViewController ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    // Do any additional setup after loading the view.
}

#pragma mark - lazy load
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
        _contentView.backgroundColor = [UIColor cyanColor];
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,200,100);
        gl.startPoint = CGPointMake(0, 0.3);
        gl.endPoint = CGPointMake(0, 0.8);
        gl.colors = @[(__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor redColor].CGColor];
        gl.locations = @[@(0), @(1)];
        [_contentView.layer addSublayer:gl];
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
