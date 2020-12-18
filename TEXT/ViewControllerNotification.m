//
//  ViewControllerNotification.m
//  TEXT
//
//  Created by 刘博 on 2020/12/18.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerNotification.h"

@interface ViewControllerNotification ()

@end

@implementation ViewControllerNotification

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kkkk) name:@"ll" object:nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ll" object:nil];
    // Do any additional setup after loading the view.
}

- (void)kkkk
{
    NSLog(@"通知了通知了统统汉子了通天之类通知了通知了");
}

- (void)dealloc
{
    NSLog(@"页面释放了页面释放了");
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
