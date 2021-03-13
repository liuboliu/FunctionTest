//
//  PageView.m
//  TEXT
//
//  Created by Apple on 2021/3/13.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "PageView.h"
#import "SPPageMenu.h"

@implementation PageViewConfiguration

@end

@interface PageView ()<UIScrollViewDelegate,SPPageMenuDelegate>

///承载子视图的主scrollView
@property (nonatomic, strong) UIScrollView *scrollView;

///分页控制view
@property (nonatomic, strong) SPPageMenu *segmentMenu;

///下标索引和视图对象 组成的字典
@property (nonatomic, strong) NSMutableDictionary *pageDic;

///配置实例
@property (nonatomic, strong) PageViewConfiguration *configuration;

@end

@implementation PageView

- (instancetype)initWithFrame:(CGRect)frame config:(PageViewConfiguration *)config
{
    if (self = [super initWithFrame:frame]) {
        self.pageDic = [NSMutableDictionary dictionary];
        self.configuration = config;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    SPPageMenu *segmentMenu = [[SPPageMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    [segmentMenu setItems:self.configuration.titleArray selectedItemIndex:0];
    self.segmentMenu = segmentMenu;
    self.segmentMenu.delegate = self;
    [self addSubview:segmentMenu];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 40)];
    [self addSubview:self.scrollView];
    self.segmentMenu.bridgeScrollView = self.scrollView;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self configSubViews];
    [self showViewAtIndex:self.configuration.detaultIndex];
}

- (void)configSubViews
{
    NSInteger numberOfSubpage = 0;
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(numberOfViewForPageview:)]) {
        numberOfSubpage = [self.dataSource numberOfViewForPageview:self];
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * numberOfSubpage, CGRectGetHeight(self.scrollView.bounds) - 40);
    
}

#pragma mark - public

- (void)reloadData
{
    [self configSubViews];
    [self showViewAtIndex:self.configuration.detaultIndex];
}

- (void)scrollToIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds) * index, 0)];
    [self showViewAtIndex:index];
}

#pragma mark - private
- (void)showViewAtIndex:(NSInteger)index
{
    NSString *key = [NSString stringWithFormat:@"%ld",index];
    UIView *view = [self.pageDic objectForKey:key];
    if (!view &&
        self.dataSource &&
        [self.dataSource respondsToSelector:@selector(viewForPageView:atIndex:)]) {
        view = [self.dataSource viewForPageView:self atIndex:index];
        view.frame = CGRectMake(CGRectGetWidth(self.scrollView.bounds) * index, 40, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds) - 40);
        [self.scrollView addSubview:view];
        self.pageDic[key] = view;
    }
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds) * index, 0)];
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index
{
    [self showViewAtIndex:index];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(pageView:didScrollToIndex:)]) {
        NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
        [self.delegate pageView:self didScrollToIndex:index];
        [self showViewAtIndex:index];
    }
}

@end
