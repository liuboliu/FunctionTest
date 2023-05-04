//
//  TPLockController.m
//  TEXT
//
//  Created by liubo on 2023/4/28.
//  Copyright © 2023 刘博. All rights reserved.
//

#import "TPLockController.h"

@interface TPLockController ()

@property (nonatomic,strong) NSArray *tickets;
@property (nonatomic,assign) int soldCount;
@property (nonatomic,strong) NSLock *lock;

@end

@implementation TPLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self forTest];
//        [self testLock];
    });
    // Do any additional setup after loading the view.
}

- (void)forTest
{
    self.tickets = @[@"南京-北京A101",@"南京-北京A102",@"南京-北京A103",@"南京-北京A104",@"南京-北京A105",@"南京-北京A106",@"南京-北京A107",@"南京-北京A108",@"南京-北京A109",@"南京-北京A110",@"南京-北京A111",@"南京-北京A112",@"南京-北京A113",@"南京-北京A114",@"南京-北京A115",@"南京-北京A116",@"南京-北京A117",@"南京-北京A118",@"南京-北京A119",@"南京-北京A120",@"南京-北京A121",@"南京-北京A122",@"南京-北京A123",@"南京-北京A124",@"南京-北京A125",@"南京-北京A126",@"南京-北京A127",@"南京-北京A128",@"南京-北京A129",@"南京-北京A130"];
    //初始化NSLock
    self.lock = [[NSLock alloc] init];
    //第一窗口
    NSThread *windowOne = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    windowOne.name = @"一号窗口";
    [windowOne start];
    //第二窗口
    NSThread *windowTwo = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    windowTwo.name = @"二号窗口";
    [windowTwo start];
    //第三窗口
    NSThread *windowThree = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    windowThree.name = @"三号窗口";
    [windowThree start];
    //第四窗口
    NSThread *windowFour = [[NSThread alloc] initWithTarget:self selector:@selector(soldTicket) object:nil];
    windowFour.name = @"四号窗口";
    [windowFour start];
}
-(void)soldTicket
{
    //加锁
    [self.lock lock];

    if (self.soldCount == self.tickets.count) {
        NSLog(@"=====%@ 剩余票数：%lu",[[NSThread currentThread] name],self.tickets.count-self.soldCount);
        //解锁
        [self.lock unlock];
        return;
    }
    //延时卖票
    [NSThread sleepForTimeInterval:0.2];
    self.soldCount++;
    NSLog(@"=====%@ %@ 剩%lu",[[NSThread currentThread] name],self.tickets[self.soldCount-1],self.tickets.count-self.soldCount);
    //解锁
    [self.lock unlock];

    //一直卖票
    [self soldTicket];
}

- (void)testLock

{
    //主线程中
        NSLock *lock = [[NSLock alloc] init];
    dispatch_queue_t queue = dispatch_queue_create("jfjfjj", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t globak = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t main = dispatch_get_main_queue();
        //线程1
        dispatch_async(main, ^{
            [lock lock];
            NSLog(@"线程1");
            sleep(10);
            [lock unlock];
            NSLog(@"线程1解锁成功");
        });

        //线程2
        dispatch_async(main, ^{
            sleep(1);//以保证让线程2的代码后执行
            [lock lock];
            NSLog(@"线程2");
            [lock unlock];
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
