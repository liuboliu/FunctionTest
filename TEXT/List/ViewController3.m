//
//  ViewController3.m
//  TEXT
//
//  Created by 刘博 on 2020/5/23.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewController3.h"
#import "ViewController.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *first = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:first];
    first.frame = CGRectMake(10, 100, 100, 100);
    first.backgroundColor = [UIColor redColor];
    [first addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *second = [UIButton buttonWithType:UIButtonTypeCustom];
    second.frame = CGRectMake(150, 100, 100, 100);
    second.backgroundColor = [UIColor cyanColor];
    [second addTarget:self action:@selector(cancel ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:second];
    // Do any additional setup after loading the view.
}

- (void)play
{
    UIViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0];
//    [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"输出");
//    }];
}

- (void)cancel
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayMethod) object:nil];
}

- (void)delayMethod
{
    
    NSLog(@"延迟操作延迟操作");
    [self performSelector:@selector(delay222) withObject:nil afterDelay:2];
}

- (void)delay222
{
    NSLog(@"延迟操作e2 延迟操作3");
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
