//
//  CollectionViewAutoLayoutController.m
//  TEXT
//
//  Created by 刘博 on 2020/12/25.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "CollectionViewAutoLayoutController.h"
#import "SIZECollectionViewCell.h"

@interface CollectionViewAutoLayoutController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSArray <NSString *> *dataSource;

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation CollectionViewAutoLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(10, 200);
     //   layout.estimatedItemSize = CGSizeZero;

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 50) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor greenColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[SIZECollectionViewCell class] forCellWithReuseIdentifier:@"size"];
    self.collectionView = collectionView;
    self.dataSource = @[@"hah", @"啦啦花", @"没有没有", @"斤斤计较军发送的", @"meiyou没有美欧没有灭有没有没有没有",@"啦",@"啦",@"啦",@"啦",@"234i12u34iu12p3io4u12p3oi4u12p3oi4u1p23oiu4",@"啦啦花",@"啦啦花",@"啦啦花",@"啦啦花",@"啦啦花",@"啦啦花",@"啦啦花",@"啦啦花",@"fsjakf",@"uuuuuu",@"oooooo",@"iuuuuuu",@"最后一个最后一个"];
    [self.view addSubview:collectionView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataSource.count - 1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionRight];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SIZECollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"size" forIndexPath:indexPath];
    cell.title.text = self.dataSource[indexPath.item];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
