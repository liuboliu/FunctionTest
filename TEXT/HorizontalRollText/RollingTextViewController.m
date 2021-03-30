//
//  RollingTextViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/30.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "RollingTextViewController.h"
#import "LMJHorizontalScrollText.h"

@interface RollingTextViewController ()

@property (nonatomic, strong) LMJHorizontalScrollText *scrollText3_1;

@end

@implementation RollingTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    _scrollText3_1 = [[LMJHorizontalScrollText alloc] initWithFrame: CGRectMake(15, 230, CGRectGetWidth(self.view.bounds) -30, 20)];
    _scrollText3_1.layer.cornerRadius = 3;
    _scrollText3_1.backgroundColor    = [UIColor cyanColor];
    _scrollText3_1.text               = @"<<<=向左，间断滚动(left，intermittent)130123987410238947102389740189237401892347";
    _scrollText3_1.textColor          = [UIColor whiteColor];
    _scrollText3_1.textFont           = [UIFont systemFontOfSize:14];
    _scrollText3_1.speed              = 0.03;
//    _scrollText3_1.moveDirection      = LMJTextScrollMoveLeft;
//    _scrollText3_1.moveMode           = LMJTextScrollIntermittent;
    [self.view addSubview:_scrollText3_1];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_scrollText3_1 move];
});

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
