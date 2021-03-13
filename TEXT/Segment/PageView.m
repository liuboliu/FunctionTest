//
//  PageView.m
//  TEXT
//
//  Created by Apple on 2021/3/13.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "PageView.h"
#import "SPPageMenu.h"
#import "UIColor+TDHelp.h"

@implementation PageViewConfiguration

- (instancetype)init
{
    if (self = [super init]) {
        self.segmentHeight = 40;
        self.normalColor = [UIColor colorWithHex:0x999999];
        self.selectColor = [UIColor colorWithHex:0x333333];
        self.font = 16;
    }
    return self;
}

@end

@interface PageView ()<UIScrollViewDelegate,SPPageMenuDelegate>

{
    CGFloat segmentHeight;
}

///承载子视图的主scrollView
@property (nonatomic, strong) UIScrollView *scrollView;

///分页控制view
@property (nonatomic, strong) SPPageMenu *segmentMenu;

///下标索引和视图对象 组成的字典
@property (nonatomic, strong) NSMutableDictionary *pageDic;

///配置实例
@property (nonatomic, strong) PageViewConfiguration *configuration;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation PageView

- (instancetype)initWithFrame:(CGRect)frame config:(PageViewConfiguration *)config
{
    if (self = [super initWithFrame:frame]) {
        self.pageDic = [NSMutableDictionary dictionary];
        self.configuration = config;
        segmentHeight = config.segmentHeight;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    SPPageMenu *segmentMenu = [[SPPageMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40) config:self.configuration];
    [segmentMenu setItems:self.configuration.titleArray selectedItemIndex:0];
    self.segmentMenu = segmentMenu;
    self.segmentMenu.delegate = self;
    [self addSubview:segmentMenu];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, segmentHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - segmentHeight)];
    [self addSubview:self.scrollView];
    self.segmentMenu.bridgeScrollView = self.scrollView;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self showViewAtIndex:self.configuration.detaultIndex];
}

- (void)configSubViews
{
    NSInteger numberOfSubpage = 0;
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(numberOfViewForPageview:)]) {
        numberOfSubpage = [self.dataSource numberOfViewForPageview:self];
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * numberOfSubpage, CGRectGetHeight(self.scrollView.bounds) - segmentHeight);
    
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
        view.frame = CGRectMake(CGRectGetWidth(self.scrollView.bounds) * index,0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds) - segmentHeight);
        [self.scrollView addSubview:view];
        self.pageDic[key] = view;
    }
    self.currentIndex = index;
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
        if (index == self.currentIndex) {
            return;
        }
        [self.delegate pageView:self didScrollToIndex:index];
        [self showViewAtIndex:index];
        self.currentIndex = index;
    }
}

@end
