//
//  ViewController6.m
//  TEXT
//
//  Created by 刘博 on 2020/7/24.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewController6.h"
#import <Masonry.h>
#import "VVCell.h"

@interface ViewController6 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (atomic, assign) NSInteger slice;

@property (nonatomic, strong) NSLock *lock;

@end

@implementation ViewController6

//@synthesize name;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    NSMutableArray *array = [@[@"1", @"2" ,@"3" , @"4", @"5"] mutableCopy];
//    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isEqualToString:@"3"]) {
//            [array replaceObjectAtIndex:idx withObject:@"4"];
//        }
//    }];
//
//
//    for (NSString *string in array) {
//        if ([string isEqualToString:@"3"]) {
//            NSInteger index = [array indexOfObject:string];
//            [array replaceObjectAtIndex:index withObject:@"4"];
//        }
//    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    [self.tableView reloadData];
    NSLog(@"之前的之前的之前的之前的之前的数量数量数量数数量数量数量%ld",self.tableView.visibleCells.count);
    [self.tableView layoutIfNeeded];
   /// dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"之后之后之后可以看得见额可以看得见得%ld",self.tableView.visibleCells.count);

   // });
//    self.lock = [[NSLock alloc] init];
//    self.slice = 0;
//    dispatch_queue_t queue = dispatch_queue_create("TestQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        for (int i=0; i<10000; i++) {
//            //[self.lock lock];
//            self.slice = self.slice + 1;
//            //[self.lock unlock];
//        }
//    });
//    dispatch_async(queue, ^{
//        for (int i=0; i<10000; i++) {
//           // [self.lock lock];
//            self.slice = self.slice + 1;
//           // [self.lock unlock];
//        }
//    });
////
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"最终最终追踪最终最终%ld",self.slice);
//    });
//
//    NSLog(@"名字名字明在%s", [NSStringFromSelector(@selector(viewDidLoad)) UTF8String]);
    // Do any additional setup after loading the view.
    //[self hh];
}

- (void)hh
{
    [self hh];
    NSLog(@"打印打印打印");
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VVCell class])];
    NSLog(@"哈哈哈哈下一个下一个%@", cell.nextResponder);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor greenColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[VVCell class] forCellReuseIdentifier:NSStringFromClass([VVCell class])];
    }
    return _tableView;;
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
