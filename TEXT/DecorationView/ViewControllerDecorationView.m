//
//  ViewControllerDecorationView.m
//  TEXT
//
//  Created by 刘博 on 2020/12/22.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerDecorationView.h"
#import "VVCollectionDecorationLayout.h"
#import "VVCategoryDecorationView.h"
#import "VVCategoryBannerDecorationView.h"
#import <Masonry/Masonry.h>

#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface ViewControllerDecorationView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,
VVCollectionDecorationLayoutDelegte>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewControllerDecorationView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    // Do any additional setup after loading the view.
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] init];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark  - VVCollectionDecorationLayoutDelegte
- (Class)decorationViewClassOfSection:(NSInteger)section
{
    if (section % 2 ) {
        return VVCategoryDecorationView.class;
    }
    return VVCategoryBannerDecorationView.class;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
        VVCollectionDecorationLayout *layout = [VVCollectionDecorationLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.adjustHeaderAndFooterLayout = YES;
        layout.decorationContainsHeader = YES;
        layout.vvDelegate = self;
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake((SCREEN_W - 20 - 1)/2, 100);
        [layout registerClass:[VVCategoryDecorationView class] forDecorationViewOfKind:[VVCategoryDecorationView kind]];
        [layout registerClass:[VVCategoryBannerDecorationView class] forDecorationViewOfKind:[VVCategoryBannerDecorationView kind]];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];

        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.frame = CGRectMake(0, 100, 300, 400);
    }
    return _collectionView;
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
