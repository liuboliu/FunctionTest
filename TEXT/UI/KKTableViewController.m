//
//  KKTableViewController.m
//  TEXT
//
//  Created by 朱家乐 on 2021/4/7.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "KKTableViewController.h"
#import "ListModel.h"
#import "GradientViewController.h"
#import "ImageColorViewController.h"
#import "VVVVV.h"
#import <Masonry/Masonry.h>
#import "TPImageTitleView.h"
#import <JLRoutes/JLRoutes.h>

typedef void (^block) (void);
@interface KKTableViewController ()


@property (nonatomic, strong) NSMutableArray *blockArray;

@end

@implementation KKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ss"];
    self.blockArray = [NSMutableArray array];
    [self configDatasource];
    [self.tableView reloadData];
    NSDictionary *dic = @{@"kkk": @{@"jjjj":@"lllllalal"}};
    NSString *kkk = [dic valueForKeyPath:@"kkk.jjjj"];
    NSDictionary *dict1 = @{@"dic1":@{@"dic2":@{@"name":@"lisi",@"info":@{@"age":@"12"}}}};

    NSString *res = [dict1 valueForKeyPath:@".dict1.dict2.name"];
    NSMutableArray *kk = [@[@"fff", @"llll"] mutableCopy];
    [kk removeObject:@"aaa"];

    NSDictionary *kkkkk = @"kkkk";
    
    TPImageTitleView *label = [[TPImageTitleView alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    label.backgroundColor = [UIColor redColor];
    [label showTitle:@"u去哦我i饿入侵颇为如脾气哦i未如期颇为入伍前"];
    //NSString *lll = [kkkkk objectForKey:@"lll"];
    NSLog(@"hahahah888888");
  //  NSString *啦啦啦 = kkkkk[@"lll"];
//    NSString *string = [NSString stringWithFormat:@"%@%@","kk",[NSNull null]];
//    NSDictionary *ccc = @{@"kkk":string};
//    VVVVV *v  = [[VVVVV alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    v.tag
//    = 1000;
//    v.backgroundColor = [UIColor greenColor];
////    [self.view addSubview:v];
//    UIWindow *wond = [UIApplication sharedApplication].keyWindow;
//    [wond addSubview:v];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UIView *v = [self.view viewWithTag:1000];
//    [v removeFromSuperview];
//}

- (void)configDatasource
{
    [self configGraident];
    [self configImgColor];
    [self configLinkPush];
    [self configlinkCardPush];
    [self configLinkThirdPush];
}
 
- (void)configGraident
{
    void (^pushDecoration)(void) = ^(){
        GradientViewController *vc = [[GradientViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self modelWithTitle:@"渐变" block:pushDecoration];

}

- (void)configImgColor
{
    void (^pushImgColor) (void) = ^() {
        ImageColorViewController *img = [[ImageColorViewController alloc] init];
        [self.navigationController pushViewController:img animated:YES];
    };
    [self modelWithTitle:@"颜色生成图片" block:pushImgColor];
}

- (void)configLinkPush
{
    void (^link ) (void) = ^() {
        NSURL *url = [NSURL URLWithString:@"liubolink://FadeViewController"];
        [JLRoutes routeURL:url withParameters:nil];
    };
    [self modelWithTitle:@"跳转第一个页面" block:link];
}

- (void)configlinkCardPush
{
    void (^link ) (void) = ^() {
        void (^completionBlock) (void) = ^ (void) {
            NSLog(@"回调回调回调回调");
        };
        NSURL *url = [NSURL URLWithString:@"liubolink://CardCourseViewController"];
        NSDictionary *parameter = @{@"completionBlock":completionBlock};
        [JLRoutes routeURL:url withParameters:parameter];
    };
    [self modelWithTitle:@"跳转到第二个页面" block:link];
}

- (void)configLinkThirdPush
{
    void (^link ) (void) = ^() {
        NSURL *url = [NSURL URLWithString:@"liubolink://liubo"];
        [JLRoutes routeURL:url withParameters:nil];
    };
    [self modelWithTitle:@"跳转到第三个页面" block:link];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    ListModel *model = self.blockArray[indexPath.row];
    block block = model.block;
    if (block) {
        block();
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    ListModel *model = self.blockArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.userInteractionEnabled = YES;
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.blockArray.count;
}

#pragma mark - util
- (ListModel *)modelWithTitle:(NSString *)title block:(void (^)(void))block
{
    ListModel *model = [[ListModel alloc] init];
    model.title = title;
    model.block = block;
    [self.blockArray addObject:model];
    return model;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
