//
//  HeaderExpandViewController.m
//  TEXT
//
//  Created by 刘博 on 2021/1/19.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "HeaderExpandViewControllerSrollview.h"
#import "VVCustomCollectionViewLayout.h"
#import "VVScrollHelper.h"
#import <Masonry/Masonry.h>
#import "VVUIMacros.h"

@interface HeaderExpandViewControllerSrollview () <UICollectionViewDelegate, UICollectionViewDataSource,VVCustomCollectionViewLayoutDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *header_backgroundView;

@property (nonatomic, strong) UIView *header_frontView;

@property (nonatomic, strong) VVScrollHelper *scrollHelper;

@property (nonatomic, strong) UIView *topContentView;

@property (nonatomic, strong) UIButton *topButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation HeaderExpandViewControllerSrollview

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    //self.collectionView = nil;

    [self.header_frontView addSubview:self.topContentView];
    [self.topContentView addSubview:self.topButton];
    [self.topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);;
        make.top.mas_equalTo(60);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    self.view.backgroundColor = [UIColor magentaColor];
    VVScrollExtraViewConfig *headerViewConfig = [VVScrollExtraViewConfig new];
    headerViewConfig.frontView = self.header_frontView;
    headerViewConfig.backgroundView = self.header_backgroundView;
    headerViewConfig.headerStyle = VVHeaderBackStyleFixed;
    [VVScrollHelper initWithScrollView:self.scrollView
                      headerViewConfig:headerViewConfig
                      headerOverHeight:0];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.collectionView reloadData];

    // Do any additional setup after loading the view.
}

#pragma mark - action
- (void)click
{
    NSLog(@"嘎嘎嘎嘎点击了点击了");
}

#pragma mark - lazy load


- (UIView *)header_backgroundView
{
    if (!_header_backgroundView) {
        _header_backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, - (SCREEN_W * 54/75), SCREEN_W, SCREEN_W * 54/75)];
        _header_backgroundView.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"me_background_expanding"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_header_backgroundView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.inset(0);
        }];
    }
    return _header_backgroundView;
}

- (UIView *)topContentView
{
    if (!_topContentView) {
        _topContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W * 54/75)];
        _topContentView.backgroundColor = [UIColor clearColor];
    }
    return _topContentView;
}

- (UIButton *)topButton
{
    if (!_topButton) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topButton setTitle:@"标题fu" forState:UIControlStateNormal];
        [_topButton setBackgroundColor:[UIColor greenColor]];
        [_topButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}

- (UIView *)header_frontView
{
    if (!_header_frontView) {
        _header_frontView = [[UIView alloc] initWithFrame:CGRectMake(0, - SCREEN_W * 54/75, SCREEN_W, SCREEN_W * 54/75)];
        _header_frontView.backgroundColor = [UIColor clearColor];
    }
    return _header_frontView;
}
    
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
//        VVCustomCollectionViewLayout *layout = [[VVCustomCollectionViewLayout alloc] init];
//        layout.delegate = self;
//
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_W, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delaysContentTouches = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _collectionView;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor magentaColor];
        _scrollView.contentSize = CGSizeMake(0, 1000);
    }
    return _scrollView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 100)];
        _contentView.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor greenColor];
        [_contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    return _contentView;
}

#pragma mark - delegate

// 每个区多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout *)collectionViewLayout columnNumberAtSection:(NSInteger )section
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor cyanColor];
    [cell.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0,15,0,15));
    }];
    return cell;
}

// cell height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(VVCustomCollectionViewLayout *)collectionViewLayout heightForRowAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)overlapHeightAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

#pragma mark - talbeviewDelegte tableDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor cyanColor];
    [cell.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView bringSubviewToFront:cell];
}



//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self.scrollHelper scrollViewDidSroll:scrollView superViewInsetHeight:-18];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
