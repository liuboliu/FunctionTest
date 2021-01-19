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

@interface TableViewController ()

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, strong) NSMutableArray *blockArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"装饰视图",@"collectionView自适应宽度",@"layoutsubviews", @"头部放大"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self configActions];
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor cyanColor];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)configActions
{
    [self configDecoration];
    [self configAutoSize];
    [self configLayoutSubviews];
    [self configExpandHeader];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSString *text = self.dataSource[indexPath.row];
        
    cell.textLabel.text = text;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
