//
//  MultiThreadViewController.m
//  TEXT
//
//  Created by Apple on 2021/2/9.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "MultiThreadViewController.h"
#import "MyOperation.h"

@interface MultiThreadViewController ()

@end

@implementation MultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // [self gcdPriority];
    [self operationDepency];
   // [self operationPriority];
   //[self operationprioritytest];
    [self testSemophore];
    // Do any additional setup after loading the view.
}

- (void)gcdPriority
{
    //优先级变更的串行队列，初始是默认优先级
    dispatch_queue_t serialQueue = dispatch_queue_create("com.gcd.setTargetQueue.serialQueue", NULL);

    //优先级不变的串行队列（参照），初始是默认优先级
    dispatch_queue_t serialDefaultQueue = dispatch_queue_create("com.gcd.setTargetQueue.serialDefaultQueue", NULL);

//    //变更前
//    dispatch_async(serialQueue, ^{
//        NSLog(@"前前前1");
//    });
//    dispatch_async(serialDefaultQueue, ^{
//        NSLog(@"前前前2");
//    });

    //获取优先级为后台优先级的全局队列
    dispatch_queue_t globalDefaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    //变更优先级
    dispatch_set_target_queue(serialQueue, globalDefaultQueue);

    //变更后
    dispatch_async(serialQueue, ^{
        NSLog(@"吼吼吼1");
    });
    dispatch_async(serialDefaultQueue, ^{
        NSLog(@"哈哈哈哈哈222222");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"吼吼吼2");
    });
}

- (void)operationPriority
{
    NSOperationQueue  *queue=[[NSOperationQueue alloc] init];
      [queue setMaxConcurrentOperationCount:1];
      
    NSBlockOperation *o1= [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:4];
///
        NSLog(@"111111");
    }];
      o1.name=@"o1";
      [queue addOperation:o1];
      
    NSBlockOperation *o2= [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"222222");

        [NSThread sleepForTimeInterval:4];

        NSLog(@"222222");
    }] ;
      o2.name=@"o2";
      [queue addOperation:o2];
      
//      [NSThread sleepForTimeInterval:1];
      
      NSBlockOperation *o3= [NSBlockOperation blockOperationWithBlock:^{
          NSLog(@"33333333");

          [NSThread sleepForTimeInterval:4];

             NSLog(@"33333333");

      }];
        o3.name=@"o3";
//      [o3 setQueuePriority:NSOperationQueuePriorityHigh];
      [queue addOperation:o3];
    
    NSBlockOperation *o4= [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:4];

           NSLog(@"444444");

    }];
      o4.name=@"o4";
    [o4 setQueuePriority:NSOperationQueuePriorityHigh];
    [queue addOperation:o4];

}

- (void)operationprioritytest
{
  NSOperationQueue *queue=[[NSOperationQueue alloc] init];
     [queue setMaxConcurrentOperationCount:1];
     
     MyOperation *o1= [[MyOperation alloc] init];
     o1.name=@"o1";
     [queue addOperation:o1];
     
     MyOperation *o2= [[MyOperation alloc] init];
     o2.name=@"o2";
//    [o2 setQueuePriority:NSOperationQueuePriorityHigh];

     [queue addOperation:o2];
     
     ///[NSThread sleepForTimeInterval:1];
     
     MyOperation *o3= [[MyOperation alloc] init];
     o3.name=@"o3";
//     [o3 setQueuePriority:NSOperationQueuePriorityHigh];
     [queue addOperation:o3];
    
     MyOperation *o4 = [[MyOperation alloc] init];
         o4.name=@"o4";
         [o4 setQueuePriority:NSOperationQueuePriorityHigh];
         [queue addOperation:o4];
}

- (void)operationDepency
{
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
        [queue setMaxConcurrentOperationCount:1];
        
        MyOperation *o1= [[MyOperation alloc] init];
        o1.name=@"o1";
        [queue addOperation:o1];
        
        MyOperation *o2= [[MyOperation alloc] init];
        o2.name=@"o2";
    [o1 addDependency:o2];
         MyOperation *o3= [[MyOperation alloc] init];
         o3.name=@"o3";
    //     [o3 setQueuePriority:NSOperationQueuePriorityHigh];
         [queue addOperation:o3];
    [o2 addDependency:o3];
         MyOperation *o4 = [[MyOperation alloc] init];
             o4.name=@"o4";
//             [o4 setQueuePriority:NSOperationQueuePriorityHigh];
    [o3 addDependency:o4];
             [queue addOperation:o4];
    [queue addOperation:o2];
}

- (void)testSemophore
{
    dispatch_semaphore_t semaphore= dispatch_semaphore_create(0); // 创建信号量
   [self getuserId:semaphore];//获取用户useid
   dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);//当前信号量为0，一直等待阻塞线程
       [self requestwithuserid:@"hahha "];
}

- (void)getuserId:(dispatch_semaphore_t)semaphore{

    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"开始请求");
        sleep(3);
        dispatch_semaphore_signal(semaphore);
        NSLog(@"模拟请求成功");
    });

}

- (void)requestwithuserid:(NSString *)userid{
   NSDictionary *parms=[NSMutableDictionary dictionary];
    NSLog(@"使用userid请求数据啊啦啦啦");
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
