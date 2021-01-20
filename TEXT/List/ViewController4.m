//
//  ViewController4.m
//  TEXT
//
//  Created by 刘博 on 2020/7/19.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewController4.h"
#import "ViewController.h"
#import "ViewController6.h"
#import "VVCell.h"

@protocol vewDelegate <NSObject>

- (void)ss;

@end

@protocol letate <NSObject,vewDelegate>


@end

@interface ViewController4 () <letate,UIScrollViewDelegate>

@property (nonatomic) dispatch_queue_t queue;

@property (nonatomic) dispatch_semaphore_t semaphore;

@property (nonatomic, copy) NSString *contentStr;


@end

@implementation ViewController4

//@synthesize name = _name;

@dynamic name;

- (void)viewDidLoad {
    [super viewDidLoad];
    VVCell *cell;
    {
        cell = [[VVCell alloc] init];
    }
    NSMutableArray *array = [NSMutableArray array];
    NSArray *arr = nil;
    [array addObjectsFromArray:arr];
//    //VVCell *cell2 = [cell mutableCopy];
//    NSMutableArray *array = [NSMutableArray array];
//    NSMutableArray *arra62 = [array copy];
//    [arra62 addObject:@"1"];
//    self.view.backgroundColor = [UIColor greenColor];
//    NSMethodSignature *signature = [ViewController4 instanceMethodSignatureForSelector:@selector(sendMessageWithNumber:WithContent:)];
//    // NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.target = self;
//    //invocation中的方法必须和签名中的方法一致。
//    invocation.selector = @selector(sendMessageWithNumber:WithContent:);
    /*第一个参数：需要给指定方法传递的值
           第一个参数需要接收一个指针，也就是传递值的时候需要传递地址*/
    //第二个参数：需要给指定方法的第几个参数传值
//    NSString *number = @"1111";
//    //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
//    [invocation setArgument:&number atIndex:2];
//    NSString *number2 = @"啊啊啊";
//    [invocation setArgument:&number2 atIndex:3];
//    //2、调用NSInvocation对象的invoke方法
//    //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
//    [invocation invoke];

//    self.view.backgroundColor = [UIColor greenColor];
//    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 300, 400)];
//    scrollview.contentInset = UIEdgeInsetsMake(600, 0, 50, 0);
//    scrollview.contentSize = CGSizeMake(300, 200);
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, - 600, 300, 600)];
//    view1.backgroundColor = [UIColor yellowColor];
//    [scrollview addSubview:view1];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, 300,100)];
//    view.backgroundColor = [UIColor blueColor];
//    [scrollview addSubview:view];
//    [self.view addSubview:scrollview];
//    scrollview.delegate = self;
//    scrollview.backgroundColor = [UIColor redColor];

//
//    NSString *title;
//       for (int i = 0; i < 10; i ++) {
////           NSString *title;
//           @autoreleasepool {
//               title  = [NSString stringWithFormat:@"ffff"];
//           }
//           NSLog(@"内容内容内容%@",title);
//       }
//       NSLog(@"标题标标题标题%@",title);
//    NSArray *arr = @[@"ff"];
//    NSArray *arrat = arr.copy;
//    NSLog(@"地址地址地址%p %p %@ %@",arr,arrat, arr, arrat);
    // self.name = @"zlie";
//    NSDictionary *dic = @{@"zheli":@"ff"};
//    NSString *s = [dic valueForKey:@"@ff"];
//    ViewController6 *vc = [[ViewController6 alloc] init];
//   // vc.name = @"f";
//    [vc setValue:@"hahahah" forKey:@"name"];
// NSLog(@"名字名字名子明子明%@",vc.name);
//NSString *nanme = [vc objectForKey:@"name"];
// NSString *name2 = [vc valueForKey:@"name"];
//    self.view.backgroundColor = [UIColor cyanColor];
////    [self sss];
////    [self ssss];
//    __block NSInteger kk = 0;
//    for (int i = 0; i < 100; i ++) {
//        kk ++;
//    }
//    NSLog(@"这里的值这里的值%ld",kk);
//    NSArray *arr = @[@"1",@"2",@"3", @"4",@"5",@"6"];
//    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////        NSLog(@"前面钱苗苗钱脉%@",obj);
//        if ([obj isEqual:@"5"]) {
//            *stop = YES;
//        }
//        kk --;
////        NSLog(@"后米恩后面%@",obj);
//    }];
//    NSLog(@"那里的值那里的值%ld",kk);

//    self.semaphore = dispatch_semaphore_create(1);
//
//    self.queue = dispatch_queue_create("LaunchConfigQueue", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(self.queue, ^{
//    });
//   // NSLog(@"这里这里这里这里");
//    dispatch_sync(self.queue, ^{
//        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
//
//        NSLog(@"走走走走走走走走走进来进来进来谨");
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            sleep(3);
//            NSLog(@"第一个内容太内容第一个内容");
//            dispatch_semaphore_signal(self.semaphore);
//        });
//        NSLog(@"一个一个一个尾部尾部尾部");
//    });
//
//    dispatch_sync(self.queue, ^{
//        NSLog(@"第二个每人各个");
//        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER); dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            sleep(2);
//            NSLog(@"第二个内容第二个内容第二个内容个");
//            dispatch_semaphore_signal(self.semaphore);
//        });
//        NSLog(@"二个二个尾部尾部尾部");
//    });
//    dispatch_sync(self.queue, ^{
//        NSLog(@"出来出来出来");
//    });
//    dispatch_async(self.queue, ^{
//        dispatch_semaphore_signal(self.semaphore);
//
//    });
    // Do any additional setup after loading the view.
//    NSMutableSet *set1 = [[NSMutableSet alloc] initWithObjects:@"1",@"2",@"3", nil];
//      NSMutableSet *set2 = [[NSMutableSet alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
//    BOOL isSubSet = [set1 isSubsetOfSet:set2];
//    if (self.contentStr) {
//        NSLog(@"走到这里走到这里走到这里走到这里");
//    }
    // [set1 unionSet:set2];   //取并集1，2，3，5，6
//       [set1 intersectSet:set2];  //取交集1
//    NSLog(@"%@",set1);
    
//    NSError * __autoreleasing error = nil;
//    [self autoreleasingTestForError:&error];
//    //NSLog(@"地址地址地址%p",error);
//    void (^block)();
//    if (1) {
//        block = ^{
//
//        };
//    } else {
//        block = ^{
//
//        };
//    }
//    block();
}

- (void)sendMessageWithNumber:(NSString*)number WithContent:(NSString*)content
{
       //NSLog(@"电话号%@,内容%@",number,content);
}

- (void)autoreleasingTestForError:(NSError * __autoreleasing *)errorPtr {
    NSError * errorObj = [[NSError alloc]init];
    // 给外部传入的error变量赋值
    *errorPtr = errorObj;
    //NSLog(@"内部地址内部值内部地址%p",errorObj);
    // @note:
    // 如果errorObj不是__autoreleasing修饰的，那么编译器会做一些修改
    // NSError * errorObj = [[NSError alloc]init];
    // NSError * __autoreleasing tmp = errorObj;
    // *errorPtr = tmp;
}

- (void)sss
{
    if (1) {
        NSLog(@"这里这里这里这里这里");
        NSLog(@"哈哈哈哈哈哈");
    }
    NSLog(@"那里那里那里那里那里");
}

- (void)ssss
{
    NSLog(@"外ma外面外面外面");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"pain偏移量便宜连%f",scrollView.contentOffset.y);
}

- (void)ss
{
}


@end
