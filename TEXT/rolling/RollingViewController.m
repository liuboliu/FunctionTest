//
//  RollingViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/3/18.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "RollingViewController.h"
#import "VVRollingNoticeView.h"
#import "RollingCell.h"

@interface RollingViewController () <VVRollingNoticeViewDelegate, VVRollingNoticeViewDataSource>

@property (nonatomic, strong) NSArray *array;

@end

@implementation RollingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.array = @[@"哈哈哈", @"啦啦啦啦", @"哒哒哒哒"];
    VVRollingNoticeView *vc = [[VVRollingNoticeView alloc] initWithFrame:CGRectMake(20, 100, 200, 60)];
    [vc registerClass:[RollingCell class] forCellReuseIdentifier:@"kkk"];
    vc.backgroundColor = [UIColor cyanColor];
    vc.stayInterval = 3.6;
    vc.animationDuration = 0.15;
    [self.view addSubview:vc];
    vc.delegate = self;
    vc.dataSource = self;
    [vc reloadDataAndStartRoll];
    // Do any additional setup after loading the view.
}

- (VVNoticeViewCell *)rollingNoticeView:(VVRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    RollingCell *cel = [rollingView dequeueReusableCellWithIdentifier:@"kkk"];
    NSString *title = self.array[index];
    cel.titleText = title;
    return cel;
}

- (NSInteger)numberOfRowsForRollingNoticeView:(VVRollingNoticeView *)rollingView
{
    return self.array.count;
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
