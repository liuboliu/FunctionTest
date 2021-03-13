//
//  ViewControllerSegment.m
//  TEXT
//
//  Created by 刘博 on 2020/12/18.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerSegment.h"
#import "SPPageMenu.h"
#import "PageView.h"
#import "SubPageView.h"

@interface ViewControllerSegment () <PageViewDelegate , PageViewDatasource>

@property (nonatomic, strong) NSMutableArray <NSString *> *titleArray;

@end

@implementation ViewControllerSegment

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    PageViewConfiguration *configuration = [[PageViewConfiguration alloc] init];
    configuration.titleArray = @[@"1qwuioiweqrpoiqwer分类分类分类",@"2",@"3",@"4",@"5",@"6"];
    configuration.titleWidth = CGRectGetWidth(self.view.bounds) / 2.0;
    configuration.normalColor = [UIColor redColor];
    configuration.selectColor = [UIColor magentaColor];
    PageView *page = [[PageView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) config:configuration];
    [self.view addSubview:page];
    page.delegate = self;
    page.dataSource = self;
    [page reloadData];
//    UIScrollView *scroll = [[UIScrollView alloc] init];
//    [self.view addSubview:scroll];
//    scroll.frame = CGRectMake(0, 160, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
//    scroll.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 6, 400);
//
//    SPPageMenu *menu = [[SPPageMenu alloc] initWithFrame:CGRectMake(0, 120, CGRectGetWidth(self.view.frame), 40) ];
//    scroll.pagingEnabled = YES;
//    [menu setItems:@[@"fasdf",@"afsfasd",@"kkkki",@"88888",@"777777",@"99999"] selectedItemIndex:0];
//    menu.bridgeScrollView = scroll;
//    [self.view addSubview:menu];
//    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
}

#pragma mark  - PageViewDelegate -

- (void)pageView:(PageView *)page didScrollToIndex:(NSInteger)index
{
    
}

#pragma mark - PageViewDatasource

- (NSInteger)numberOfViewForPageview:(PageView *)pageView
{
    return self.titleArray.count;
}

- (UIView *)viewForPageView:(PageView *)pageView atIndex:(NSInteger)index
{
    SubPageView *subvie = [[SubPageView alloc] initWithFrame:CGRectZero];
    subvie.titleLabel.text = [NSString stringWithFormat:@"%ld",index];
    subvie.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];;
    return subvie;
}

#pragma lazyload
- (NSMutableArray<NSString *> *)titleArray
{
    if (!_titleArray) {
        _titleArray = [@[@"F",@"JJ",@"HFF", @"jjjj", @"iiii" , @"uuu"] mutableCopy];
    }
    return _titleArray;
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
