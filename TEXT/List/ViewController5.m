
//
//  ViewController5.m
//  TEXT
//
//  Created by 刘博 on 2020/9/25.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController5 () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, weak) NSObject *kk;


@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(130, 130);
    layout.footerReferenceSize = CGSizeMake(300, 20);
    layout.headerReferenceSize = CGSizeMake(300, 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 50, 0);
    UICollectionView *v = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, 300, 500) collectionViewLayout:layout];
    [v registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"kkk"];
    [v registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [v registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    v.delegate = self;
    v.dataSource = self;
    [self.view addSubview:v];
//    NSObject *KK = [[NSObject alloc] init];
//    
//    self.kk = KK;
//    
//    // 创建队列组
//    dispatch_group_t group = dispatch_group_create();
//    // 创建信号量，并且设置值为10
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0
//                                                               );
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    for (int i = 0; i < 100; i++)
//    {   // 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10此后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_group_async(group, queue, ^{
//            NSLog(@"哈哈哈哈哈哈%i",i);
//            sleep(2);
//            // 每次发送信号则semaphore会+1，
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
//    
//    
//    //    for (int i = 0; i < 100; i = i + 1) {
//    //        NSLog(@"大小大熊啊大小%d",i);
//    //    }
//    //    NSMutableArray *arr = [NSMutableArray array];
//    //    [arr addObjectsFromArray:nil];
//    //   __block int a = 0;
//    //
//    //         NSLog(@"a 哈哈哈哈--%p",&a);
//    //
//    //    void (^test)(void) = ^{
//    //
//    //         NSLog(@"a 乐乐乐--%p",&a);
//    //
//    //    };
//    //
//    //         NSLog(@"a 滴滴滴--%p",&a);
//    //
//    //    test();
//    //
//    ////    作者：sunxu_cocoa
//    ////    链接：https://www.jianshu.com/p/3270ee7cf0a9
//    ////    来源：简书
//    ////    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
//    //    // Do any additional setup after loading the view.
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kkk" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor redColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *f =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        f.backgroundColor = [UIColor cyanColor];
        UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        labe.text = @"区头区头";
        labe.textColor = [UIColor magentaColor];
        [f addSubview:labe];
        return f;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *f =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        f.backgroundColor = [UIColor greenColor];
        UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
        labe.text = @"区尾区尾区尾";
        labe.textColor = [UIColor magentaColor];

        [f addSubview:labe];
        return f;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
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
