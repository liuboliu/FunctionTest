//
//  JKScrollHelper.m
//  JKUIHelper
//
//  Created by JackLee on 2018/5/30.
//

#import "JKScrollHelper.h"
#import <Aspects/Aspects.h>
#import "NSObject+VVKVOHelper.h"
#import <objc/runtime.h>

@interface JKScrollHelperView()

@property (nonatomic,weak) UIScrollView *jk_scrollHelper_Scroll;

@end;

@implementation JKScrollHelperView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.bounds, point)) {
        NSEnumerator *enumerator = [self.subviews reverseObjectEnumerator];

      for (UIView *subView in enumerator) {
          CGPoint tempoint = [subView convertPoint:point fromView:self];
         UIView *hitView = [subView hitTest:tempoint withEvent:event];
          if (subView == hitView) {
              break;
          }
          if (hitView) {
              return hitView;
              break;
          }
      }

        if (self.jk_scrollHelper_Scroll) {
            return self.jk_scrollHelper_Scroll;
        }
    }
    return [super hitTest:point withEvent:event];
}

@end

@implementation JKScrollExtraViewConfig


@end

@interface JKScrollHelper()

@property (nonatomic, assign)CGSize defautHeaderSize;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat contentInsetTop;
@property (nonatomic, assign) CGFloat contentInsetBottom;
@property (nonatomic, strong) JKScrollExtraViewConfig *extraHeaderViewConfig;
@property (nonatomic, assign) CGFloat offset;

@end

@implementation JKScrollHelper

+ (instancetype)initWithScrollView:(UIScrollView *)scrollView
                  headerViewCofnig:(JKScrollExtraViewConfig *)headerConfig
                      headerOffset:(CGFloat)offset
{
    JKScrollHelper *scrollViewHelper = [[self alloc] init];
    if(scrollViewHelper){
        scrollViewHelper.offset = offset;
        headerConfig.frontView.clipsToBounds = YES;
        headerConfig.frontView.jk_scrollHelper_Scroll = scrollView;
        headerConfig.backgroundView.clipsToBounds = YES;
        headerConfig.backgroundView.jk_scrollHelper_Scroll = scrollView;
        scrollViewHelper.extraHeaderViewConfig = headerConfig;
        
        CGRect frame = headerConfig.frontView.frame;
        CGPoint origin = frame.origin;
        origin.y = - (CGRectGetHeight(frame) - offset);
        frame.origin = origin;
        headerConfig.frontView.frame= frame;
        headerConfig.backgroundView.frame = frame;
        scrollViewHelper.scrollView = scrollView;
        
        
        scrollViewHelper.defautHeaderSize = frame.size;
        scrollViewHelper.contentInsetTop = frame.size.height-offset;
        scrollViewHelper.contentInsetBottom = 0;
        scrollView.contentInset = UIEdgeInsetsMake(scrollViewHelper.contentInsetTop, 0, scrollViewHelper.contentInsetBottom, 0);
        [scrollView setContentOffset:CGPointMake(0, -scrollViewHelper.contentInsetTop) animated:NO];
        scrollView.bouncesZoom = NO;
        [scrollView addSubview:headerConfig.backgroundView];
        [scrollView addSubview:headerConfig.frontView];
        __weak typeof(scrollView) weakScrollView = scrollView;

        if ([scrollView isKindOfClass:[UICollectionView class]] ) {
            [scrollView aspect_hookSelector:@selector(reloadData) withOptions:AspectPositionAfter usingBlock:^(){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakScrollView insertSubview:headerConfig.backgroundView atIndex:0];
                });
            } error:nil];
        } else if ([scrollView isKindOfClass:[UITableView class]]) {
            NSObject *presenter = scrollView.delegate;
            if ([presenter respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
                [self hookWillDisplayCellWithPresenter:presenter];
            } else {
                IMP tmpImp = [self methodForSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)];
                BOOL result = class_addMethod([presenter class], @selector(tableView:willDisplayCell:forRowAtIndexPath:),tmpImp, [@"v@:@@@" UTF8String]);
                if (result) {
                    [self hookWillDisplayCellWithPresenter:presenter];
                }
            }
        }
        [scrollView vv_addObserver:scrollViewHelper forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew withBlock:^(NSDictionary * _Nonnull change, void * _Nonnull context) {
            [scrollViewHelper scrollViewDidSroll:weakScrollView superViewInsetHeight:offset];
           // [weakScrollView insertSubview:headerConfig.backgroundView atIndex:0];
        }];
    }
    return scrollViewHelper;
}

- (void)scrollViewDidSroll:(UIScrollView *)scrollView
      superViewInsetHeight:(CGFloat)insetHeight {
   if (self.extraHeaderViewConfig) {
        CGRect frame = self.extraHeaderViewConfig.frontView.frame;
        CGPoint origin = frame.origin;
        CGSize size = frame.size;
        if (scrollView.contentOffset.y > - (CGRectGetHeight(frame) - self.offset)) {
            ///上拉，头部没有放大的时候，放大视图y原点 = 放大视图的高度 - inset高度
            origin.y = - (CGRectGetHeight(frame) - insetHeight);
            ///  放大视图的高度等于放大视图的原始高度
            size.height = CGRectGetHeight(frame);
        } else {
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

+ (void)hookWillDisplayCellWithPresenter:(NSObject *)presenter
{
    [presenter aspect_hookSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> data) {
        if (data.arguments.count < 2) {
            return;
        }
        UITableView *tableView = data.arguments.firstObject;
        UITableViewCell *cell = data.arguments[1];
        if (![tableView isKindOfClass:[UITableView class]] ||
            ![cell isKindOfClass:[UITableViewCell class]]) {
            return;
        }

        [tableView bringSubviewToFront:cell];
    } error:nil];
}

+ (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"执行执行之星");
}


@end
