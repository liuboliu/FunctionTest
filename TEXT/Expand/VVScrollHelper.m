//
//  JKScrollHelper.m
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import "VVScrollHelper.h"
#import <Aspects/Aspects.h>
#import "NSObject+VVKVOHelper.h"
#import <objc/runtime.h>

@implementation VVScrollExtraViewConfig

@end

@interface VVScrollHelper()

///滚动视图
@property (nonatomic, weak) UIScrollView *scrollView;
///顶部inset
@property (nonatomic, assign) CGFloat contentInsetTop;
///底部inset
@property (nonatomic, assign) CGFloat contentInsetBottom;
///配置实例
@property (nonatomic, strong) VVScrollExtraViewConfig *extraHeaderViewConfig;

@end

@implementation VVScrollHelper

+ (VVScrollHelper *)initWithScrollView:(UIScrollView *)scrollView
                      headerViewConfig:(VVScrollExtraViewConfig *)headerConfig
                      headerOverHeight:(CGFloat)headerOverHeight
{
    VVScrollHelper *scrollViewHelper = [[self alloc] init];
    if(scrollViewHelper){
        headerConfig.frontView.clipsToBounds = YES;
        headerConfig.backgroundView.clipsToBounds = YES;
        scrollViewHelper.extraHeaderViewConfig = headerConfig;
        
        CGRect frame = headerConfig.frontView.frame;
        CGPoint origin = frame.origin;
        ///y原点 = 背景视图的原高度 - inset高度
        origin.y = - (CGRectGetHeight(frame) - headerOverHeight);
        frame.origin = origin;
        headerConfig.frontView.frame = frame;
        headerConfig.backgroundView.frame = frame;
        scrollViewHelper.scrollView = scrollView;
        
        scrollViewHelper.contentInsetTop = CGRectGetHeight(frame) - headerOverHeight;
        scrollViewHelper.contentInsetBottom = 0;
        scrollView.contentInset = UIEdgeInsetsMake(scrollViewHelper.contentInsetTop, 0, scrollViewHelper.contentInsetBottom, 0);
        [scrollView setContentOffset:CGPointMake(0, -scrollViewHelper.contentInsetTop) animated:NO];
        scrollView.bouncesZoom = NO;
        [scrollView addSubview:headerConfig.backgroundView];
        [scrollView addSubview:headerConfig.frontView];
        
        ///添加滚动监听
        [self handleScrollView:scrollView
                  headerConfig:headerConfig
              scrollViewHelper:scrollViewHelper
                   insetHeight:headerOverHeight];

    }
    return scrollViewHelper;
}

+ (void)handleScrollView:(UIScrollView *)scrollView
            headerConfig:(VVScrollExtraViewConfig *)headerConfig
        scrollViewHelper:(VVScrollHelper *)scrollViewHelper
             insetHeight:(CGFloat)insetsHeight
{
    __weak typeof (scrollView) weakScrollView = scrollView;
    [scrollView vv_addObserver:scrollViewHelper
                    forKeyPath:@"contentOffset"
                       options:NSKeyValueObservingOptionNew
                     withBlock:^(NSDictionary * _Nonnull change,
                                 void * _Nonnull context) {
        [scrollViewHelper scrollViewDidSroll:weakScrollView
                  superViewInsetHeight:insetsHeight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ///将背景视图插到最底层
            [weakScrollView insertSubview:headerConfig.backgroundView
                                  atIndex:0];
            ///将顶部内容视图插到第二底层,防止覆盖cell,导致cell不能点击
            [weakScrollView insertSubview:headerConfig.frontView atIndex:1];
        });
    }];
}

- (void)scrollViewDidSroll:(UIScrollView *)scrollView
      superViewInsetHeight:(CGFloat)insetHeight {
    if (self.extraHeaderViewConfig) {
        CGRect frame = self.extraHeaderViewConfig.frontView.frame;
        CGPoint origin = frame.origin;
        CGSize size = frame.size;
        ///上拉，头部没有放大的时候，放大视图y原点 = 背景视图的原高度 - inset高度
        origin.y = - (CGRectGetHeight(frame) - insetHeight);
        ///  放大视图的高度等于放大视图的原始高度
        size.height = CGRectGetHeight(frame);
        ///下拉, 
        BOOL downPull = !(scrollView.contentOffset.y > - (CGRectGetHeight(frame) - insetHeight));
        ///放大
        BOOL expand = self.extraHeaderViewConfig.headerStyle == VVHeaderBackStyleExpand;
        if (downPull && expand) {
            ///下拉放大的时候，放大视图y原点 就是 scrollView的偏移量 （负值）
            origin.y = scrollView.contentOffset.y;
            ///  放大视图的高度 = 偏移量的绝对值 + inset高度
            size.height = - scrollView.contentOffset.y + insetHeight;
            
        }
        frame.origin = origin;
        frame.size = size;
        self.extraHeaderViewConfig.backgroundView.frame = frame;
    }
}


@end
