//
//  TableViewController.m
//  TEXT
//
//  Created by 刘博 on 2020/12/22.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "TableViewController.h"
#import "ViewControllerDecorationView.h"
#import "CollectionViewAutoLayoutController.h"
#import "ViewControllerLayoutSubViews.h"
#import "HeaderExpandViewController.h"
#import "HeaderExpandViewControllerTableView.h"
#import "HeaderExpandViewControllerSrollview.h"

#import "CardCourseViewController.h"
#import "WeakStrongController.h"
#import "MultiThreadViewController.h"
#import "TransitionViewController.h"
#import "KeyValueViewController.h"
#import "AnimationViewController.h"
#import "ScaleViewController.h"
#import "FadeViewController.h"

@interface TableViewController ()

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, strong) NSMutableArray *blockArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[
        @"装饰视图",
        @"collectionView自适应宽度",
        @"layoutsubviews",
        @"collectionView头部放大",
        @"tableView头部放大",
        @"scrollView头部放大",
        @"卡片式轮播和点击范围扩大",
        @"weak Strong",
        @"多线程优先级",
        @"转场动画",
        @"setvalueForkey",
        @"位移动画",
        @"放大动画"
    ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self configActions];
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor cyanColor];
//    
//    NSMutableArray *array = [NSMutableArray array];
//    void (^block) (void) = ^(){
//        [array addObject:@"asdf"];
//    };
//    block();
//    NSLog(@"数组数组%@",array);
     // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)configActions
{
    [self configDecoration];
    [self configAutoSize];
    [self configLayoutSubviews];
    [self configExpandHeader];
    [self configExpandHeaderTable];
    [self configExpandScrollView];
    [self configCardCourse];
    [self configBlock];
    [self configMultiThread];
    [self configTransition];
    [self setNilValueForKk];
    [self configAnimcation];
    [self cofigScaleanimation];
}

- (void)configDecoration
{
    void (^pushDecoration)(void) = ^(){
        ViewControllerDecorationView *vc = [[ViewControllerDecorationView alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:pushDecoration];
}

- (void)configAutoSize
{
    void (^autoSize) (void) = ^() {
        CollectionViewAutoLayoutController *vc = [[CollectionViewAutoLayoutController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:autoSize];
}

- (void)configLayoutSubviews
{
    void (^layoutSubViews) (void) = ^(){
        ViewControllerLayoutSubViews *vc = [[ViewControllerLayoutSubViews alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:layoutSubViews];
}

- (void)configExpandHeader
{
    void (^expand) (void) = ^(){
        HeaderExpandViewController *expand = [[HeaderExpandViewController alloc] init];
        [self.navigationController pushViewController:expand animated:YES];
    };
    [self.blockArray addObject:expand];
}

- (void)configExpandHeaderTable
{
    void (^expand) (void) = ^() {
        HeaderExpandViewControllerTableView *vc = [[HeaderExpandViewControllerTableView alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:expand];
}

- (void)configExpandScrollView
{
    void (^expand) (void) = ^() {
        HeaderExpandViewControllerSrollview *vc = [[HeaderExpandViewControllerSrollview alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:expand];
}

- (void)configCardCourse
{
    void (^cardCourse) (void) = ^ {
        CardCourseViewController *card = [[CardCourseViewController alloc] init];
        [self.navigationController pushViewController:card animated:YES];
    };
    [self.blockArray addObject:cardCourse];
}

- (void)configBlock
{
    void (^block) (void) = ^ {
        WeakStrongController *vc = [[WeakStrongController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:block];
}

- (void)configMultiThread
{
    void (^block) (void) = ^ {
        MultiThreadViewController *VC = [[MultiThreadViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    };
    [self.blockArray addObject:block];
}

- (void)configTransition
{
    void ( ^block ) (void) = ^void (void) {
        TransitionViewController *vc = [[TransitionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:block];
}

- (void)setNilValueForKk
{
    void (^block) (void) = ^void (void) {
        KeyValueViewController *vc = [[KeyValueViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:block];
}

- (void)configAnimcation
{
    void (^block) (void) = ^void (void) {
        AnimationViewController *vc = [[AnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:block];

}

- (void)cofigScaleanimation
{
    void (^block) (void) = ^ void (void) {
        ScaleViewController *vc = [[ScaleViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.blockArray addObject:block];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
   // NSLog(@"苏亮数量数量%ld",self.dataSource.count);
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSString *text = self.dataSource[indexPath.row];
        
    cell.textLabel.text = text;
    cell.textLabel.userInteractionEnabled = YES;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击");
    void (^block) (void) = self.blockArray[indexPath.row];
    if (block) {
        block();
    }
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

- (NSMutableArray *)blockArray
{
    if (!_blockArray) {
        _blockArray = [NSMutableArray array];
    }
    return _blockArray;
}

@end
