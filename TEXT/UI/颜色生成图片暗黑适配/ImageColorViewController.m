//
//  ImageColorViewController.m
//  TEXT
//
//  Created by liubo on 2021/4/19.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "UIColor+TDHelp.h"
#import "ImageColorViewController.h"

@interface ImageColorViewController ()


@end

@implementation ImageColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    image.image = [UIColor imageWithColor:[UIColor colorNamed:@"kkk"]];
//    [self.view addSubview:image];
    
    CAShapeLayer *layery = [[CAShapeLayer alloc] init];
    layery.frame = CGRectMake(0, 0, 100, 100);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];
    path.lineWidth = 2;
    layery.fillColor = [UIColor clearColor].CGColor;
    layery.strokeColor = [UIColor redColor].CGColor;
    layery.path = path.CGPath;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    v.backgroundColor = [UIColor cyanColor];
    v.layer.mask = layery;
    [self.view addSubview:v];
//    self.view.backgroundColor = [UIColor cyanColor];
    // Do any additional setup after loading the view.
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
