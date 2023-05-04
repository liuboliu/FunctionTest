//
//  SemaphoneViewController.m
//  TEXT
//
//  Created by liubo on 2023/5/4.
//  Copyright © 2023 刘博. All rights reserved.
//

#import "SemaphoneViewController.h"

@interface SemaphoneViewController ()

@end

@implementation SemaphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testSemaphone];
    });
    // Do any additional setup after loading the view.
}

- (void)testSemaphone
{
    dispatch_queue_t queue = dispatch_queue_create("com.dispatch.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
      dispatch_group_t group = dispatch_group_create();
      dispatch_async(queue, ^{
          NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
          NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
              // 请求完成，可以通知界面刷新界面等操作
              sleep(2);
              NSLog(@"第一步网络请求完成");
              // 使信号的信号量+1，这里的信号量本来为0，+1信号量为1(绿灯)
              dispatch_semaphore_signal(semaphore);
              
              
          }];
          [task resume];
          // 以下还要进行一些其他的耗时操作
         
          
      });
    NSLog(@"耗时操作继续进行");
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"这里是继续进行的操作这里是继续进行的操作");
    });
             
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
