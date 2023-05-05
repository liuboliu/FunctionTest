//
//  ThreadSafeController.m
//  TEXT
//
//  Created by liubo on 2023/5/5.
//  Copyright © 2023 刘博. All rights reserved.
//

#import "ThreadSafeController.h"

@interface ThreadSafeController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ThreadSafeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testThreadSafe];
    // Do any additional setup after loading the view.
}

- (void)testThreadSafe
{
    self.dataArray = @[@"1", @"2", @"3", @"4", @"5"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0 ; i < 100; i ++) {
            self.dataArray = @[@"1", @"2"];
        }
        NSLog(@"%@",self.dataArray);
    });
    
    for (int i = 0; i < 10; i ++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"%@", self.dataArray);
        });
    }
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
